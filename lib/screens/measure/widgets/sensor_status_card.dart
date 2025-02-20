import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/screens/measure/widgets/status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';

import '../measure_screen.dart';

class SensorStatusCard extends StatefulWidget {
  final MeasureStatus status;
  final Function(MeasureStatus status) setMeasureStatus;
  final Function(UsbPort port) setPort;

  const SensorStatusCard({
    super.key,
    required this.status,
    required this.setMeasureStatus,
    required this.setPort,
  });

  @override
  State<SensorStatusCard> createState() => _SensorStatusCardState();
}

class _SensorStatusCardState extends State<SensorStatusCard> {
  List<UsbDevice> devices = [];

  @override
  void initState() {
    super.initState();
    readDevice();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(
                MeasureStatus.ready == widget.status
                    ? Icons.usb
                    : Icons.usb_off,
                color: MeasureStatus.ready == widget.status
                    ? ColorStyles.primary
                    : Colors.redAccent),
            SizedBox(width: 8),
            Text(
              "센서 상태",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  readDevice() async {
    try {
      devices = await UsbSerial.listDevices();
      if (devices.isEmpty) {
        widget.setMeasureStatus(MeasureStatus.disconnected);
        throw Exception("기기를 찾을 수 없습니다.");
      }
      UsbPort? port = await devices[0].create();
      if (port == null) {
        throw Exception("센서가 정상적으로 인식되지 않습니다");
      }

      bool openResult = await port.open();
      if (!openResult) {
        throw Exception("센서가 정상적으로 인식되지 않습니다");
      }
      widget.setPort(port);
      widget.setMeasureStatus(MeasureStatus.ready);
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    String mention =
        MeasureStatus.disconnected == widget.status ? "눌러서 재연결" : "센서 상태";
    return GestureDetector(
      onTap: () {
        readDevice();
      },
      child: Container(
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
      ),
    );
  }
}
