import 'package:code_edu/Screens/Splash/splash_screen.dart';
import 'package:code_edu/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'notifier/category_notifier.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (context) => CategoryNotifier(),
    ),
  ],
  child: MyApp(),
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Code Edu',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.white,
          elevation: 0,
          brightness: Brightness.light,
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          textTheme: TextTheme(headline6: TextStyle(color: Colors.blue, fontSize: 18))
        ),
      ),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
