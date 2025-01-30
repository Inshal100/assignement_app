import 'package:assignment_checker/routing/route_names.dart';
import 'package:assignment_checker/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

const apiKey = 'AIzaSyC-rggnag3-7UKpoQztqSlxc9-MCQDnJwk';

void main() {
  Gemini.init(apiKey: apiKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RouteNames.homeScreen,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
