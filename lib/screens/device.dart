import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:misti/model.dart';
import 'package:misti/constants.dart';

import 'package:misti/widgets/base.dart';
import 'package:misti/widgets/logo.dart';
import 'package:misti/widgets/usage.dart';
import 'package:misti/widgets/status.dart';
import 'package:misti/widgets/controls.dart';

import 'package:misti/screens/help.dart';

import 'package:misti/game/oldFappyBirdCode/game.dart';

class DeviceScreen extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceScreen({super.key, required this.device});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  late Timer _timer;

  int dosageCharacteristic = 0;
  int batteryLevelCharacteristic = 0;
  int dispenseCharacteristic = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      update();
    });
  }

  void update() async {
    List<BluetoothService> services = await widget.device.discoverServices();

    services.forEach((service) async {
      if (service.uuid.toString() == Device.service.toLowerCase()) {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.properties.read) {
            List<int> value = await c.read();

            // dosageCharacteristic
            if (c.uuid.toString() ==
                Device.dosageCharacteristic.toLowerCase()) {
              setState(() {
                dosageCharacteristic = value[0];
              });
            }

            // batteryLevelCharacteristic
            if (c.uuid.toString() ==
                Device.batteryLevelCharacteristic.toLowerCase()) {
              setState(() {
                batteryLevelCharacteristic = value[0];
              });
            }

            // dispenseCharacteristic
            if (c.uuid.toString() ==
                Device.dispenseCharacteristic.toLowerCase()) {
              setState(() {
                dispenseCharacteristic = value[0];
              });
            }
          }
        }
      }
    });
  }

  void dispense() async {
    List<BluetoothService> services = await widget.device.discoverServices();

    services.forEach((service) async {
      if (service.uuid.toString() == Device.service.toLowerCase()) {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          // dispenseCharacteristic
          if (c.uuid.toString() ==
              Device.dispenseCharacteristic.toLowerCase()) {
            c.write([0]);
          }
        }
      }
    });
  }

  void reset() async {
    List<BluetoothService> services = await widget.device.discoverServices();

    services.forEach((service) async {
      if (service.uuid.toString() == Device.service.toLowerCase()) {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          // resetCharacteristic
          if (c.uuid.toString() == Device.resetCharacteristic.toLowerCase()) {
            c.write([0]);
          }
        }
      }
    });
  }

  void onDosageGuidePressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HelpScreen(
                helpTitle: Strings.dosageGuideTitle,
                helpText: Strings.genericHelpText)));
  }

  void onDeviceHelpPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HelpScreen(
                helpTitle: Strings.deviceHelpTitle,
                helpText: Strings.genericHelpText)));
  }

  void onStarterGuidePressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HelpScreen(
                helpTitle: Strings.gettingStartedGuideTitle,
                helpText: Strings.genericHelpText)));
  }

  void exit() {
    widget.device.disconnect();
  }

  void startGame(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => const GameHomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: Column(
      children: [
        const Logo(),
        UsageStatus(
            dispenseCount: dosageCharacteristic,
            onHelpPressed: onDosageGuidePressed),
        Expanded(
            child: DeviceStatus(
                status: DeviceState.connected,
                batteryLevel: batteryLevelCharacteristic,
                onHelpPressed: onDeviceHelpPressed)),
        Controls(onDispensePressed: dispense, onResetPressed: reset),
        Container(
          width: double.infinity,
          color: Colors.transparent,
          child: ElevatedButton(
              onPressed: onStarterGuidePressed,
              style: ButtonStyles.buttonTertiary,
              child: const Text("Getting Started Guide")),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Container(
            width: double.infinity,
            color: Colors.transparent,
            child: ElevatedButton(
                onPressed: () => startGame(context),
                style: ButtonStyles.buttonTertiary,
                child: const Text("Start Game")),
          ),
        )
      ],
    ));
  }
}
