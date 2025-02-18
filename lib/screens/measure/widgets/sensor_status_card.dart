import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/screens/measure/widgets/status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';

import '../measure_screen.dart';

class SensorStatusCard extends StatefulWidget {
  final MeasureStatus status;
  final Function(MeasureStatus status) setMeasureStatus;
  final Function(UsbPort port) setPort;

  const SensorStatusCard(
      {super.key,
      required this.status,
      required this.setMeasureStatus,
      required this.setPort});

  @override
  State<SensorStatusCard> createState() => _SensorStatusCardState();
}

class _SensorStatusCardState extends State<SensorStatusCard> {
  List<UsbDevice> devices = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readDevice();
  }

  readDevice() async {
    devices = await UsbSerial.listDevices();
    print("Devices: ");
    print(devices);
    // devices 에 특정 디바이스가있는지 확인
    // 있으면 ready, 없으면 disconnected
    if (devices.isEmpty) {
      widget.setMeasureStatus(MeasureStatus.disconnected);
      return;
    }
    UsbPort? port = await devices[0].create();
    if (port == null) {
      print("Failed to create port");
      return;
    }

    bool openResult = await port.open();
    if (!openResult) {
      print("Failed to open");
      return;
    }
    widget.setPort(port);
    widget.setMeasureStatus(MeasureStatus.ready);
  }

  @override
  Widget build(BuildContext context) {
    String mention =
        MeasureStatus.disconnected == widget.status ? "눌러서 재연결" : "센서 상태";
    return Container(
      width: SizeStyles.getMediaWidth(context, 0.8),
      decoration: ContainerStyles.card,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(mention,
              style: MeasureTextStyles.sub.copyWith(
                fontSize: 18,
              )),
          StatusIndicator(status: widget.status),
        ],
      ),
    );
  }
}
