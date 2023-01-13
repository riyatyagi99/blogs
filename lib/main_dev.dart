import 'package:flutter/material.dart';
import 'app_config.dart';
import 'main.dart';

void main() {
  final prodAppConfig = AppConfig(
    appName: "Dev Flavor",
    flavor: "dev",
    themeData: ThemeData(primarySwatch: Colors.deepPurple),
  );
  runWithAppConfig(prodAppConfig);
}
