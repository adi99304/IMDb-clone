import 'package:flutter/material.dart';
// import 'package:project/pages/HomePage.dart';
import 'package:project/pages/LoginPage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToLoginAfterDelay();
  }

  _navigateToLoginAfterDelay() async {
    await Future.delayed(Duration(milliseconds: 2000)); // Wait for 2 seconds
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          title: "FLUTTER LOGIN",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              '2 sec ruko bhai',
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
