import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'fluro_plus_bundle.dart';

typedef WidgetFunc = Widget? Function(BuildContext? context, Bundle bundle);

class FluroPlusPageRouter {
  final String path;
  final HandlerType type;
  final WidgetFunc widgetFunc;
  final RouteMiddleware? routeMiddleware;
  FluroPlusPageRouter({
    required this.path,
    required this.widgetFunc,
    this.type: HandlerType.route,
    this.routeMiddleware,
  });
}
