import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'grid_items.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline6 = textTheme.headline6!;
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
                  value: appState.showBonusTab,
                  onChanged: (value) {
                    appState.showBonusTab = value;
                  },
                ),
                SizedBox(width: 10),
                Text('Show bonus tab'),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => Provider.of<AppState>(context, listen: false)
                  .isLoggedIn = false,
              child: Text('Log out'),
            ),
            const SizedBox(height: 16),
            Text('Colorful cards in a responsive GridView', style: headline6),
            const GridItems(),
          ],
        ),
      ),
    );
  }
}
