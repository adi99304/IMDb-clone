import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adventure Genre',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
      ),
      home: AdventureDetailPage(),
    );
  }
}

class AdventureDetailPage extends StatefulWidget {
  @override
  _AdventureDetailPageState createState() => _AdventureDetailPageState();
}

class _AdventureDetailPageState extends State<AdventureDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final List<String> adventureMovies = [
    'ad (14).jpeg',
    'ad (13).jpeg',
    'ad (12).jpeg',
    'ad (11).jpeg',
    'ad (10).jpeg',
    'ad (9).jpeg',
    'ad (8).jpeg',
    'ad (7).jpeg',
    'ad (6).jpeg',
    'ad (5).jpeg',
    'ad (4).jpeg',
    'ad (3).jpeg',
    'ad (2).jpeg',
    'ad (1).jpeg',
  ];

  final List<String> movieNames = [
    'Megamind',
    'Zootopia',
    'Ice Age',
    'World war Z',
    'Pirates of the Caribbean: The Curse of the Black Pearl',
    'Avatar:The way of water',
    'The Jungle Book ',
    'Zindagi Na Milegi Dobara',
    'The Lord of the Rings',
    'Harry Potter',
    'Crouching Tiger, Hidden Dragon ',
    'Raiders of the Lost Ark',
    'The Mummy',
    'Moana',
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
          'Adventure Movies',
          style: TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.translate(
                  offset: _slideAnimation.value,
                  child: SingleChildScrollView(
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
                            itemCount: adventureMovies.length,
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
                                      'images/${adventureMovies[index]}',
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: adventureMovies.length,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0),
                                          ),
                                          child: Image.asset(
                                            'images/${adventureMovies[index]}',
                                            fit: BoxFit.cover,
                                            height:
                                                180.0, // Increased image height
                                            width: double.infinity,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                        color: Colors.white,
                                                        fontSize: 20),
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
                                            color: isLiked[index]
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              isLiked[index] = !isLiked[index];
                                            });
                                            if (isLiked[index]) {
                                              addLikedMovie(movieNames[index],
                                                  adventureMovies[index]);
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
                ));
          }),
    );
  }
}
