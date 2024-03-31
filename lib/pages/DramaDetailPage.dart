import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drama Genre',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
      ),
      home: DramaDetailPage(),
    );
  }
}

class DramaDetailPage extends StatefulWidget {
  @override
  _DramaDetailPageState createState() => _DramaDetailPageState();
}

class _DramaDetailPageState extends State<DramaDetailPage> {
  final List<String> dramaMovies = [
    'dra (1).jpeg',
    'dra (2).jpeg',
    'dra (3).jpeg',
    'dra (4).jpeg',
    'dra (5).jpeg',
    'dra (6).jpeg',
    'dra (7).jpeg',
    'dra (8).jpeg',
    'dra (9).jpeg',
    'dra (10).jpeg',
    'dra (11).jpeg',
    'dra (12).jpeg',
    'dra (13).jpeg',
    'dra (14).jpeg',
  ];

  final List<String> movieNames = [
    'Parasite',
    'The Shawshank Redemption ',
    "Schindler's List",
    'Shutter Island',
    'Dangal',
    'Dear Zindagi ',
    'Maqbool ',
    'Mardaani',
    'A Wednesday',
    'Neerja',
    'Andhadhun',
    'Lagaan',
    'Taare Zameen Par',
    'Mother India',
  ];

  List<bool> isLiked = List.generate(14, (index) => false);

  // Dummy ratings for demonstration
  final List<double> ratings = [
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
          'Drama Movies',
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
                itemCount: dramaMovies.length,
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
                          'images/${dramaMovies[index]}',
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
              itemCount: dramaMovies.length,
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
                                'images/${dramaMovies[index]}',
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
                                      movieNames[index], dramaMovies[index]);
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
