import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:misti/screens/demo.dart';
import 'package:flutter/services.dart'; // Import to control system settings
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter engine is initialized

  // Force portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Handle permissions for Android
  if (Platform.isAndroid) {
    await requestPermissions();
  }

  // Start the app
  runApp(const MainApp());
}

/// Function to request permissions
Future<void> requestPermissions() async {
  // List of required permissions
  final permissions = [
    Permission.location,
    Permission.storage,
    Permission.bluetooth,
    Permission.bluetoothConnect,
    Permission.bluetoothScan,
  ];

  // Request permissions
  final statuses = await permissions.request();

  // Check for denied permissions
  statuses.forEach((permission, status) {
    if (status.isDenied || status.isPermanentlyDenied) {
      print('Permission ${permission.toString()} denied.');
      // Optionally show a dialog or guide user to enable permissions manually
    }
  });
}

/// Main App Widget
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      home: DemoScreen(), // Change to your desired home screen
    );
  }
}
