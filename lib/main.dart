// @dart=2.17

import 'package:flutter/material.dart';
import 'package:flutter_netflex_ui/screens/HomeScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const Color _netflixRed = Color(0xFFE50914);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix UI',
      theme: ThemeData(
        primaryColor: _netflixRed,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
            .copyWith(secondary: _netflixRed),
      ),
      home: const HomeScreen(),
    );
  }
}
