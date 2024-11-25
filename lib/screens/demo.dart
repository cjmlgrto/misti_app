import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome
import 'package:misti/constants.dart';
import 'package:misti/game/flappyBirdGame/game01.dart';
import 'package:misti/game/fruit_cutting_game/game02.dart';
import 'package:misti/model.dart';
import 'package:misti/widgets/base.dart';
import 'package:misti/widgets/controls.dart';
import 'package:misti/widgets/logo.dart';
import 'package:misti/widgets/status.dart';
import 'package:misti/widgets/usage.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  void initState() {
    super.initState();

    // Enforce portrait orientation on this screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Restore orientation preferences when leaving this screen
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

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
      MaterialPageRoute(
          builder: (context) =>
              const Game02()), // Change to actual SuperJump game widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Base(
      child: SingleChildScrollView(
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
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F4FA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Misti Games",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                          gameTitle: 'Virus Vanquisher',
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
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      gameTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
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
