import 'package:app_template/screens/help.dart';
import 'package:app_template/model.dart';
import 'package:app_template/widgets/controls.dart';
import 'package:app_template/widgets/status.dart';
import 'package:app_template/widgets/usage.dart';
import 'package:flutter/material.dart';
import 'package:app_template/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DeviceState deviceState = DeviceState.off;
  UsageState usageState = UsageState.none;
  int batteryLevel = 0;

  void onConnectPressed() {
    setState(() {
      batteryLevel = 100;
      deviceState = DeviceState.connected;
    });
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
                    if (deviceState == DeviceState.connected)
                      Expanded(
                          child: UsageStatus(
                              usage: usageState,
                              onHelpPressed: onGuidePressed)),
                    Expanded(
                      child: DeviceStatus(
                        status: deviceState,
                        batteryLevel: batteryLevel,
                        onConnectPressed: onConnectPressed,
                        onHelpPressed: onHelpPressed,
                      ),
                    ),
                    if (deviceState == DeviceState.connected)
                      Controls(
                          onDispensePressed: onDispensePressed,
                          onResetPressed: onResetPressed),
                    Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: ElevatedButton(
                          onPressed: onStarterGuidePressed,
                          style: ButtonStyles.buttonTertiary,
                          child: const Text("Getting Started Guide")),
                    )
                  ])),
        ));
  }
}
