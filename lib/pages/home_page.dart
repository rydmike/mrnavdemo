import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../pods/app_state_pods.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabState = CupertinoTabPage.of(context);
    return Consumer(builder: (context, watch, child) {
      return CupertinoTabScaffold(
        controller: tabState.controller,
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Feed',
              icon: Icon(CupertinoIcons.list_bullet),
            ),
            BottomNavigationBarItem(
              label: 'Search',
              icon: Icon(CupertinoIcons.search),
            ),
            if (watch(showBonusTab).state)
              BottomNavigationBarItem(
                label: 'Bonus!',
                icon: Icon(CupertinoIcons.exclamationmark),
              ),
            BottomNavigationBarItem(
              label: 'Notifications',
              icon: Icon(CupertinoIcons.bell),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(CupertinoIcons.settings),
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return PageStackNavigator(stack: tabState.stacks[index]);
        },
      );
    });
  }
}
