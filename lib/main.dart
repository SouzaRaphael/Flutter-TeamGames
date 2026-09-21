import 'package:flutter/material.dart';
import 'package:persistencia_local/database/app_database.dart';
import 'package:persistencia_local/screens/intro_screen.dart';
import 'package:persistencia_local/screens/shell_screen.dart';
import 'package:persistencia_local/services/preferences_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDatabase.instance.database;

  bool skipIntro = await hasFavoriteTeam();

  runApp(MyApp(skipIntro));
}

class MyApp extends StatelessWidget {
  const MyApp(this.skipIntro, {super.key});

  final bool skipIntro;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: skipIntro ? ShellScreen() : IntroScreen(),
    );
  }
}

Future<bool> hasFavoriteTeam() async {
  final instance = await SharedPreferences.getInstance();
  await instance.clear();

  final _preferences = PreferencesService();

  return await _preferences.getFavoriteTeam() != null;
}