import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/pages/CategoryDetailPage.dart';
import 'package:project/pages/CategoryPage.dart';
import 'package:project/pages/HomePage.dart';
import 'package:project/pages/LoginPage.dart';
import 'package:project/pages/MoviePage.dart';
import 'package:project/pages/ProfilePage.dart';
import 'package:project/pages/UserPage.dart';

void main() {
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
          )),
          duration: 2500,
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: Colors.black,
          //   Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         height: 100,
          //         width: 100,
          //         color: Colors.blue,
          //       ),
          //       Container(
          //         child: Text(
          //           '2 sec ruko bhai',
          //           style: TextStyle(color: Colors.lightBlue, fontSize: 24, fontWeight: FontWeight.bold),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          nextScreen: LoginPage(
            title: 'LOGIN',
          )),
      routes: {
        // "/": (context) => AnimatedSplashScreen(
        //     splash: Text(
        //       "IMDb",
        //       style: TextStyle(
        //         color: Colors.amber,
        //         fontSize: 70,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //     duration: 2000,
        //     splashTransition: SplashTransition.fadeTransition,
        //     backgroundColor: Colors.black,
        //     //   Center(
        //     //   child: Column(
        //     //     mainAxisAlignment: MainAxisAlignment.center,
        //     //     children: [
        //     //       Container(
        //     //         height: 100,
        //     //         width: 100,
        //     //         color: Colors.blue,
        //     //       ),
        //     //       Container(
        //     //         child: Text(
        //     //           '2 sec ruko bhai',
        //     //           style: TextStyle(color: Colors.lightBlue, fontSize: 24, fontWeight: FontWeight.bold),
        //     //         ),
        //     //       ),
        //     //     ],
        //     //   ),
        //     // ),
        //     nextScreen: LoginPage(
        //       title: 'FLUTTER LOGIN',
        //     )),
        // "animatedsplashscreen": (context) => MyHomePage(title: 'Flutter Login Demo'),
        "loginpage": (context) => LoginPage(title: "Flutter Login"),
        "homepage": (context) => HomePage(),
        "categoryPage": (context) => CategoryPage(),
        "categorydetailpage": (context) => CategoryDetailPage(category: 1),
        "moviePage": (context) => MoviePage(),
        "userpage": (context) => UserPage(),
        "categorydetailpage": (context) => CategoryDetailPage(category: 1),
        "profilePage": (context) => ProfilePage(),
      },
    );
  }
}
