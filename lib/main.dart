import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:january_2023/app_life_cycle_manager.dart';
import 'package:january_2023/extra/search_with_tf.dart';
import 'all_work_list.dart';
import 'app_config.dart';


void main() async{
  final prodAppConfig = AppConfig(
    appName: "Prod Flavor",
    flavor: "prod",
    themeData: ThemeData(primarySwatch: Colors.deepOrange),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
runWithAppConfig(prodAppConfig);
 // runApp(MyApp());
}

void runWithAppConfig(AppConfig appConfig) {
  runApp(MyApp(
    appConfig: appConfig,
  ));



  // for device preview
/*  runApp ( DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(
      appConfig: appConfig,
    ), // Wrap your app
  ),);*/
}

class MyApp extends StatelessWidget {
  AppConfig? appConfig;
  MyApp({super.key,  this.appConfig});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppLifeCycleManager(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
/*
          useInheritedMediaQuery: true,             //these 3 below foe device preview
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
*/

          theme: appConfig?.themeData,
        home: AllPackagesList(appConfig:appConfig)



        //MyHomePage(title: 'Flutter Demo Home Page ${appConfig?.appName}'),
      ),
    );
  }
}
