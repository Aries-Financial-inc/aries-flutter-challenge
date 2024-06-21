import 'package:flutter_challenge/screens/splash_screen/splash_screen.dart';

import 'package:provider/provider.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'linker.dart';

// My code will be brief

// BaseLanguage lan = LanguageEn();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  
  await appini();
  runApp(MultiProvider(providers: [
    // for handling the option activity
    ChangeNotifierProvider(create: (_) => OptionsProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: appName,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: appScaffoldColor,
        primaryColor: appScaffoldColor,
        colorScheme: ColorScheme.dark(
          primary: appButtonBackgroundColorGlobal,
          secondary: appButtonBackgroundColorGlobal,
        ),
      ),
      //  localizationsDelegates: const [
      //     AppLocalizations(),
      //     GlobalMaterialLocalizations.delegate,
      //     GlobalWidgetsLocalizations.delegate,
      //     GlobalCupertinoLocalizations.delegate,
      //   ],
      // localeResolutionCallback: (locale, supportedLocales) => locale,
      // locale: Locale(localizationProvider.selectedLanguageCode),
      // supportedLocales: LanguageDataModel.languageLocales(),
      home: const SplashScreen(),
    );
  }
}

appini() {
  // defaultAppButtonRadius = 15;
  appButtonBackgroundColorGlobal = const Color(0xFF6F4BFD);

  // defaultAppButtonTextColorGlobal = Colors.white;
  // textSecondaryColorGlobal = secondaryblackColor;
}
