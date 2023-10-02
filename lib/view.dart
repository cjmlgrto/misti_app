import 'package:app_template/help.dart';
import 'package:app_template/model.dart';
import 'package:app_template/widgets/controls.dart';
import 'package:app_template/widgets/status.dart';
import 'package:app_template/widgets/usage.dart';
import 'package:flutter/material.dart';
import 'package:app_template/constants.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  void onConnectPressed() {
    print("Connect Pressed");
  }

  void onHelpPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HelpScreen(
                helpTitle: Strings.deviceHelpTitle,
                helpText: Strings.deviceHelpText)));
  }

  void onGuidePressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HelpScreen(
                helpTitle: Strings.usageGuideTitle,
                helpText: Strings.deviceHelpText)));
  }

  void onStarterGuidePressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HelpScreen(
                helpTitle: Strings.gettingStartedGuideTitle,
                helpText: Strings.deviceHelpText)));
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
                          usage: UsageState.max, onHelpPressed: onGuidePressed),
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
                            onPressed: onStarterGuidePressed,
                            style: ButtonStyles.buttonTertiary,
                            child: const Text("Getting Started Guide")),
                      ),
                    )
                  ])),
        ));
  }
}
