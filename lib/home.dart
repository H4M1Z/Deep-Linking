import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), backgroundColor: Colors.blue),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to the Home Screen!'),
            ElevatedButton(
              onPressed: () {
                /// Share link
                final uri = 'https://bit.ly/3XNE8f2';
                Share.share('Join my session: $uri');
              },
              child: const Text('Go to Session Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
