import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/pages/AccountPage.dart';
import 'package:project/pages/LoginPage.dart';
import 'package:project/pages/UserPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int imageVersion = 1; // Current version of the profile image

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
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<User?>(
                  future: FirebaseAuth.instance.authStateChanges().first,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      User? user = snapshot.data;
                      return FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('profiles')
                            .doc(user!.email)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            Map<String, dynamic> userData =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/profile%2Fv$imageVersion.jpeg?alt=media&token=3a0a4f1c-9928-459a-b20d-268790f53212'),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  userData['name'] ?? 'No Name',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  user.email ?? 'No Email',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Text('User not found');
                          }
                        },
                      );
                    } else {
                      return Text('User not found');
                    }
                  },
                ),
              ),
              SizedBox(height: 10), // Space before the first container
              _buildAccountContainer(context, 'Edit Profile', Icons.edit),
              SizedBox(height: 0), // Space between containers
              _buildAccountContainer(context, 'Account', Icons.account_circle),
              SizedBox(height: 0), // Space between containers
              _buildAccountContainer(context, 'Watchlist', Icons.watch_later),

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
        } else if (text == 'Edit Profile') {
          // Change the profile image version
          setState(() {
            if (imageVersion < 3) {
              imageVersion++;
            } else {
              imageVersion = 1; // Reset to the first image version
            }
          });
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
        } else if (text == 'Account') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AccountPage()));
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
