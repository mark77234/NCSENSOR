import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BltTestScreen extends StatefulWidget {
  const BltTestScreen({super.key});

  @override
  State<BltTestScreen> createState() => _BltTestScreenState();
}

// 상태 블루투스 지원안됨 > 블루투스켜기 > 디바이스 찾기 > 연결 > 데이터수신

class _BltTestScreenState extends State<BltTestScreen> {
  BluetoothDevice? device;
  BluetoothCharacteristic? characteristic;
  StreamSubscription? subscription;
  bool isScanning = false; // 디바이스 스케닝 여부
  bool isBluetoothOn = false; // 블루투스 켜짐 여부
  bool isConnecting = false; // 통신 여부
  String receivedData = "";

  static const String SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  static const String CHARACTERISTIC_UUID =
      "beb5483e-36e1-4688-b7f5-ea07361b26a8";

  @override
  void initState() {
    super.initState();
    _checkBluetoothState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    device?.disconnect();
    super.dispose();
  }

  Future<void> _startScan() async {
    setState(() {
      isScanning = true;
    });

    // 블루투스 스캔 시작
    await FlutterBluePlus.startScan(timeout: Duration(seconds: 20));
    // 스캔 결과 리스닝
    FlutterBluePlus.scanResults.listen((results) async {
      for (ScanResult result in results) {
        String name = result.device.platformName;
        String id = result.device.id.toString();
        int rssi = result.rssi;
        List<Guid> serviceId = result.advertisementData.serviceUuids;
        log("Device name: $name / id: $id / rssi: $rssi / serviceId: ${serviceId.toString()}");
        //ESP32_BLE_Device  48:CA:43:D4:36:AE [4fafc201-1fb5-459e-8fcc-c5c9c331914b]
        //todo : 만약 타겟디바이스를 발견하면 스캔을 멈추고 디바이스와 연결한다.
        if (serviceId.contains(Guid(SERVICE_UUID))) {
          log("디바이스연결 완! 료!");
          await result.device.connect();
          setState(() {
            device = result.device;
            isScanning = false;
          });
          return;
        }

        // await result.device.connect();

        // 나중에 지울것
        // result.device.connectionState
        //     .listen((BluetoothConnectionState state) async {
        //   log("Connection state: $state");
        //   if (state == BluetoothConnectionState.connected) {
        //     log("Connected to ${result.device}");
        //     await _isTargetDevice(result.device);
        //   }
        // });

        // 디바이스와 연결
        // result.device.connect().then((_) async {
        //   isConnecting = true;
        //   await _checkConnection();
        //   if (await _isTargetDevice(result.device)) {
        //     FlutterBluePlus.stopScan();
        //     setState(() {
        //       device = result.device;
        //       isScanning = false;
        //     });
        //     isConnecting = false;
        //     return;
        //   }
        // });
      }
    });

    setState(() {
      isScanning = false;
    });

    // 스캔 중지
  }

  // Future<bool> _isTargetDevice(BluetoothDevice device) async {
  //   try {
  //     // 디바이스가 연결되어 있는지 확인
  //     var connectedDevices = await FlutterBluePlus.connectedDevices;
  //     if (connectedDevices.contains(device)) {
  //       // 디바이스가 연결되어 있으면 서비스 검색
  //       var services = await device.discoverServices();
  //       // 디바이스가 타겟 디바이스인지 확인하는 로직
  //       return services.any((service) {
  //         log("Service UUID: ${service.uuid}");
  //         return service.uuid.toString() == SERVICE_UUID;
  //       });
  //     } else {
  //       log('디바이스가 연결되어 있지 않습니다');
  //       return false;
  //     }
  //   } catch (e) {
  //     log('서비스 검색 중 오류 발생: $e');
  //     return false;
  //   }
  // }

  Future<void> _connectingService() async {
    if (device == null) return;
    if (isConnecting) {
      subscription?.cancel();
      setState(() {
        isConnecting = false;
      });
    } else {
      List<BluetoothService> services = await device!.discoverServices();
      for (BluetoothService service in services) {
        if (service.uuid.toString() == SERVICE_UUID) {
          for (BluetoothCharacteristic c in service.characteristics) {
            if (c.uuid.toString() == CHARACTERISTIC_UUID) {
              characteristic = c;
              setState(() {
                isConnecting = true;
              });
              return;
            }
          }
        }
      }
    }
  }

  void _disconnect() {
    device!.disconnect();
    setState(() {
      device = null;
      characteristic = null;
      receivedData = "";
    });
  }

  // void _subscribe() {
  //   setState(() {
  //     isConnecting = true;
  //   });
  //   subscription!.onDone(() {
  //     setState(() {
  //       isConnecting = false;
  //     });
  //   });
  // }

  Future<void> _checkBluetoothState() async {
    try {
      // 블루투스 상태 확인
      bool isAvailable = await FlutterBluePlus.isAvailable;
      if (!isAvailable) {
        setState(() => isBluetoothOn = false);
        return;
      }

      // 블루투스 켜짐 여부 확인
      bool isOn = await FlutterBluePlus.isOn;
      setState(() => isBluetoothOn = isOn);

      // if (isOn) {
      //   _checkConnection();
      // }
    } catch (e) {
      print('Error checking bluetooth state: $e');
    }
  }

  Future<void> _turnOnBluetooth() async {
    try {
      // Android에서만 작동
      await FlutterBluePlus.turnOn();
      setState(() => isBluetoothOn = true);
    } catch (e) {
      print('Error turning on bluetooth: $e');
      // iOS의 경우 설정으로 이동하도록 안내
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('블루투스 설정'),
          content: Text('설정에서 블루투스를 켜주세요.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('확인'),
            ),
          ],
        ),
      );
    }
  }

  // ... 기존의 다른 메소드들 유지 ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("블루투스 테스트"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatusCard(),
            SizedBox(height: 16),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "상태:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _getStatusMessage(),
            style: TextStyle(fontSize: 16),
          ),
          if (device != null && characteristic != null && isConnecting) ...[
            //   streambuilder로 변경
            // SizedBox(height: 16),
            // Text(
            //   "수신 데이터:",
            //   style: TextStyle(
            //     fontSize: 14,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 8),
            // Text(
            //   receivedData,
            //   style: TextStyle(fontSize: 16),
            // ),
            StreamBuilder(
                stream: characteristic!.lastValueStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  if (snapshot.hasData) {
                    return Text(snapshot.data.toString());
                  }
                  return Text("No data");
                })
          ],
        ],
      ),
    );
  }

  String _getStatusMessage() {
    if (!isBluetoothOn) return "블루투스가 꺼져 있습니다.";
    if (device == null && !isScanning) return "디바이스를 검색해주세요.";
    if (isScanning) return "디바이스 검색 중...";
    if (device != null && isConnecting)
      return "디바이스 연결 ${device!.platformName} 통신중..";
    return "디바이스 연결 ${device!.platformName}";
  }

  Widget _buildActionButton() {
    if (!isBluetoothOn) {
      return ElevatedButton(
        onPressed: _turnOnBluetooth,
        child: Text("블루투스 켜기"),
      );
    }

    if (device == null) {
      return ElevatedButton(
        onPressed: isScanning ? null : _startScan,
        child: Text(isScanning ? "검색 중..." : "디바이스 검색"),
      );
    }

    return Column(
      children: [
        ElevatedButton(
          onPressed: _connectingService,
          child: Text(isConnecting ? "데이터 수신 정지" : "데이터 수신 시작"),
        ),
        ElevatedButton(
          onPressed: _disconnect,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text("연결 해제"),
        ),
      ],
    );
  }
}
