
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goldenphoenix/Design/SlidingClippedNavBar.dart';
import 'package:goldenphoenix/Screens/Authentication/myProfile.dart';
import 'package:goldenphoenix/Screens/Home/home.dart';
import 'package:goldenphoenix/Screens/MyBag/mybag.dart';
import 'package:goldenphoenix/Screens/MyOrders/myorders.dart';

class AppNavigation {
  AppNavigation._();

  static String initial = '/home';

  static final _rootNavigationKey = GlobalKey<NavigatorState>();

  static final _shellNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorMyBag =
      GlobalKey<NavigatorState>(debugLabel: 'shellMyBag');
  static final _shellNavigatorMyOrder =
      GlobalKey<NavigatorState>(debugLabel: 'shellMyOrder');
  static final _shellNavigatorMyProfile =
      GlobalKey<NavigatorState>(debugLabel: 'shellMyProfile');

  static final GoRouter router = GoRouter(
      initialLocation: initial,
      navigatorKey: _rootNavigationKey,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return SlidingClippedNavigationBar(
                navigationShell: navigationShell,
              );
            },
            branches: <StatefulShellBranch>[
              StatefulShellBranch(
                  navigatorKey: _shellNavigatorHome,
                  routes: <RouteBase>[
                    GoRoute(
                      path: '/Home',
                      name: 'Home',
                      builder: (context, state) => const Home(),
                    )
                  ]),
              StatefulShellBranch(
                  navigatorKey: _shellNavigatorMyBag ,
                  routes: <RouteBase>[
                    GoRoute(
                        path: '/MyBag',
                        name: 'myBag',
                        builder: (context, state) => const MyBag(),
                    )  
                  ]),
              StatefulShellBranch(
                  navigatorKey: _shellNavigatorMyOrder,
                  routes: <RouteBase>[
                    GoRoute(
                      path: '/MyOrders',
                      name: 'myOrders',
                      builder: (context, state) => const MyOrders(),
                    )
                  ]),
              StatefulShellBranch(
                  navigatorKey: _shellNavigatorMyProfile,
                  routes: <RouteBase>[
                    GoRoute(
                      path: '/Authentication',
                      name: 'myProfile',
                      builder: (context, state) => const MyProfile(),
                    )
                  ]),
            ])
      ]);
}
