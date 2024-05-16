import 'package:flutter/material.dart';
import 'SesionScreen/Start_screen.dart';
import 'SesionScreen/Sign_up.dart';
import 'Home/HomePage.dart';
import '/ScreenGames/ClashRoyaleScreen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: StartScreen.routename,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        StartScreen.routename: (context) => const StartScreen(),
        SignUp.routename: (context) => const SignUp(),
        Homepage.routename: (context) => const Homepage(),
        Clashroyalescreen.routename: (context) => const Clashroyalescreen(),
      },
      home: StartScreen(),
    );
  }
}
