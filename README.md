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

## Keep state with tab bar route destinations
A question is, how can we with routemaster keep the state of the routes
in tab bar destinations?

This question is asked in the routemaster repo here:

