import 'package:flutter/material.dart';
import 'package:project/pages/MoviePage.dart';

class NewMoviesWidget extends StatelessWidget {
  final List<String> movieNames = [
    "Doctor Strange 2",
    "The Greatest Showman",
    "Titanic",
    "Spider-Man: No Way Home",
    "The Accursed",
    "BADLA",
    "Black Widow",
    "Avatar 3",
    "Wonder Woman",
    "Avengers Endgame"
  ];

  final List<String> movieTypes = [
    "Action/Adventure",
    "Drama/Comedy",
    "Romance/Comedy",
    "Action/Adventure",
    "Horror",
    "Action",
    "Action/Adventure",
    "Action/Sci-fi",
    "Action/Adventure",
    "Action/Adventure"
  ];

  final List<double> ratings = [
    8.5,
    7.9,
    8.2,
    8.1,
    7.7,
    8.4,
    9.2,
    8.0,
    8.6,
    7.8
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "New Movies",
            style: TextStyle(
              color: Colors.amber,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(movieNames.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MoviePage(
                        movieName: movieNames[index],
                        movieType: movieTypes[index],
                        rating: ratings[index],
                        movieImage: "images/${index + 1}.jpg",
                        description: "Your movie description here", videoUrl: '', // Add actual description here
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 200, // Adjust the width as needed
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFF292B37),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF292B37).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.asset(
                          "images/${index + 1}.jpg",
                          height: 250, // Adjust the height as needed
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movieNames[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              movieTypes[index],
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "${ratings[index]}",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
