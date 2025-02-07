import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/ram_shalaka.dart';

import 'akhand_jyoti.dart';
import 'button_page.dart';
import 'hartalika_teej.dart';
import 'karwa_chauth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CountdownScreen(),
    );
  }
}