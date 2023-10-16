import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:app_template/constants.dart';
import 'package:app_template/model.dart';

import 'package:app_template/widgets/base.dart';
import 'package:app_template/widgets/logo.dart';

import 'package:app_template/screens/device.dart';

class BluetoothController extends StatelessWidget {
  const BluetoothController({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.background,
      home: StreamBuilder<BluetoothAdapterState>(
          stream: FlutterBluePlus.adapterState,
          initialData: BluetoothAdapterState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothAdapterState.on) {
              return const DeviceScanner();
            }
            return const Base(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Logo(),
                Center(
                  child: Text(
                    "Enable Bluetooth to connect",
                    style: TextStyles.subtitle,
                  ),
                )
              ],
            ));
          }),
    );
  }
}

// Device Scanner Screen
// ------------------------------------------------------------
class DeviceScanner extends StatelessWidget {
  const DeviceScanner({Key? key}) : super(key: key);

  void scanAndConnect(BuildContext context) async {
    await FlutterBluePlus.startScan();
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (result.device.platformName == Device.name) {
          FlutterBluePlus.stopScan();
          result.device.connect();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DeviceScreen(device: result.device)));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    scanAndConnect(context);
    return const Base(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Logo(),
        Center(
          child: Text(
            "Connecting...",
            style: TextStyles.subtitle,
          ),
        )
      ],
    ));
  }
}
