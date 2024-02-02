import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Option 1
              },
              child: Text('USERNAME'),
            ),
            ElevatedButton(
              onPressed: () {
                // Option 2
              },
              child: Text('WATCHLIST'),
            ),
            ElevatedButton(
              onPressed: () {
                // Option 3
              },
              child: Text('REDEEM'),
            ),
            ElevatedButton(
              onPressed: () {
                // Option 4
              },
              child: Text('SETTINGS'),
            ),
            ElevatedButton(
              onPressed: () {
                // Option 5
              },
              child: Text('FAVORITES'),
            ),
            ElevatedButton(
              onPressed: () {
                // Option 6
              },
              child: Text('LOGOUT'),
            ),
            // You can continue to add more options/buttons as needed
          ],
        ),
      ),
    );
  }
}
