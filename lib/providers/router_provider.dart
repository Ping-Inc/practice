import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/constants.dart';
import 'package:practice/pages/explore_page.dart';
import 'package:practice/pages/new_ping_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(initialLocation: "/$routePingEntry", routes: <RouteBase>[
    GoRoute(
        name: routeHome,
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const ExplorePage();
        },
        routes: [
          GoRoute(
            name: routePingEntry,
            path: routePingEntry,
            builder: (BuildContext context, GoRouterState state) {
              return const NewPingPage();
            },
          )
        ])
  ]);
}
