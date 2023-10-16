import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:app_template/model.dart';

import 'package:app_template/widgets/base.dart';

class DeviceScreen extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceScreen({Key? key, required this.device}) : super(key: key);

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
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        List<int> value = await c.read();

        // dosageCharacteristic
        if (c.uuid.toString() == Device.dosageCharacteristic.toLowerCase()) {
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
        if (c.uuid.toString() == Device.dispenseCharacteristic.toLowerCase()) {
          setState(() {
            dispenseCharacteristic = value[0];
          });
        }
      }
    });
  }

  void dispense() async {
    List<BluetoothService> services = await widget.device.discoverServices();

    services.forEach((service) async {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        // dispenseCharacteristic
        if (c.uuid.toString() == Device.dispenseCharacteristic.toLowerCase()) {
          c.write([0]);
        }
      }
    });
  }

  void reset() async {
    List<BluetoothService> services = await widget.device.discoverServices();

    services.forEach((service) async {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        // resetCharacteristic
        if (c.uuid.toString() == Device.resetCharacteristic.toLowerCase()) {
          c.write([0]);
        }
      }
    });
  }

  void exit() {
    widget.device.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text("dosageCharacteristic: $dosageCharacteristic")),
        Center(
            child: Text(
                "batteryLevelCharacteristic: $batteryLevelCharacteristic")),
        Center(child: Text("dispenseCharacteristic: $dispenseCharacteristic")),
        MaterialButton(onPressed: dispense, child: const Text("Dispense")),
        MaterialButton(onPressed: reset, child: const Text("Reset"))
      ],
    ));
  }
}
