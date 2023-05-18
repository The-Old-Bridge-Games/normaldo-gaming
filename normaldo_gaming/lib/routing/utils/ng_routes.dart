part of '../ng_router.dart';

enum NGRoutes {
  root('/'),
  main('/main'),
  createUser('/createUser');

  const NGRoutes(this.path);

  final String path;
}
