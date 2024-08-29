import 'package:flutter/material.dart';
import 'screens/password_generator_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Generator',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        colorScheme: ColorScheme.dark(secondary: Colors.pinkAccent),
      ),
      home: PasswordGeneratorScreen(),
    );
  }
}