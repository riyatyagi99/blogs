import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app_config.dart';
import 'main.dart';

void main() async{
  final prodAppConfig = AppConfig(
    appName: "Dev Flavor",
    flavor: "dev",
    themeData: ThemeData(primarySwatch: Colors.deepPurple),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runWithAppConfig(prodAppConfig);
}
