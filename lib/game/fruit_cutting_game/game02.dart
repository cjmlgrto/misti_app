import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart' hide Game;
import 'package:misti/game/fruit_cutting_game/main_router_game.dart';
import 'package:misti/screens/demo.dart';
import 'package:flutter/services.dart'; // For SystemChrome
import 'package:shared_preferences/shared_preferences.dart'; // For storing the tutorial flag
import 'web_title_switcher_stub.dart'
    if (dart.library.html) 'web_title_switcher_web.dart';

class Game02 extends StatefulWidget {
  const Game02({super.key}); // Super key for navigation purposes.

  @override
  State<Game02> createState() => _Game02State();
}

class _Game02State extends State<Game02> {
  @override
  void initState() {
    super.initState();

    // Force landscape orientation and fullscreen for this screen
    Flame.device.fullScreen();
    Flame.device.setLandscape();

    // Show tutorial popup if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTutorialIfNeeded(context);
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Reset orientation to allow portrait mode when leaving this screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Flame.device.setPortrait();
  }

  Future<void> _showTutorialIfNeeded(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstOpen = prefs.getBool('hasSeenTutorial') ?? true;

    if (isFirstOpen) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const TutorialPopup(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Game widget (Main content)
          WebTitleSwitcher(
            child: GameWidget(
              game: MainRouterGame(),
            ),
          ),

          // Small clickable image positioned at the top-left corner
          Positioned(
            top: 15, // Set top position to 15
            left: (MediaQuery.of(context).size.width - 60) /
                2, // Center horizontally
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DemoScreen()),
                );
              },
              child: Image.asset(
                'assets/images/mainMenuButton.png', // Path to your image
                width: 68,
                height: 27,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TutorialPopup extends StatefulWidget {
  const TutorialPopup({super.key});

  @override
  State<TutorialPopup> createState() => _TutorialPopupState();
}

class _TutorialPopupState extends State<TutorialPopup> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Future<void> _markTutorialSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenTutorial', true);
  }

  @override
  Widget build(BuildContext context) {
    final tutorialSlides = [
      {'image': 'assets/images/tutorial1.png', 'text': 'Welcome to the game!'},
      {
        'image': 'assets/images/tutorial2.png',
        'text': 'Swipe up to kill viruses—you only have 4 lives!'
      },
      {
        'image': 'assets/images/tutorial3.png',
        'text': 'Avoid wrong targets—survive 10 levels to win!'
      },
    ];

    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: tutorialSlides.length,
                itemBuilder: (context, index) {
                  final slide = tutorialSlides[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(slide['image']!, height: 200),
                      const SizedBox(height: 20),
                      Text(
                        slide['text']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // "Skip Tutorial" button
                TextButton(
                  onPressed: () {
                    _markTutorialSeen();
                    Navigator.of(context).pop(); // Close the popup
                  },
                  style: TextButton.styleFrom(
                    foregroundColor:
                        const Color(0xFF04A1AB), // Button text color
                  ),
                  child: const Text('Skip Tutorial'),
                ),
                // "Back" and "Next/OK" buttons
                Row(
                  children: [
                    if (_currentPage > 0)
                      TextButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor:
                              const Color(0xFF04A1AB), // Button text color
                        ),
                        child: const Text('Back'),
                      ),
                    TextButton(
                      onPressed: () {
                        if (_currentPage < tutorialSlides.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _markTutorialSeen();
                          Navigator.of(context).pop(); // Close the popup
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor:
                            const Color(0xFF04A1AB), // Button text color
                      ),
                      child: Text(_currentPage < tutorialSlides.length - 1
                          ? 'Next'
                          : 'OK'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
