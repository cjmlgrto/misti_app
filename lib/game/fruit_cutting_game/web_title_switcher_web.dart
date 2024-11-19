// web_title_switcher_web.dart

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter/material.dart';

class WebTitleSwitcher extends StatefulWidget {
  const WebTitleSwitcher({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  State<WebTitleSwitcher> createState() => _WebTitleSwitcherWebState();
}

class _WebTitleSwitcherWebState extends State<WebTitleSwitcher> {
  bool _isTabActive = true;

  @override
  void initState() {
    super.initState();
    // Register blur and focus events
    html.window.addEventListener('blur', _handleBlurEvent);
    html.window.addEventListener('focus', _handleFocusEvent);

    // A2HS functionality
    listenToBeforeInstallPromptEvent();
  }

  @override
  void dispose() {
    // Remove event listeners
    html.window.removeEventListener('blur', _handleBlurEvent);
    html.window.removeEventListener('focus', _handleFocusEvent);
    super.dispose();
  }

  void _handleBlurEvent(html.Event event) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isTabActive = false;
        });
        _updateTabTitle();
      }
    });
  }

  void _handleFocusEvent(html.Event event) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isTabActive = true;
        });
        _updateTabTitle();
      }
    });
  }

  void _updateTabTitle() {
    final String title = _isTabActive ? "ChunhThanhDe - Fruit Cutting Game 🍎" : "Contact to cooperate 🍎";
    html.document.title = title;
  }

  void listenToBeforeInstallPromptEvent() {
    html.window.on['beforeinstallprompt'].listen((event) {
      // Prevent the mini-infobar from appearing on mobile
      event.preventDefault();

      // Create an install button
      html.ButtonElement installButton = html.ButtonElement()
        ..text = "Add to Home Screen"
        ..style.position = "fixed"
        ..style.bottom = "10px"
        ..style.left = "10px";

      // Add the button to the body
      html.document.body?.append(installButton);

      // When the button is clicked, trigger the prompt
      installButton.onClick.listen((_) {
        js.JsObject.fromBrowserObject(event).callMethod('prompt');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
