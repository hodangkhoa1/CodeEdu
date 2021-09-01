import 'package:code_edu/Screens/Splash/splash_screen.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/blocs/auth_bloc_facebook.dart';
import 'package:code_edu/blocs/auth_bloc_google.dart';
import 'package:code_edu/l10n/l10n.dart';
import 'package:code_edu/my_translation_wiredash.dart';
import 'package:code_edu/provider/locale_provider.dart';
import 'package:code_edu/requestAPI/wiredash_constants.dart';
import 'package:code_edu/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wiredash/wiredash.dart';

import 'notifier/category_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Settings.init(cacheProvider: SharePreferenceCache());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryNotifier(),
        ),
      ],
      child: MyApp(),
    ));
  });
}

User user = FirebaseAuth.instance.currentUser;

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    return Wiredash(
      secret: secret,
      projectId: projectId,
      navigatorKey: _navigatorKey,
      theme: WiredashThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      options: WiredashOptionsData(
        customTranslations: {
          const Locale.fromSubtags(languageCode: 'vi'): MyTranslation(),
        },
        locale: Locale.fromSubtags(languageCode: 'vi'),
      ),
      child: ValueChangeObserver<bool>(
        cacheKey: HeaderPage.keyDarkMode,
        defaultValue: true,
        builder: (_, isDarkMode, __) {
          return ChangeNotifierProvider(
            create: (context) => LocaleProvider(),
            builder: (context, child) {
              final provider = Provider.of<LocaleProvider>(context);
              return MultiProvider(
                providers: [
                  Provider(
                    create: (context) => AuthGoogleBloc(),
                  ),
                  Provider(
                    create: (context) => AuthBlocFacebook(),
                  ),
                ],
                child: GetMaterialApp(
                  navigatorKey: _navigatorKey,
                  debugShowCheckedModeBanner: false,
                  title: 'Code Edu',
                  theme: isDarkMode ? ThemeData.dark().copyWith(
                    primaryColor: Color(0xFF181818),
                    accentColor: Colors.white,
                    scaffoldBackgroundColor: Color(0xFF181818),
                    canvasColor: Color(0xFF181818),
                    appBarTheme: AppBarTheme(
                      centerTitle: true,
                      elevation: 0,
                      color: Color(0xFF202020),
                      brightness: Brightness.dark,
                      iconTheme: IconThemeData(
                        color: Colors.white
                      ),
                      textTheme: TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 18))
                    ),
                  ) : ThemeData.light().copyWith(
                    accentColor: Colors.black,
                    scaffoldBackgroundColor: Colors.white,
                    canvasColor: Colors.white,
                    appBarTheme: AppBarTheme(
                      centerTitle: true,
                      elevation: 0,
                      color: Colors.white,
                      brightness: Brightness.light,
                      iconTheme: IconThemeData(
                        color: Colors.black
                      ),
                      textTheme: TextTheme(headline6: TextStyle(color: Colors.blue, fontSize: 18))
                    ),
                  ),
                  supportedLocales: L10n.all,
                  locale: provider.locale,
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  initialRoute: SplashScreen.routeName,
                  routes: routes,
                ),
              );
            },
          );
        }
      ),
    );
  }
}
