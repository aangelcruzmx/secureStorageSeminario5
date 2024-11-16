import 'package:flutter/material.dart';
import 'package:prefusuarios/screens/home_screen.dart';
import 'package:prefusuarios/screens/settings_screen.dart';
import 'package:prefusuarios/shared_prefs/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: UserPreferences().ultimaPagina,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          String initialRoute = snapshot.data ?? HomeScreen.routeName;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Preferencias de Usuario',
            initialRoute: initialRoute,
            routes: {
              HomeScreen.routeName: (_) => HomeScreen(),
              SettingsScreen.routeName: (_) => SettingsScreen(),
            },
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
          );
        }
      },
    );
  }
}
