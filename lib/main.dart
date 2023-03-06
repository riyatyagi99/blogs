

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:january_2023/app_life_cycle_manager.dart';
import 'package:january_2023/extra/search_with_tf.dart';
import 'package:january_2023/theme/theme_provider.dart';
import 'package:january_2023/theme/theme_styles.dart';
import 'package:provider/provider.dart';
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

class MyApp extends StatefulWidget {
  AppConfig? appConfig;
  MyApp({super.key,  this.appConfig});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  DarkThemeProvider themeChangeProvider =  DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }




  @override
  Widget build(BuildContext context) {
    return AppLifeCycleManager(
      child: ChangeNotifierProvider<DarkThemeProvider>(
        create: (_)=>themeChangeProvider,
        child: Consumer<DarkThemeProvider>(
          builder: (context, themeProvider, child) =>MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),

          /*  theme: ThemeData(
                primarySwatch: Colors.red,
                appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
              ),
*/

/*
              useInheritedMediaQuery: true,             //these 3 below for device preview
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
*/


              home: AllPackagesList(appConfig:widget.appConfig)
          ),
        ),
      ),
    );
  }
}
