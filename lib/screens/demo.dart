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

  void startFlappyBird(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Game01()),
    );
  }

  void startSuperJump(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Game01()), // Change to actual SuperJump game widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Base(
      child: SingleChildScrollView( // Wrap Column in SingleChildScrollView
        child: Column(
          children: [
            const Logo(),
            UsageStatus(dispenseCount: 0, onHelpPressed: action),
            DeviceStatus(
              status: DeviceState.connected,
              batteryLevel: 100,
              onHelpPressed: action,
            ),
            Controls(onDispensePressed: action, onResetPressed: action),
            Container(
              width: double.infinity,
              color: Colors.transparent,
              child: ElevatedButton(
                onPressed: action,
                style: ButtonStyles.buttonTertiary,
                child: const Text("Getting Started Guide"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                margin: const EdgeInsets.all(7),  // Margin of 10px
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20), // Padding of 10px on top, left, right, and 20px on the bottom
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F4FA), // Blue background color
                  borderRadius: BorderRadius.circular(8), // Rounded corners with radius 4px
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the left
                  children: [
                    const Text(
                      "Misti Games",
                      style: TextStyle(
                        color: Colors.black,  // Black text color
                        fontSize: 28,  // Font size for title
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),  // Spacing between title and game tiles
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GameTile(
                          imagePath: 'assets/images/flappy.png',
                          gameTitle: 'Baby Bounce',
                          onTap: () => startFlappyBird(context),
                        ),
                        GameTile(
                          imagePath: 'assets/images/superjump.png',
                          gameTitle: 'Coming soon',
                          onTap: () => startSuperJump(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class GameTile extends StatelessWidget {
  final String imagePath;
  final String gameTitle;
  final VoidCallback onTap;

  const GameTile({
    required this.imagePath,
    required this.gameTitle,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10), // Space from the bottom
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,  // Left and right padding
                      vertical: 10,    // Top and bottom padding
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),  // Semi-transparent background
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      gameTitle,
                      style: const TextStyle(
                        color: Colors.white,  // White text color for contrast
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

}
