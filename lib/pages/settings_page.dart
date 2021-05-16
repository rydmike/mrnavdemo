import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods/app_state_pods.dart';
import 'grid_items.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline6 = textTheme.headline6!;
    return Consumer(builder: (context, watch, child) {
      debugPrint('Settings: Is logged in: ${watch(isLoggedInPod).state}');
      return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Center(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoSwitch(
                    value: watch(showBonusTab).state,
                    onChanged: (value) {
                      context.read(showBonusTab).state = value;
                    },
                  ),
                  SizedBox(width: 10),
                  Text('Show bonus tab'),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  context.read(isLoggedInPod).state = false;
                },
                child: Text('Log out'),
              ),
              const SizedBox(height: 16),
              Text('Colorful cards in a responsive GridView', style: headline6),
              const GridItems(),
            ],
          ),
        ),
      );
    });
  }
}
