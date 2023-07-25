import 'package:amazon_clone_flutter_app/common/widgets/bottom_bar.dart';
import 'package:amazon_clone_flutter_app/constants/global_variables.dart';
import 'package:amazon_clone_flutter_app/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone_flutter_app/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone_flutter_app/features/auth/services/auth_service.dart';
import 'package:amazon_clone_flutter_app/providers/user_provider.dart';
import 'package:amazon_clone_flutter_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        useMaterial3: true,
      ),
      //runs everyTimes when we use Navigator.pushNamed
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? (Provider.of<UserProvider>(context).user.type == 'user')
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}
