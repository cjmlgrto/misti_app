import 'package:app_template/model.dart';
import 'package:app_template/widgets/controls.dart';
import 'package:app_template/widgets/status.dart';
import 'package:app_template/widgets/usage.dart';
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

  void onGuidePressed() {
    print("Guide Pressed");
  }

  void onDispensePressed() {
    print("Dispense Pressed");
  }

  void onResetPressed() {
    print("Reset Pressed");
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
                      padding: const EdgeInsets.only(bottom: 16),
                      child: UsageStatus(
                          usage: UsageState.max, onHelpPressed: onHelpPressed),
                    )),
                    Expanded(
                      child: DeviceStatus(
                        status: DeviceState.connected,
                        batteryLevel: 90,
                        onConnectPressed: onConnectPressed,
                        onHelpPressed: onHelpPressed,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Controls(
                          onDispensePressed: onDispensePressed,
                          onResetPressed: onResetPressed),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        child: ElevatedButton(
                            onPressed: onGuidePressed,
                            style: ButtonStyles.buttonTertiary,
                            child: const Text("Getting Started Guide")),
                      ),
                    )
                  ])),
        ));
  }
}
