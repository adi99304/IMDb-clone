import 'package:flutter/material.dart';
import 'package:project/pages/MoviePage.dart';

class NewMoviesWidget extends StatelessWidget {
  final List<String> movieNames = [
    "Doctor Strange 2",
    "Pushpa",
    "3 idiots",
    "Anabelle",
    "Jumanji",
    "kgf",
    "Oppenheimer",
    "Spider man No way home",
    "Shaitaan",
    "The Matrix"
  ];

  final List<String> movieTypes = [
    "Action/Adventure",
    "Drama/Action",
    "Romance/Comedy",
    "Horror/Adventure",
    "Action",
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

  final List<List<String>> videoUrlsList = [
    [
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/Videos%2FDoctor%20strange.mp4?alt=media&token=10beb4d8-5ae6-4e03-8d87-63ca582fcfe9'
    ],
    [
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/videos2%2F%23Pushpa%20-%20The%20Rise%20(Hindi)%20Official%20Trailer%20_%20Allu%20Arjun%2C%20Rashmika%2C%20Sunil%2C%20Fahadh%20_%20DSP%20_%20Sukumar.mp4?alt=media&token=6960c195-c134-480c-b3c6-cc31688af917',
    ],
    [
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/videos2%2F3%20Idiots%20Movie%20Trailer%20_%20Aamir%20Khan%2C%20R.%20Madhavan%2C%20Sharman%20Joshi%20_%20Comedy%20Drama%20Movie%20Trailer.mp4?alt=media&token=a9983e96-c40c-43dd-9dd5-f7edbfc37921'
    ],
    [
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/videos2%2FAnnabelle%20-%20Official%20Main%20Trailer%20%5BHD%5D.mp4?alt=media&token=95665015-a143-468b-8783-00bc55c42e42'
    ],
    [
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/videos2%2FJUMANJI_%20WELCOME%20TO%20THE%20JUNGLE%20-%20Official%20Trailer%20(HD).mp4?alt=media&token=12d6d424-aa2e-4806-a8ab-9b9873ceb5b9'
    ],
    [
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/videos2%2FKGF%20Trailer%20Hindi%20_%20Yash%20_%20Srinidhi%20_%2021st%20Dec%202018.mp4?alt=media&token=cf1fd7be-52e9-4a30-ad4d-3600608ccd48'
    ],
    [
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/videos2%2FOppenheimer%20_%20New%20Trailer.mp4?alt=media&token=c9c9bcd7-f983-4802-8f4f-b7183a8901b5'
    ],
    [
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/videos2%2FSPIDER-MAN_%20NO%20WAY%20HOME%20-%20Official%20Trailer%20(HD).mp4?alt=media&token=616d4729-9c6b-4b1b-a08d-13946d03d472'
    ],
    [
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/videos2%2FShaitaan%20Trailer%20_%20Ajay%20Devgn%2C%20R%20Madhavan%2C%20Jyotika%20_%20Jio%20Studios%2C%20Devgn%20Films%2C%20Panorama%20Studios.mp4?alt=media&token=add18ca7-9bee-486f-9e28-72064d4968c5'
    ],
    [
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/videos2%2FTitanic%203D%20Re-Release%20Official%20Trailer%20%231%20-%20Leonardo%20DiCaprio%2C%20Kate%20Winslet%20Movie%20(2012)%20HD.mp4?alt=media&token=11901a6c-ccba-4505-994a-c4e86dd117e5'
    ],
    [
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/videos2%2FThe%20Matrix%20(1999)%20Official%20Trailer%20%231%20-%20Sci-Fi%20Action%20Movie.mp4?alt=media&token=eeb80b45-f855-4da8-b794-183cb99dca68'
    ],

    // Add more lists of video URLs for each movie
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
                        description: "Your movie description here",
                        videoUrls: videoUrlsList[index],
                        videoUrl: '', // Pass corresponding video URLs list
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
