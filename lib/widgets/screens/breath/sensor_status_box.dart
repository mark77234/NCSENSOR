import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../constants/styles.dart';
import '../../common/simple_alert_dialog.dart';

class SensorStatusBox extends StatefulWidget {
  const SensorStatusBox({
    super.key,
    required this.onSensorAssigned,
    required this.onLostConnection,
    required this.characteristic,
  });

  final void Function(BluetoothCharacteristic characteristic) onSensorAssigned;
  final void Function() onLostConnection;
  final BluetoothCharacteristic? characteristic;

  @override
  State<SensorStatusBox> createState() => _SensorStatusBoxState();
}

class _SensorStatusBoxState extends State<SensorStatusBox> {
  BluetoothDevice? connectedDevice;
  StreamSubscription? deviceConnectStream;
  StreamSubscription? deviceScanStream;
  StreamSubscription? isScanningStream;

  bool isScanning = true;

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

  @override
  void dispose() {
    _cancelAll();
    log("dispose SensorStatusBox");
    super.dispose();
  }

  _cancelAll() {
    connectedDevice?.disconnect();
    deviceConnectStream?.cancel();
    deviceScanStream?.cancel();
    isScanningStream?.cancel();
  }

  /// BLE 디바이스 스캔 시작
  Future<void> startScan() async {
    if (!mounted) return;
    try {
      setState(() {
        isScanning = true;
      });
      if (connectedDevice == null) {
        log("startScan");
        bool isConnecting = false;
        await FlutterBluePlus.startScan(
            timeout: Duration(seconds: 10), withServices: [serviceUuid]);

        deviceScanStream = FlutterBluePlus.scanResults.listen((results) {
          for (ScanResult result in results) {
            log("BLE센서결과${result.device.platformName}");
            if (result.device.platformName == targetDeviceName) {
              FlutterBluePlus.stopScan(); // 스캔 중지
              isConnecting = true;
              connectToDevice(result.device);
              break;
            }
          }
        }, onError: ((e, s) {
          _errorHandler(e, s);
        }), onDone: () {
          log("스캔완료");
          if (!isConnecting) {
            setState(() {
              isScanning = false;
            });
            showSimpleAlert(context,
                title: "센서없음", content: "연결할 수 있는 센서가 없습니다. 다시 시도해주세요.");
          }
        });
      } else {
        discoverServices(connectedDevice!);
      }
    } catch (e, s) {
      _errorHandler(e, s, fnName: "startScan");
    }
  }

  /// 디바이스 연결
  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      if (!mounted) return;
      connectedDevice = device;
      // 연결 상태 변화 감지
      deviceConnectStream = device.connectionState.listen((connectionState) {
        if (connectionState == BluetoothConnectionState.disconnected) {
          connectedDevice = null;
          widget.onLostConnection();
        }
      }, onError: (e, s) {
        _errorHandler(e, s, fnName: "deviceConnectStream");
      }, onDone: () {
        connectedDevice = null;
        widget.onLostConnection();
        _cancelAll();
      });
    } catch (e, s) {
      _errorHandler(e, s, fnName: "connectToDevice");
    }
    discoverServices(device);
  }

  /// 서비스 및 특성 탐색
  void discoverServices(BluetoothDevice device) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        if (service.uuid == serviceUuid) {
          for (BluetoothCharacteristic characteristic
              in service.characteristics) {
            if (characteristic.uuid == characteristicUuid) {
              //set read
              log(characteristic.properties.toString());
              widget.onSensorAssigned(characteristic);
              setState(() {
                isScanning = false;
              });
            }
          }
        }
      }
    } catch (e, s) {
      _errorHandler(e, s, fnName: "discoverServices");
    }
  }

  void _errorHandler(e, s, {String? fnName}) {
    print('Stack trace: $s');
    if (!mounted) return;
    setState(() {
      isScanning = false;
    });
    connectedDevice = null;
    _cancelAll();
    log("함수 : ${fnName ?? ""}");
    log("ble센서연결에러 " + e.toString());
    showSimpleAlert(context,
        title: "BLE센서 연결에러",
        content: "BLE센서 연결에러가 발생했습니다. 다시 시도해주세요.",
        errorText: e.toString());
  }

  @override
  Widget build(BuildContext context) {
    bool isRecognized = widget.characteristic != null;
    return ElevatedButton(
      style: ButtonStyles.greyOutLined,
      onPressed: !isRecognized && !isScanning ? startScan : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isRecognized) ...[
            Text(
              "센서 상태",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 100),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: ColorStyles.primary,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              "인식완료",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorStyles.primary,
              ),
            ),
          ] else ...[
            Flexible(
              child: Text(
                isScanning ? "센서 연결 중.." : "버튼을 눌러 다시 연결을 시도해 주세요",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
