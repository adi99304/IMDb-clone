import 'package:flutter/material.dart';
import 'package:project/widgets/CustomNavBar.dart';
import 'package:project/widgets/NewMoviesWidget.dart';
import 'package:project/widgets/UpcomingWidget.dart';

class MovieSearchPage extends StatefulWidget {
  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  List<String> movieNames = [
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
    'The Avengers',
    'Mission Impossible',
    'Die Hard',
    'Mad Max: Fury Road',
    'John Wick',
    'The Dark Knight',
    'Inception',
    'Gladiator',
    'Terminator',
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
    // Add more movie names as needed
  ];
  List<String> filteredMovieNames = [];

  @override
  void initState() {
    super.initState();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      movieNames.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredMovieNames.clear();
        filteredMovieNames.addAll(dummyListData);
      });
    } else {
      setState(() {
        filteredMovieNames.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xFF292B37),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white54,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMovieNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    filteredMovieNames[index],
                    style: TextStyle(
                        color: Colors.yellow), // Change font color to yellow
                  ),
                  // Add onTap function for handling movie selection
                  onTap: () {
                    // Add your logic here for handling movie selection
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.dashboard,
                            color:
                                Colors.yellow, // Change button color to yellow
                          ),
                          onPressed: () {
                            // Add your dashboard logic here
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.yellow, // Change button color to yellow
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieSearchPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showProfileOptions(context);
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            Colors.yellow, // Change button color to yellow
                        backgroundImage: AssetImage("images/profile.jpeg"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              UpcomingWidget(),
              SizedBox(height: 40),
              NewMoviesWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }

  void _showProfileOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit Profile'),
                onTap: () {
                  // Add logic to edit profile
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  // Add logout logic
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
