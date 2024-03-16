import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final List<String> moviePosterNames = [
    'movie_poster_1.jpeg',
    'movie_poster_2.jpeg',
    'movie_poster_3.jpeg',
    'movie_poster_4.jpeg',
    'movie_poster_5.jpeg',
    'movie_poster_6.jpeg',
    'movie_poster_7.jpeg',
    'movie_poster_8.jpeg',
    'movie_poster_9.jpeg',
    // Add more file names as needed
  ];
  final List<String> favoritemovies = [
    'movie_poster_1.jpeg',
    'movie_poster_2.jpeg',
    'movie_poster_3.jpeg',
    'movie_poster_4.jpeg',
    'movie_poster_5.jpeg',
    'movie_poster_6.jpeg',
    'movie_poster_7.jpeg',
    'movie_poster_8.jpeg',
    'movie_poster_9.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('images/profile.jpeg'),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Aditya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
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
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Watchlist',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle "View All" button press
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    SizedBox(
                      height:
                          225.0, // Adjust this value according to your needs
                      child: ListView.builder(
                        itemCount: moviePosterNames.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 150.0,
                            height: 225.0,
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    'images/${moviePosterNames[index]}'),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    Row(children: [
                      Padding(padding: EdgeInsets.only(left: 14.0)),
                      SizedBox(
                        height: 20.0,
                        child: Text(
                          'Favorite Movies',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
                    Padding(padding: EdgeInsets.all(8.0)),
                    SizedBox(
                      height:
                          225.0, // Adjust this value according to your needs
                      child: ListView.builder(
                        itemCount: moviePosterNames.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 150.0,
                            height: 225.0,
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    'images/${moviePosterNames[index]}'),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
