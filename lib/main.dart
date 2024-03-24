import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/firebase_options.dart';
import 'package:project/pages/CategoryDetailPage.dart';
import 'package:project/pages/CategoryPage.dart';
import 'package:project/pages/HomePage.dart';
import 'package:project/pages/LoginPage.dart';
import 'package:project/pages/ProfilePage.dart';
import 'package:project/pages/UserPage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       scaffoldBackgroundColor: Color(0xFF0F111D),
      ),
      home: AnimatedSplashScreen(
        splash: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
              width: 300,
              height: 300,
              color: Colors.amber,
              child: Center(
                child: Text(
                  "IMDb",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 85,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ),
        duration: 2500,
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.black,
        nextScreen: LoginPage(
          title: 'LOGIN',
        ),
      ),
      routes: {
        "loginpage": (context) => LoginPage(title: "Flutter Login"),
        "homepage": (context) => HomePage(),
        "categoryPage": (context) => CategoryPage(),
        "categorydetailpage": (context) => CategoryDetailPage(category: 1),
        "userpage": (context) => UserPage(),
        "categorydetailpage": (context) => CategoryDetailPage(category: 1),
        "profilePage": (context) => ProfilePage(),
      },
    );
  }
}
