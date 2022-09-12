import 'package:apis/data/local_database.dart';
import 'package:apis/utlies/all_service_intilizer.dart';

import 'package:apis/utlies/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");
  sharedPreferences = await SharedPreferences.getInstance();
  await initServices();
  await LocalStorage().saveAppData();
  runApp(const MyApp());
}
