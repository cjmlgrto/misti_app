import 'package:flutter/material.dart';
import 'package:app_template/constants.dart';

class Controls extends StatelessWidget {
  final void Function() onDispensePressed;
  final void Function() onResetPressed;

  const Controls(
      {super.key,
      required this.onDispensePressed,
      required this.onResetPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
                onPressed: onDispensePressed,
                style: ButtonStyles.buttonPrimary.copyWith(
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0))),
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.all(24.0)),
                    backgroundColor: const MaterialStatePropertyAll<Color>(
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
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0))),
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.all(24.0)),
                    backgroundColor: const MaterialStatePropertyAll<Color>(
                        AppColors.surfaceSecondary)),
                child: const Text("Reset")),
          ),
        ),
      ],
    );
  }
}
