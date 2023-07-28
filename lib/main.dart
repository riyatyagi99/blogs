/*

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

import 'deeplink.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyAppDynamic());

}

void initUniLinks(BuildContext context) async {
  // Ensure that the app is ready to handle deep links
  try {
    await getInitialLink();
  } on PlatformException {
    // Handle exception if platform is not supported or other error occurs
  }

  // Set up a stream subscription to handle deep links when the app is running
  Uri? initialUri;
  getLinksStream().listen((String? uri) {
    if (uri != null && uri != initialUri) {
      initialUri = Uri.parse(uri);
      handleDeepLink(initialUri!,context);
    }
  }, onError: (err) {
    // Handle stream subscription errors
  });
}

void handleDeepLink(Uri uri, BuildContext context) {
  // Extract relevant information from the deep link and perform actions accordingly
  String path = uri.path;
  String? query = uri.queryParameters['param'];

  // Example: Navigating to a specific screen based on the deep link
  if (path == '/product') {
    String productId = query ?? '';
    Navigator.pushNamed(context, '/product', arguments: productId);
  }
}*/

import 'package:blog/QR/qr_code.dart';
import 'package:blog/razorpay.dart';
import 'package:blog/styling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uni_links/uni_links.dart';

import 'app_utils.dart';
import 'notification/local_notification.dart';
import 'notification/service.dart';
//IMPORT THESE PACKAGES ^^^


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel channel=AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This is for sending notifications',
  playSound: true,
  importance: Importance.high,
  // ledColor: Colors.orange,
  //sound: AndroidNotificationSound.
);
void main() async{
  initUniLinks();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(MyApp());

}
 initUniLinks()async{
  try{
    Uri? initialLink = await getInitialUri();
    print(initialLink);
  } on PlatformException {
    print('platfrom exception unilink');
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      scaffoldMessengerKey:AppUtils.messengerKey ,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.red,
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,color: Colors.teal),
            bodyText1: TextStyle(fontSize: 16.0),
          ),
        ).copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              padding:EdgeInsets.symmetric(horizontal: 20,vertical: 15)
            ),
          )
      ),
      home: LocalNotification(),
     // home: QRScannerScreen(),
    );
  }
}