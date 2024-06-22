import 'package:flutter/material.dart';
import 'package:flutter_challenge/presentation/router/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Options Profit Calculator',
      initialRoute: '/',
      onGenerateRoute: _appRouter.routeGeneration,
      debugShowCheckedModeBanner: false,
    );
  }
}
