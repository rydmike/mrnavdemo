import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods/app_state_pods.dart';
import '../widgets/dark_app_bar_style_switch.dart';
import '../widgets/light_app_bar_style_switch.dart';
import '../widgets/surface_style_switch.dart';
import '../widgets/theme_mode_switch.dart';
import '../widgets/theme_selector.dart';
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
              const SizedBox(height: 16),
              SwitchListTile.adaptive(
                title: Text('Show bonus tab'),
                value: watch(showBonusTab).state,
                onChanged: (value) {
                  context.read(showBonusTab).state = value;
                },
              ),
              ListTile(
                title: Text('Logout'),
                trailing: ElevatedButton(
                  onPressed: () {
                    context.read(isLoggedInPod).state = false;
                  },
                  child: Text('Log out'),
                ),
              ),
              const ThemeSelector(),
              const ListTile(title: Text('Theme mode')),
              const ListTile(trailing: ThemeModeSwitch()),
              const ListTile(title: Text('Surface branding')),
              const ListTile(trailing: SurfaceStyleSwitch()),
              const ListTile(title: Text('AppBar style')),
              ListTile(
                  trailing: Theme.of(context).brightness == Brightness.light
                      ? const LightAppBarStyleSwitch()
                      : const DarkAppBarStyleSwitch()),
              const SizedBox(height: 16),
              ListTile(title: Text('Colorful cards in a responsive GridView')),
              const GridItems(),
            ],
          ),
        ),
      );
    });
  }
}
