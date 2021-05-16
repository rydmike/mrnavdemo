import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../pods/app_state_pods.dart';

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);
    return Consumer(builder: (context, watch, child) {
      return Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: tabPage.controller,
            tabs: [
              Tab(
                icon: Icon(Icons.directions_car),
                text: 'Home',
              ),
              if (watch(showBonusTab).state)
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: 'Bonus',
                ),
              Tab(
                icon: Icon(Icons.directions_car),
                text: 'Settings',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabPage.controller,
          children: [
            for (final stack in tabPage.stacks)
              PageStackNavigator(stack: stack),
          ],
        ),
      );
    });
  }
}
