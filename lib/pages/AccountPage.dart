import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _profileIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                      .doc(user?.email ?? 'default_email')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      Map<String, dynamic> userData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildProfileAvatar(user?.email ?? 'default_email'),
                          SizedBox(height: 20),
                          Text(
                            userData['name'] ?? 'Name not found',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            userData['whatAreYou'] ?? 'What are you not found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.lightBlue.shade100,
                            ),
                          ),
                          SizedBox(height: 30),
                          _buildInfoItem(
                            'Email',
                            user?.email ?? 'Email not found',
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
      ),
    );
  }

  Widget _buildProfileAvatar(String userEmail) {
    return FutureBuilder<Image>(
      future: _getProfileImage(userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          Image image = snapshot.data!;
          return CircleAvatar(
            radius: 50.0,
            backgroundImage: image.image,
          );
        } else {
          return Text('Image not found');
        }
      },
    );
  }

  Future<Image> _getProfileImage(String userEmail) async {
    try {
      // Replace this with your actual image URL logic
      final imageUrl =
          'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/profile%2Fv1.jpeg?alt=media&token=3a0a4f1c-9928-459a-b20d-268790f53212';
      final response = await NetworkAssetBundle(Uri.parse(imageUrl)).load('');
      return Image.memory(response.buffer.asUint8List());
    } catch (e) {
      print('Error getting profile image: $e');
      return Image.asset(
        'assets/default_profile.png',
        package: 'your_package_name', // Change to your actual package name
      );
    }
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
