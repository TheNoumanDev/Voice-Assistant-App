import 'package:flutter/material.dart';
import 'package:vassistantapp/Colors/pallete.dart';

import 'Home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner
      title: 'Allen',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.whiteColor,
          foregroundColor: Pallete.blackColor,
          elevation: 0,
          centerTitle: true,
        ),
      ),

      // theme: ThemeData.light(useMaterial3: true).copyWith(
      //   scaffoldBackgroundColor: Pallete.whiteColor,
      // ),
      home: const HomePage(),
    );
  }
}
