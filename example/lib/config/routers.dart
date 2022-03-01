/*
 * fluro
 * Created by Yakka
 * https://theyakka.com
 * 
 * Copyright (c) 2019 Yakka, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */
import 'package:fluro/fluro.dart';
import 'package:fluro_example/config/demo_middleware.dart';
import 'package:flutter/material.dart';
import '../components/home/home_component.dart';
import '../components/demo/demo_simple_component.dart';

class Routers extends FluroPlusPageRouters {
  static String root = "/";
  static String demoSimple = "/demo";
  static String demoSimpleFixedTrans = "/demo/fixedtrans";
  static String demoFunc = "/demo/func";
  static String deepLink = "/message";

  @override
  List<FluroPlusPageRouter> generatorRoutes() {
    return <FluroPlusPageRouter>[
      FluroPlusPageRouter(
        path: root,
        widgetFunc: (context, bundle) {
          return HomeComponent();
        },
      ),
      FluroPlusPageRouter(
        path: demoSimple,
        widgetFunc: (context, bundle) {
          return DemoSimpleComponent(bundle);
        },
      ),
      FluroPlusPageRouter(
        path: demoSimpleFixedTrans,
        widgetFunc: (context, bundle) {
          return DemoSimpleComponent(bundle);
        },
        routeMiddleware: DemoMiddleware(),
      ),
      FluroPlusPageRouter(
        path: demoFunc,
        type: HandlerType.function,
        widgetFunc: (context, bundle) {
          String? message = bundle.getString('message');
          showDialog(
            context: context!,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Hey Hey!",
                  style: TextStyle(
                    color: const Color(0xFF00D6F7),
                    fontFamily: "Lazer84",
                    fontSize: 22.0,
                  ),
                ),
                content: Text("$message"),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0, right: 8.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text("OK"),
                    ),
                  ),
                ],
              );
            },
          );
          return null;
        },
      ),
      FluroPlusPageRouter(
        path: deepLink,
        widgetFunc: (context, bundle) {
          return DemoSimpleComponent(bundle);
        },
      ),
    ];
  }
}
