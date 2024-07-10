import 'package:esports_workout/Rutines/ClashRoyaleRutine.dart';
import 'package:flutter/material.dart';
import 'SesionScreen/Start_screen.dart';
import 'SesionScreen/Sign_up.dart';
import 'Home/HomePage.dart';
import 'ScreenGames/ClashRoyaleLogin.dart';
import 'Games/GamesPage.dart';

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
        //Ruta a cada pantalla
        StartScreen.routename: (context) => const StartScreen(),
        SignUp.routename: (context) => const SignUp(),
        Homepage.routename: (context) => const Homepage(),
        Clashroyalelogin.routename: (context) => const Clashroyalelogin(),
        Clashroyalerutine.routename: (context) => const Clashroyalerutine(),
        GamesPage.routeName: (context) => GamesPage(),
      },
      home: const StartScreen(), //Ruta inicial
    );
  }
}
