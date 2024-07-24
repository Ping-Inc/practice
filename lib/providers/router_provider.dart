import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/constants.dart';
import 'package:practice/pages/home_page.dart';
import 'package:practice/pages/ping_entry_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(initialLocation: "/$routePingEntry", routes: <RouteBase>[
    GoRoute(
        name: routeHome,
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        routes: [
          GoRoute(
            name: routePingEntry,
            path: routePingEntry,
            builder: (BuildContext context, GoRouterState state) {
              return const PingEntryPage();
            },
          )
        ])
  ]);
}
