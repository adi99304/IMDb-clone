import 'package:flutter/material.dart';
import 'package:project/pages/LoginPage.dart';
import 'package:project/pages/UserPage.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xFF0F111D),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('images/profile.jpeg'),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'ADITYA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '2022.aditya.hegde@ves.ac.in',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0), // Space before the first container
              _buildAccountContainer(context, 'Account', Icons.account_circle),
              SizedBox(height: 0), // Space between containers
              _buildAccountContainer(context, 'Watchlist', Icons.watch_later),
              SizedBox(height: 0), // Space between containers
              _buildAccountContainer(
                  context, 'Display', Icons.display_settings),
              SizedBox(height: 0), // Space between containers
              _buildAccountContainer(context, 'Notifications', Icons.email),
              SizedBox(height: 0), // Space between containers
              _buildAccountContainer(
                  context, 'Favourites', Icons.favorite_outline),
              SizedBox(height: 0), // Space between containers
              _buildAccountContainer(context, 'Sign Out', Icons.exit_to_app),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountContainer(
      BuildContext context, String text, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (text == 'Sign Out') {
          // Navigate to LoginPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(
                      title: '',
                    )),
          );
        } else if (text == 'Favourites' || text == 'Watchlist') {
          // Navigate to UserPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserPage()),
          );
        } else if (text == 'Display') {
          // Show prompt for changing brightness (implement this)
          // For now, just print a message
          print('Display settings pressed');
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: 400,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 45),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                icon,
                color: Colors.black,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
