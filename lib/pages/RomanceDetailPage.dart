import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Romance Genre',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
      ),
      home: RomanceDetailPage(),
    );
  }
}

class RomanceDetailPage extends StatefulWidget {
  @override
  _RomanceDetailPageState createState() => _RomanceDetailPageState();
}

class _RomanceDetailPageState extends State<RomanceDetailPage> {
  final List<String> romanceMovies = [
    'rom (1).jpeg',
    'rom (2).jpeg',
    'rom (3).jpeg',
    'rom (4).jpeg',
    'rom (5).jpeg',
    'rom (6).jpeg',
    'rom (7).jpeg',
    'rom (8).jpeg',
    'rom (9).jpeg',
    'rom (10).jpeg',
    'rom (11).jpeg',
    'rom (12).jpeg',
    'rom (13).jpeg',
    'rom (14).jpeg',
    'rom (15).jpeg',
  ];

  final List<String> movieNames = [
    'Sairat',
    'Fandry',
    'Ved',
    'Animal',
    'Arjun Reddy',
    'Heropanti',
    '365 Days',
    'Jab We Met',
    'The Notebook',
    'When Harry Met Sally',
    'Titanic',
    'Yeh Jawaani Hai Deewani',
    'Kabir Singh',
    'Chennai Express',
    'Aashiqui 2',
  ];

  List<bool> isLiked = List.generate(15, (index) => false);

  // Dummy ratings for demonstration
  final List<double> ratings = [
    9,
    7.9,
    10,
    9,
    6.9,
    8,
    9.9,
    9.1,
    10,
    9.5,
    8,
    7.6,
    8.7,
    4.5,
    8.9
  ];
  Future<void> addLikedMovie(String movieName, String moviePosterName) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('profiles').doc(user.email);
      DocumentSnapshot userSnapshot = await userRef.get();
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      List<dynamic> likedMovies = userData['likedMovies'] ?? [];
      likedMovies.add({'name': movieName, 'poster': moviePosterName});

      await userRef.set({'likedMovies': likedMovies}, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Romance Movies',
          style: TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Featured',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: romanceMovies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        print('Tapped on ${movieNames[index]}');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'images/${romanceMovies[index]}',
                          fit: BoxFit.cover,
                          width: 150,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Popular',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: romanceMovies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.black87,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                              child: Image.asset(
                                'images/${romanceMovies[index]}',
                                fit: BoxFit.cover,
                                height: 180.0, // Increased image height
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movieNames[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 25,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '${ratings[index]}', // Display movie rating
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color:
                                    isLiked[index] ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isLiked[index] = !isLiked[index];
                                });
                                if (isLiked[index]) {
                                  addLikedMovie(
                                      movieNames[index], romanceMovies[index]);
                                }
                                print('Like button pressed');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
