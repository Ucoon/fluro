import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'fluro_plus_bundle.dart';

/// fluro的路由跳转工具类
/// 参考：https://www.jianshu.com/p/1987cc9b714a
class FluroPlusNavigate {
  ///跳转新的页面
  static goto(
    BuildContext context,
    FluroRouter router,
    String path, {
    Bundle? bundle,
    bool replace = false,
    bool clearStack = false,
    TransitionType transition = TransitionType.inFromRight,
  }) {
    debugPrint('FluroPlusNavigate.goto $path?arguments=${bundle?.toJson()}');
    FocusScope.of(context).requestFocus(FocusNode());
    router.navigateTo(
      context,
      '$path?arguments=${bundle?.toJson() ?? {}}',
      replace: replace,
      clearStack: clearStack,
      transition: transition,
    );
  }

  ///跳转新的页面并接收返回结果
  static gotoWithResult(
    BuildContext context,
    FluroRouter router,
    String path, {
    required Function function,
    Bundle? bundle,
    bool replace = false,
    bool clearStack = false,
    TransitionType transition: TransitionType.inFromRight,
  }) {
    print('FluroPlusNavigate.goto $path?arguments=${bundle?.toJson()}');
    FocusScope.of(context).requestFocus(FocusNode());
    router
        .navigateTo(
      context,
      '$path?arguments=${bundle?.toJson()}',
      replace: replace,
      clearStack: clearStack,
      transition: transition,
    )
        .then((value) {
      if (value == null) {
        return;
      }
      function(value);
    }).catchError((err) {
      print('FluroPlusNavigate.gotoWithResult $err');
    });
  }

  ///回退到上一页面
  static bool goBack(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    bool canPop = Navigator.canPop(context);
    if (canPop) {
      Navigator.pop(context);
    }
    return canPop;
  }

  /// 回退上一页面并携带参数
  static bool goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).requestFocus(FocusNode());
    bool canPop = Navigator.canPop(context);
    if (canPop) {
      Navigator.pop(context, result);
    }
    return canPop;
  }

  ///回退到指定页面
  static void backRouteTo(BuildContext context, String path) {
    Navigator.of(context).popUntil(
      (route) {
        return route.settings.name == path ||
            route.settings.name?.split('?')[0] == path;
      },
    );
  }

  ///返回两次
  static void backForTwice(BuildContext context) {
    int count = 0;
    Navigator.of(context).popUntil((route) => count++ == 2);
  }
}
