import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account', style: TextStyle(color: Colors.lightBlue)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('images/profile.jpeg'),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ADITYA HEGDE',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '#Movies Lover',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.lightBlue.shade100,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              _buildInfoItem('Name', 'Aditya Hegde'),
              _buildInfoItem('Email', 'adiaryanbrothers@gmail.com'),
              _buildInfoItem('Phone', '+91 ....'),
              _buildInfoItem('Address', 'xyz'),
              _buildInfoItem('DOB', '17 May, 2004'),
              // Add more info items as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
