import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import './page/camera.dart';
import './utils/mock_data.dart';
import './page/livestream/streamBuilder.dart';
import './formLogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Column(
          children: [
            Container(
              child: Image.asset('assets/image/FCE-Site-logo.png'),
            ),
            Text(
              'Welcome to SoC Lab',
              style: TextStyle(
                  fontFamily: "RobotoCondensed",
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5),
            ),
          ],
        ),
        splashIconSize: 300,
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: FormLogin(),
      ),

      //   Center(
      //   child: Container(
      //     child: Text(
      //       'Splash Screen',
      //       style: TextStyle(
      //         fontSize: 24,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
