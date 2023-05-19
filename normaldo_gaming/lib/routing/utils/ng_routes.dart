part of '../ng_router.dart';

enum NGRoutes {
  root('/'),
  main('/main'),
  createUser('/createUser'),
  pullUpGame('/main/pullUpGame');

  const NGRoutes(this.path);

  final String path;
}
