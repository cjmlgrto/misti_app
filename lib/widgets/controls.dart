import 'package:flutter/material.dart';
import 'package:misti/constants.dart';

class Controls extends StatelessWidget {
  final void Function() onDispensePressed;
  final void Function() onResetPressed;

  const Controls(
      {super.key,
      required this.onDispensePressed,
      required this.onResetPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(
                  onPressed: onDispensePressed,
                  style: ButtonStyles.buttonPrimary.copyWith(
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0))),
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.all(24.0)),
                      backgroundColor: const WidgetStatePropertyAll<Color>(
                          AppColors.surfacePrimary)),
                  child: const Text("Dispense")),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ElevatedButton(
                  onPressed: onResetPressed,
                  style: ButtonStyles.buttonSecondary.copyWith(
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0))),
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.all(24.0)),
                      backgroundColor: const WidgetStatePropertyAll<Color>(
                          AppColors.surfaceSecondary)),
                  child: const Text("Reset")),
            ),
          ),
        ],
      ),
    );
  }
}
