import 'package:amazon_clone_flutter_app/constants/global_variables.dart';
import 'package:amazon_clone_flutter_app/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone_flutter_app/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        // its change the color global. We don't need to change color in widget every time.
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          // no elevation in appbar
          elevation: 0,
          // all icon in black color set in static
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      //runs everyTimes when we use Navigator.pushNamed
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const AuthScreen(),
    );
  }
}
