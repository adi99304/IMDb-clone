import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F111D),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 150), // Space before the first container
              _buildAccountContainer('Account', Icons.account_circle),
              SizedBox(height: 0), // Space between containers
              _buildAccountContainer('Watchlist', Icons.watch_later),
              SizedBox(height: 0), // Space between containers
              _buildAccountContainer('Display', Icons.display_settings),
              SizedBox(height: 0), // Space between containers
              _buildAccountContainer('Notifications', Icons.email),
              SizedBox(height: 0), // Space between containers
              _buildAccountContainer('Favourites', Icons.favorite_outline),
              SizedBox(height: 0), // Space between containers
              _buildAccountContainer('About', Icons.person),
              SizedBox(height: 0), // Space between containers
              _buildAccountContainer('Sign Out', Icons.arrow_back_sharp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountContainer(String text, IconData icon) {
    return Container(
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
    );
  }
}
