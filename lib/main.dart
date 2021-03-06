import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'localization/app_localization.dart';
import 'route/route_manager.dart';
import 'theme/app_theme.dart';
import 'theme/apptheme_notifier.dart';
import 'utils/custom_log.dart';
import 'utils/custom_trace.dart';
import 'utils/shared_preference.dart';
import 'utils/size_config.dart';

void main() {

  LicenseRegistry.addLicense(() async* {

    final license = await rootBundle.loadString('google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {

    runApp(
      ChangeNotifierProvider<AppThemeNotifier>(
        create: (context) => AppThemeNotifier(),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {

  static Locale appLocale;

  @override
  _MyAppState createState() => _MyAppState();


  static void setLocale(BuildContext context, Locale locale) {

    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }
}

class _MyAppState extends State<MyApp> {

  Locale _locale;
  MySharedPreference _mSharedPreference = MySharedPreference();


  @override
  void initState() {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[200],
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    //FCMSetup().conFigureFirebase(context);
    super.initState();
  }


  @override
  void didChangeDependencies() {

    _mSharedPreference.getLanguageCode().then((locale) {
      setLocale(locale);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {

              SizeConfig().init(constraints, orientation);

              return Consumer<AppThemeNotifier>(
                builder: (context, appThemeState, child) {

                  return MaterialApp(
                    title: "Sell Mart",
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: appThemeState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
                    locale: _locale,
                    localizationsDelegates: [
                      AppLocalization.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: [
                      Locale("en", "US"),
                      Locale("bn", "BD"),
                    ],
                    localeResolutionCallback: (Locale deviceLocale, Iterable<Locale> supportedLocales) {

                      for(var locale in supportedLocales) {

                        if(locale.languageCode == deviceLocale.languageCode &&
                            locale.countryCode == deviceLocale.countryCode) {

                          return deviceLocale;
                        }
                      }

                      return supportedLocales.first;
                    },
                    onGenerateRoute: RouteManager.generate,
                    initialRoute: RouteManager.SPLASH_SCREEN,
                  );
                },
              );
            },
          );
        }
    );
  }


  void setLocale(Locale locale) {

    CustomLogger.info(trace: CustomTrace(StackTrace.current),
        tag: "App Language",
        message: locale.languageCode);

    setState(() {
      MyApp.appLocale = locale;
      _locale = locale;
    });
  }
}