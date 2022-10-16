import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'helpers/assets/colors.dart';
import 'helpers/di/dependency.dart';
import 'main_bloc_observer.dart';
import 'ui/app/app_page.dart';

void main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MainBlocObserver();
  runApp(
      DexterApp()
  );
}

class DexterApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Dexter Health",
          initialRoute: "/",
          onGenerateRoute: _getRoutes,
          theme: ThemeData(
            primaryColor: bPurple,
            textTheme: TextTheme(),
            primarySwatch: Colors.blue,
          ),
        ),
      ),
    );
  }
}
//
Route<dynamic> _getRoutes(RouteSettings settings) {
  Widget builder = Container();
  bool fullScreenDialog = false;
  switch (settings.name) {
    case '/':
      builder = Scaffold(
        primary: false,
        resizeToAvoidBottomInset: false,
        body: AppPage(),
      );
      fullScreenDialog = false;
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
