# mrnavdemo - A Routemaster Demo

This a clone and major modification of Tom Gilder's **mobile_app** example
bundled with the Flutter **Routemaster** package 
https://github.com/tomgilder/routemaster.

It adds a scrolling grid to some pages in the main routes, so we can see
and verify that the screen states, like the screen scrolling position is kept 
with the bottom cupertino navigation used on the bottom destinations when 
changing routes with routemaster. We can also see that you can navigate to 
it with URLs as well when you build the app for web.

This demo also adds dark mode toggling, and a lot of theme options. It helped
to verify that screen rebuild properly.

### Q1: Screens are rebuilt too often

With version 0.8.0 when toggling themes or theme mode, the screen were getting 
rebuilt. Then again with version 0.7.2 using Riverpod, they were not 
rebuilt at all.

This issue has been solved starting from Routemaster version 0.9.0-dev1.
This demo has been converted to use Riverpod instead of Provider as in the 
original and works
great now.

This issue was originally raised in the routemaster repo 
here: https://github.com/tomgilder/routemaster/issues/101


### Q2: Keep state with tab bar route destinations
How can we with **routemaster** keep the state of the routes
in tab bar destinations?

This question was asked and answered in the routemaster 
repo here: https://github.com/tomgilder/routemaster/issues/87

Converting e.g. the `SettingsPage` to a `StatefulWidget` and adding 
`AutomaticKeepAliveClientMixin` keeps the scrolling position:

```dart
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
  with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ...
  }
}
```

Did not need the `AutomaticKeepAliveClientMixin` in my own use cases before,
with a different navigator. Adding a `PageStore` key to the tab pages did the 
same trick, but it did not work with routemaster, not sure 
why, but this woks OK of course. 
