import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/screens/measure/widgets/status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';

import '../measure_screen.dart';

class SensorStatusCard extends StatefulWidget {
  final MeasureStatus status;

  const SensorStatusCard({super.key, required this.status});

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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeStyles.getMediaWidth(context, 0.8),
      decoration: ContainerStyles.card,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("센서 상태",
              style: MeasureTextStyles.sub.copyWith(
                fontSize: 18,
              )),
          StatusIndicator(status: widget.status),
        ],
      ),
    );
  }
}
