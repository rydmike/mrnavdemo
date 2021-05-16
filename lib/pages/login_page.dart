import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods/app_state_pods.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    debugPrint('Login: Is logged in: ${watch(isLoggedInPod).state}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read(isLoggedInPod).state = true;
              },
              child: Text('Log in'),
            ),
          ],
        ),
      ),
    );
  }
}
