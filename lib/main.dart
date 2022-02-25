import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'journal_app.dart';
import 'db/database_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // make sure 3 orientations are supported
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);
  // only initialize once for all app
  await DatabaseManager.initialize();
  runApp(JournalApp(preferences: await SharedPreferences.getInstance()));
}
