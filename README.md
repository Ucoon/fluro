```dart
dependencies:
  fluro: ^2.0.3
```

这个库在[Fluro](https://pub.dev/packages/fluro)的基础上增加了拦截器，并封装了[路由跳转工具类、路由传参封装类](https://juejin.cn/post/6844903941503713294)。

安装：

```dart
  fluro:
   git:
      url: https://github.com/Ucoon/fluro.git
      ref: main
```

导入：

```dart
import 'package:fluro/fluro.dart';
```

使用：

1. 定义全局路由：

   ```dart
     static late final FluroRouter router = FluroRouter(); //全局路由
   ```

2. 注册路由：

   ```dart
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
   ```

3. 配置路由文件：

   ```dart
   class Routers extends FluroPlusPageRouters {
     static String root = "/";
     static String demoSimple = "/demo";
   
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
           routeMiddleware: DemoMiddleware(),
         ),
       ];
     }
   }
   ```

4. 在`main.dart`文件中注册路由文件：

   ```dart
   Application.setupRoutes(Routers());
   ```

5. 跳转：

   ```dart
   FluroPlusNavigate.goto(
     context,
     Application.router,
     Routers.demoSimple,
     bundle: bundle,
     transition: transitionType,
   );
   ```

   