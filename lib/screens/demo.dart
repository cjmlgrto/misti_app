import 'package:flutter/material.dart';

import 'package:misti/constants.dart';
import 'package:misti/game/flappyBirdGame/game01.dart';
import 'package:misti/model.dart';

import 'package:misti/widgets/base.dart';
import 'package:misti/widgets/controls.dart';
import 'package:misti/widgets/logo.dart';
import 'package:misti/widgets/status.dart';
import 'package:misti/widgets/usage.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  void action() {}

  void startGame(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Game01()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: Column(
      children: [
        const Logo(),
        UsageStatus(dispenseCount: 0, onHelpPressed: action),
        Expanded(
            child: DeviceStatus(
                status: DeviceState.connected,
                batteryLevel: 100,
                onHelpPressed: action)),
        Controls(onDispensePressed: action, onResetPressed: action),
        Container(
          width: double.infinity,
          color: Colors.transparent,
          child: ElevatedButton(
              onPressed: action,
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
