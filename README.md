# mrnavdemo

This a clone and slight modification of Tom Gilder's mobile_app example
bundled in the Flutter routemaster package 
https://github.com/tomgilder/routemaster.

It adds a scrolling grid to some pages in the main routes, so we can see
and verify that the screen states, like the screen scrolling position is kept 
with the bottom cupertino navigation used on the bottom destinations when 
changing routes with routemaster. We can also see that you can navigate to 
it with URLs as well when you build the app for webn

We can also see that the state is not kept when using the tab bar on the
Feed route. 

## Q1: Keep state with tab bar route destinations
A question is, how can we with **routemaster** keep the state of the routes
in tab bar destinations?

This question was asked am answered in the routemaster 
repo here: https://github.com/tomgilder/routemaster/issues/87


Converting the SettingsPage to a StatefulWidget and adding AutomaticKeepAliveClientMixin keeps the scrolling position:

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
with a different navigator, adding a PageStore key to the tab pages did the 
same trick for me before, but it did not work with routemaster, not sure 
why not but this woks OK of course. 
