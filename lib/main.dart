import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'pages/bottom_navigation_bar_page.dart';
import 'pages/feed_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/notifications_page.dart';
import 'pages/search_page.dart';
import 'pages/settings_page.dart';
import 'pages/tab_bar_page.dart';
import 'pods/app_state_pods.dart';
import 'pods/theme_pods.dart';

void main() {
  Routemaster.setPathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

/// Title observer that updates the app's title when the route changes
/// This shows in a browser tab's title.
class TitleObserver extends RoutemasterObserver {
  @override
  void didChangeRoute(RouteData routeData, Page page) {
    if (page.name != null) {
      SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(label: page.name),
      );
    }
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp.router(
      title: 'Routemaster Demo',
      debugShowCheckedModeBanner: false,
      theme: watch(lightThemePod).state,
      darkTheme: watch(darkThemePod).state,
      themeMode: watch(themeModePod).state,
      routeInformationParser: RoutemasterParser(),
      routerDelegate: RoutemasterDelegate(
        observers: [TitleObserver()],
        routesBuilder: (BuildContext context) {
          final bool _isLoggedIn = watch(isLoggedInPod).state;
          final bool _showBonusTab = watch(showBonusTab).state;
          // We swap out the routing map at runtime based on app state
          debugPrint('routesBuilder called!');
          return _isLoggedIn
              ? _buildRouteMap(_showBonusTab)
              : loggedOutRouteMap;
        },
      ),
    );
  }
}

// This is the logged out route map.
// This only allows the user to navigate to the root path.
// Note: building the route map from methods allows hot reload to work
final loggedOutRouteMap = RouteMap(
  onUnknownRoute: (route) => Redirect('/'),
  routes: {
    '/': (_) => MaterialPage<dynamic>(child: LoginPage()),
  },
);

// This is the real route map - used if the user is logged in.
RouteMap _buildRouteMap(bool showBonusTab) {
  return RouteMap(
    routes: {
      '/': (_) => CupertinoTabPage(
            child: HomePage(),
            paths: [
              '/feed',
              '/search',
              if (showBonusTab) '/bonus',
              '/notifications',
              '/settings',
            ],
          ),
      '/feed': (_) => MaterialPage<dynamic>(
            name: 'Feed',
            child: FeedPage(),
          ),
      '/feed/profile/:id': (info) {
        if (info.pathParameters['id'] == '1' ||
            info.pathParameters['id'] == '2') {
          return MaterialPage<dynamic>(
            name: 'Profile',
            child: ProfilePage(
              id: info.pathParameters['id'],
              message: info.queryParameters['message'],
            ),
          );
        }

        return Redirect('/feed');
      },
      '/feed/profile/:id/photo': (info) => FancyAnimationPage(
            child: PhotoPage(id: info.pathParameters['id']),
          ),

      '/search': (_) => MaterialPage<dynamic>(
            name: 'Search',
            child: SearchPage(),
          ),
      '/settings': (_) => MaterialPage<dynamic>(
            name: 'Settings',
            key: ValueKey('settings'),
            child: SettingsPage(),
          ),

      // Most pages tend to appear only in one place in the app
      // However sometimes you can push them into multiple places.
      '/search/hero': (_) => MaterialPage<dynamic>(child: HeroPage()),
      '/settings/hero': (_) => MaterialPage<dynamic>(child: HeroPage()),

      // This gets really complicated to test out tested scenarios!
      '/notifications': (_) => IndexedPage(
            child: NotificationsPage(),
            paths: ['one', 'two'],
          ),
      '/notifications/one': (_) => MaterialPage<dynamic>(
            name: 'Notifications - One',
            child: NotificationsContentPage(
              message: 'Page one',
            ),
          ),
      '/notifications/two': (_) => MaterialPage<dynamic>(
            name: 'Notifications - Two',
            child: NotificationsContentPage(message: 'Page two'),
          ),
      '/notifications/pushed': (_) => MaterialPage<dynamic>(
            child: MessagePage(message: 'Pushed notifications'),
          ),
      '/tab-bar': (_) => TabPage(
            child: TabBarPage(),
            paths: [
              'one',
              if (showBonusTab) 'bonus',
              'settings',
            ],
          ),
      '/tab-bar/one': (_) =>
          MaterialPage<dynamic>(child: MessagePage(message: 'One')),
      '/tab-bar/bonus': (_) => MaterialPage<dynamic>(
            child: MessagePage(message: 'BONUS!!'),
          ),
      '/tab-bar/settings': (_) => MaterialPage<dynamic>(child: SettingsPage()),
      '/bottom-navigation-bar-replace': (_) => MaterialPage<dynamic>(
            child: BottomNavigationBarReplacementPage(),
          ),
      '/bottom-navigation-bar': (_) => IndexedPage(
            child: BottomNavigationBarPage(),
            paths: ['one', 'two', 'three'],
          ),
      '/bottom-navigation-bar/one': (_) => MaterialPage<dynamic>(
            child: BottomContentPage(),
          ),
      '/bottom-navigation-bar/two': (_) => MaterialPage<dynamic>(
            child: BottomContentPage2(),
          ),
      '/bottom-navigation-bar/three': (_) => MaterialPage<dynamic>(
            child: MessagePage(message: 'Page three'),
          ),
      '/bottom-navigation-bar/threepage': (_) => MaterialPage<dynamic>(
            child: DoubleBackPage(),
          ),
      '/bottom-navigation-bar/replaced': (_) => MaterialPage<dynamic>(
            child: MessagePage(message: 'Replaced'),
          ),
      '/bonus': (_) => MaterialPage<dynamic>(
            child: MessagePage(message: 'You found the bonus page!!!'),
          ),
    },
  );
}

// For custom animations, just use the existing Flutter [Page] and [Route] objects
class FancyAnimationPage extends Page<dynamic> {
  final Widget child;

  FancyAnimationPage({required this.child});

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<dynamic>(
      settings: this,
      pageBuilder: (context, animation, animation2) {
        final tween = Tween(begin: 0.0, end: 1.0);
        final curveTween = CurveTween(curve: Curves.easeInOut);

        return FadeTransition(
          opacity: animation.drive(curveTween).drive(tween),
          child: child,
        );
      },
    );
  }
}
