import 'package:app_template/widgets/status.dart';
import 'package:flutter/material.dart';
import 'package:app_template/constants.dart';

class StatusScreen extends StatelessWidget {
  final String text;

  const StatusScreen({super.key, required this.text});

  void onConnectPressed() {
    print("Connect Pressed");
  }

  void onHelpPressed() {
    print("Help Pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: DeviceStatus(
                          isConnected: false,
                          batteryLevel: 0,
                          onConnectPressed: onConnectPressed,
                          onHelpPressed: onHelpPressed,
                        ),
                      ),
                    ),
                    Expanded(
                      child: DeviceStatus(
                        isConnected: true,
                        batteryLevel: 90,
                        onConnectPressed: onConnectPressed,
                        onHelpPressed: onHelpPressed,
                      ),
                    )
                  ])),
        ));
  }
}
