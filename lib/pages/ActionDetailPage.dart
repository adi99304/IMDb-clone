import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActionDetailPage extends StatefulWidget {
  @override
  _ActionDetailPageState createState() => _ActionDetailPageState();
}

class _ActionDetailPageState extends State<ActionDetailPage> {
  final List<String> actionMovies = [
    'mw-1.jpeg',
    'mw-2.jpeg',
    'mw-3.jpeg',
    'mw-4.jpeg',
    'mw-5.jpeg',
    'mw-6.jpeg',
    'mw-7.jpeg',
    'mw-8.jpeg',
    'mw-9.jpeg',
  ];

  final List<String> movieNames = [
    'The Avengers',
    'Mission Impossible',
    'Die Hard',
    'Mad Max: Fury Road',
    'John Wick',
    'The Dark Knight',
    'Inception',
    'Gladiator',
    'Terminator',
  ];

  List<bool> isLiked = List.generate(9, (index) => false);

  // Dummy ratings for demonstration
  final List<double> ratings = [
    7.8,
    8,
    9,
    7.9,
    10,
    9,
    6.9,
    8,
    9.9,
  ];

  Future<void> addLikedMovie(String movieName, String moviePosterName) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('profiles').doc(user.email);
      DocumentSnapshot userSnapshot = await userRef.get();
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;

      List<dynamic> likedMovies = userData?['likedMovies'] ?? [];
      likedMovies.add({'name': movieName, 'poster': moviePosterName});

      await userRef.set({'likedMovies': likedMovies}, SetOptions(merge: true));
    }
  }

  void _navigateToMovieDetails(String movieName, String moviePoster) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(
          movieName: movieName,
          moviePoster: moviePoster,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Action Movies',
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
                itemCount: actionMovies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        _navigateToMovieDetails(
                            movieNames[index], actionMovies[index]);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'images/${actionMovies[index]}',
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
              itemCount: actionMovies.length,
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
                                'images/${actionMovies[index]}',
                                fit: BoxFit.cover,
                                height: 180.0,
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
                                        '${ratings[index]}',
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
                                      movieNames[index], actionMovies[index]);
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

class MovieDetailsPage extends StatefulWidget {
  final String movieName;
  final String moviePoster;

  MovieDetailsPage({required this.movieName, required this.moviePoster});

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  TextEditingController _reviewController = TextEditingController();
  CollectionReference reviews =
      FirebaseFirestore.instance.collection('reviews');

  void _submitReview() async {
    String review = _reviewController.text;
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userName = user.email!;
      await reviews.add({
        'movie': widget.movieName,
        'review': review,
        'userName': userName,
        'timestamp': Timestamp.now(),
      });
      _reviewController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please sign in to submit a review')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.movieName, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow),
            ),
            SizedBox(height: 8),
            Text(
              'Add description of the movie here...', // You can replace this with actual description
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Reviews:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow),
            ),
            SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: reviews
                    .where('movie', isEqualTo: widget.movieName)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No reviews yet.'));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var reviewData = snapshot.data!.docs[index].data();
                      return ReviewTile(
                          review: Review.fromMap(
                              reviewData as Map<String, dynamic>));
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            TextField(
              cursorColor: Colors.white,
              controller: _reviewController,
              style: TextStyle(color: Colors.white), // Set text color to white
              decoration: InputDecoration(
                labelText: 'Add your review',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),

              minLines: 3,
              maxLines: 5,
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _submitReview,
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String userId;
  final String review;
  final String displayName;
  final Timestamp timestamp;

  Review({
    required this.userId,
    required this.review,
    required this.displayName,
    required this.timestamp,
    required MaterialColor color,
  });

  factory Review.fromMap(Map<String, dynamic> data) {
    return Review(
        userId: data['userId'] ?? '',
        review: data['review'] ?? '',
        displayName: data['displayName'] ?? '',
        timestamp: data['timestamp'] ?? Timestamp.now(),
        color: Colors.amber);
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'review': review,
      'displayName': displayName,
      'timestamp': timestamp,
    };
  }
}

class ReviewTile extends StatelessWidget {
  final Review review;

  ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: Text(
              'A', // Display Text A
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.displayName.isNotEmpty
                      ? review.displayName.substring(0, 2).toUpperCase()
                      : '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(review.review),
                ),
                SizedBox(height: 4.0),
                Text(
                  review.timestamp.toDate().toString(),
                  style:
                      TextStyle(color: Colors.yellow.shade300, fontSize: 12.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ActionDetailPage(),
  ));
}
