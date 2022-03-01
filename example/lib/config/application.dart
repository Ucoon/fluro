/*
 * fluro
 * Created by Yakka
 * https://theyakka.com
 * 
 * Copyright (c) 2019 Yakka, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Application {
  static late final FluroRouter router = FluroRouter(); //全局路由

  ///路由注册
  static setupRoutes(FluroPlusPageRouters routers) {
    router.notFoundHandler = Handler(handlerFunc: (context, params) {
      debugPrint('Application.setupRoutes route was not found');
      return Scaffold(
        body: Center(
          child: Text('route was not found'),
        ),
      );
    });
    routers.generatorRoutes().forEach((element) {
      Handler handler = Handler(
        type: element.type,
        handlerFunc: (context, params) {
          return element.widgetFunc(context, Bundle.convert(params));
        },
      );
      router.define(
        element.path,
        handler: handler,
        routeMiddleware: element.routeMiddleware,
      );
    });
  }
}
