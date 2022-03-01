import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class DemoMiddleware extends RouteMiddleware {
  @override
  RouteSettings? redirect(BuildContext? context, String route) {
    Future.delayed(Duration(seconds: 1), () {
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
            content: Text("这里是路由拦截器"),
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
    });
    return null;
  }
}
