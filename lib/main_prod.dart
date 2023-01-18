import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app_config.dart';
import 'main.dart';

void main() async{
  final prodAppConfig = AppConfig(
    appName: "Prod Flavor",
    flavor: "prod",
    themeData: ThemeData(primarySwatch: Colors.deepOrange),
  );
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runWithAppConfig(prodAppConfig);
}
