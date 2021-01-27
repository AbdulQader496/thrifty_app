import 'package:thrifty_app/config/config.dart';
import 'package:thrifty_app/generated/l10n.dart';
import 'package:thrifty_app/models/models.dart';
import 'package:thrifty_app/screens/screens.dart';
import 'package:thrifty_app/services/category.dart';
import 'package:thrifty_app/services/currency.dart';
import 'package:thrifty_app/services/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics();
    updateStatusBarColor(context);
    setupCloudMessaging();

    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().user,
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<CurrencyProvider>(
          create: (context) => CurrencyProvider(),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (context) => SettingsProvider(),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Consumer<SettingsProvider>(
          builder: (context, settings, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: settings.appLang,
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: analytics),
            ],
            title: 'Be Thrifty Today',
            theme: themeSelector(settings.theme).copyWith(
              accentColor: settings.accentColor,
            ),
            initialRoute: SplashScreen.routeName,
            routes: routes,
          ),
        ),
      ),
    );
  }

  ThemeData themeSelector(ThemeOptions option) {
    switch (option) {
      case ThemeOptions.light:
        return theme;
      case ThemeOptions.dark:
        return darkTheme;
      case ThemeOptions.amoled:
        return amoledTheme;
      default:
        return theme;
    }
  }

  setupCloudMessaging() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}
