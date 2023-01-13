import 'package:flutter/material.dart';
import 'package:january_2023/extra/search_with_tf.dart';
import 'all_work_list.dart';
import 'app_config.dart';

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
    return MaterialApp(
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
    );
  }
}
