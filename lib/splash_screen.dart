import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  ///STREAM TO LISTEN TO THE LINKS
  StreamSubscription? _linkSub;

  ///VARIABLE TO CHECK IF THE DEEP LINK IS HANDLED OR NOT
  bool _handledDeepLink = false;
  /* -------------------------------------------------------------------------- */
  /*                                   METHODS                                  */
  /* -------------------------------------------------------------------------- */

  /* -------------------- USING APP LINKS FOR DEEP LINKING -------------------- */

  void initDeepLinkListener() {
    // Handle when app is in background/foreground
    _linkSub = AppLinks().uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleLink(uri);
      }
    });
  }

  void _handleLink(Uri uri) {
    try {
      debugPrint('Received deep link: $uri');

      // Accept both schemes: 'dinnduh' and 'https'
      final isValidScheme = uri.scheme == 'dinnduh' || uri.scheme == 'https';
      final isValidHost = uri.host == 'session';
      final hasPathSegment = uri.pathSegments.isNotEmpty;

      if (isValidScheme && isValidHost && hasPathSegment) {
        final sessionId = uri.pathSegments[0];
        debugPrint('Received session id: $sessionId');
        _handledDeepLink = true;

        context.push('/session/$sessionId');
        debugPrint('Redirecting to session screen');
      } else {
        debugPrint('Invalid deep link structure');
      }
    } catch (e) {
      debugPrint('Error handling app link: $e');
    }
  }

  @override
  void initState() {
    initDeepLinkListener();
    Future.delayed(const Duration(seconds: 3), () {
      if (_handledDeepLink) {
        return; // Do not navigate if a deep link was handled
      }
      context.go('/home');
    });

    super.initState();
  }

  @override
  void dispose() {
    _linkSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('Welcome to the Splash Screen!'), const SizedBox(height: 20), CircularProgressIndicator()],
        ),
      ),
      backgroundColor: Colors.blue,
    );
  }
}
