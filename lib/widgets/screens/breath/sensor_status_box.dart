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
  StreamSubscription? deviceStream;
  bool isLoading = true;

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
    connectedDevice?.disconnect();
    deviceStream?.cancel();
    super.dispose();
  }

  /// BLE 디바이스 스캔 시작
  void startScan() {
    if (!mounted) return;
    try {
      setState(() {
        isLoading = true;
      });
      if (connectedDevice == null) {
        FlutterBluePlus.startScan(
            timeout: Duration(seconds: 10), withServices: [serviceUuid]);

        FlutterBluePlus.scanResults.listen((results) {
          for (ScanResult result in results) {
            if (result.device.platformName == targetDeviceName) {
              FlutterBluePlus.stopScan(); // 스캔 중지
              connectToDevice(result.device);
              break;
            }
          }
        });
      } else {
        discoverServices(connectedDevice!);
      }
    } catch (e) {
      log("ble센서연결에러" + e.toString());
      showSimpleAlert(context,
          title: "BLE센서 연결에러",
          content: "BLE센서 연결에러가 발생했습니다. 다시 시도해주세요.",
          errorText: e.toString());
    }
  }

  /// 디바이스 연결
  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    if (!mounted) return;
    setState(() {
      connectedDevice = device;
    });
    // 연결 상태 변화 감지
    deviceStream = device.connectionState.listen((connectionState) {
      if (connectionState == BluetoothConnectionState.disconnected) {
        setState(() {
          connectedDevice = null;
        });
        widget.onLostConnection();
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
            widget.onSensorAssigned(characteristic);
            setState(() {
              isLoading = false;
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isRecognized = widget.characteristic != null;
    return ElevatedButton(
      style: ButtonStyles.defaultElevated,
      onPressed: () {
        if (!isRecognized && !isLoading) {
          startScan();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isRecognized
                  ? "센서 상태"
                  : isLoading
                      ? "센서 연결 중.."
                      : "버튼을 눌러 다시 연결을 시도해 주세요",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 100),
            if (isRecognized) ...[
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
            ]
          ],
        ),
      ),
    );
  }
}
