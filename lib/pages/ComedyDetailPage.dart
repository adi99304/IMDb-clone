import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comedy Genre',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
      ),
      home: ComedyDetailPage(),
    );
}
}
class ComedyDetailPage extends StatefulWidget {
  @override
  _ComedyDetailPageState createState() => _ComedyDetailPageState();
}

class _ComedyDetailPageState extends State<ComedyDetailPage> {
  final List<String> comedyMovies = [
    'comedy1.jpeg',
    'comedy2.jpeg',
    'comedy3.jpeg',
    'comedy4.jpeg',
    'comedy5.jpeg',
    'comedy6.jpeg',
    'comedy7.jpeg',
    'comedy8.jpeg',
    'comedy9.jpeg',
    'comedy10.jpeg',
    'comedy11.jpeg',
    'comedy12.jpeg',
    'comedy13.jpeg',
    'comedy14.jpeg',
    'comedy15.jpeg',

  ];

  final List<String> movieNames = [
    'Now You See Me 2',
    'Golmaal Fun Unlimited',
    'Chillar Party',
    'Chup Chup Ke',
    '3 Idiots',
    'Welcome',
    'Garam Masala',
    'Bhool Bhulaiyaa',
    'OMG Oh My God',
    'Rush Hour',
    'Shaolin Soccer',
    'Ashi Hi Banva Banvi',
    'Bullet Train',
    'Phir Hera Pheri',
    'Delhi Belly',
  ];
  
  List<bool> isLiked = List.generate(15, (index) => false);

  // Dummy ratings for demonstration
  final List<double> ratings = [7.8, 7.9, 10, 9, 6.9, 8, 9.9, 9.1,10,9.5,8,7.6,8.7,4.5,8.9];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Comedy Movies',
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
                itemCount: comedyMovies.length,
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
                          'images/${comedyMovies[index]}',
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
              itemCount: comedyMovies.length,
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
                                'images/${comedyMovies[index]}',
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
                                // Handle like button press
                                setState(() {
                                  isLiked[index] = !isLiked[index];
                                });
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
  
 
