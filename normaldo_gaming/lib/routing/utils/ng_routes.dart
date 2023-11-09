part of '../ng_router.dart';

enum NGRoutes {
  root('/'),
  main('/main'),
  createUser('/createUser'),
  pullUpGame('/main/pullUpGame'),
  missions('/main/missions'),
  settings('/main/settings'),
  shop('/main/shop'),
  slots('/main/slots'),
  knowledgeBook('/main/knowledge');

  const NGRoutes(this.path);

  final String path;
}
