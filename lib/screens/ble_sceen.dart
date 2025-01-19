import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLECommunicationPage extends StatefulWidget {
  @override
  _BLECommunicationPageState createState() => _BLECommunicationPageState();
}

class _BLECommunicationPageState extends State<BLECommunicationPage> {
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? targetCharacteristic;

  final String targetDeviceName = "ESP32_BLE_Device"; // 디바이스 이름
  final Guid serviceUuid =
      Guid("4fafc201-1fb5-459e-8fcc-c5c9c331914b"); // SERVICE_UUID
  final Guid characteristicUuid =
      Guid("beb5483e-36e1-4688-b7f5-ea07361b26a8"); // CHARACTERISTIC_UUID

  String receivedData = "No data received"; // 수신된 데이터를 저장할 변수

  @override
  void initState() {
    super.initState();
    startScan();
  }

  /// BLE 디바이스 스캔 시작
  void startScan() async {
    FlutterBluePlus.startScan(
        timeout: Duration(seconds: 10), withServices: [serviceUuid]);

    FlutterBluePlus.scanResults.listen((results) async {
      for (ScanResult result in results) {
        if (result.device.name == targetDeviceName) {
          FlutterBluePlus.stopScan(); // 스캔 중지
          connectToDevice(result.device);
          break;
        }
      }
    });
  }

  /// 디바이스 연결
  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    setState(() {
      connectedDevice = device;
    });

    // 연결 상태 변화 감지
    device.connectionState.listen((connectionState) {
      if (connectionState == BluetoothConnectionState.disconnected) {
        setState(() {
          connectedDevice = null;
          targetCharacteristic = null;
        });
      }
    });

    discoverServices(device);
  }

  /// 서비스 및 특성 탐색
  void discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      if (service.uuid == serviceUuid) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid == characteristicUuid &&
              characteristic.properties.notify) {
            setNotify(characteristic);
            setState(() {
              targetCharacteristic = characteristic;
            });
          }
        }
      }
    }
  }

  /// 데이터 수신 알림 설정 및 처리
  void setNotify(BluetoothCharacteristic characteristic) async {
    await characteristic.setNotifyValue(true);
    characteristic.onValueReceived.listen((value) {
      print("onValueReceived Received Data: $value");
      setState(() {
        receivedData = String.fromCharCodes(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLE Data Receiver'),
      ),
      body: Center(
        child: connectedDevice == null
            ? Text('Scanning for devices...', style: TextStyle(fontSize: 18))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Connected to ${connectedDevice!.name}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  Text(
                    'Received Data:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    receivedData,
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  //  button for read data
                  ElevatedButton(
                      onPressed: () async {
                        List<int> data = await targetCharacteristic!.read();
                        print("Read Data: $data");
                        setState(() {
                          receivedData = String.fromCharCodes(data);
                        });
                      },
                      child: Text('Read Data'))
                ],
              ),
      ),
    );
  }
}
