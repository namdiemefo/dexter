import 'package:dexter_todo/helpers/utils/routes.dart';
import 'package:dexter_todo/ui/app/create_task_page.dart';
import 'package:flutter/material.dart';

import 'splash_page.dart';
import 'todo_page.dart';

class AppPage extends StatefulWidget {
  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  AppPageState createState() => AppPageState();
}

class AppPageState extends State<AppPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return !await AppPage.navKey.currentState.maybePop();
        },
        child: Navigator(
          key: AppPage.navKey,
          initialRoute: AppRoutes.toAppPage,
          onGenerateRoute: _myRoutes,
        ),
      );
  }

  Route _myRoutes(RouteSettings settings) {
    Widget builder = Container();
    bool fullScreenDialog = true;
    print(settings.name);
    switch (settings.name) {
      case AppRoutes.toAppPage:
        builder = _Splash();
        break;

      case AppRoutes.toCreateTaskScreen:
        builder = CreateTaskPage();
        break;

      default:
        throw Exception('UserApp: Invalid route: ${settings.name}');
        break;
    }

    return MaterialPageRoute(
        builder: (_) => builder,
        fullscreenDialog: fullScreenDialog,
        settings: settings);
  }
}

class _Splash extends StatefulWidget {
  @override
  __SplashState createState() => __SplashState();
}

class __SplashState extends State<_Splash> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    //return SplashPage();
    return TodoPage();
  }
}