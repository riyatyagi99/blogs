import 'package:blog/product.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class MyAppDynamic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Link Example',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/product': (context) => ProductScreen(),
      },
    );
  }
}