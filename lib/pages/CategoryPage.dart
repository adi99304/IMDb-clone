import 'package:flutter/material.dart';
import 'package:project/widgets/CustomNavBar.dart';
import 'package:project/pages/ActionDetailPage.dart';
import 'package:project/pages/AdventureDetailPage.dart';
import 'package:project/pages/RomanceDetailPage.dart';
import 'package:project/pages/ComedyDetailPage.dart'; // Import ComedyDetailPage.dart
import 'package:project/pages/DramaDetailPage.dart'; // Import DramaDetailPage.dart

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Discover",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ), // Padding
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActionDetailPage(),
                          ),
                        );
                      },
                      child: _buildGenreItem(
                        imagePath: "images/action.jpeg",
                        genre: "Action",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdventureDetailPage(),
                          ),
                        );
                      },
                      child: _buildGenreItem(
                        imagePath: "images/adventure.png",
                        genre: "Adventure",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RomanceDetailPage(),
                          ),
                        );
                      },
                      child: _buildGenreItem(
                        imagePath: "images/romance.png",
                        genre: "Romance",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ComedyDetailPage(), // Navigate to ComedyDetailPage for comedy genre
                          ),
                        );
                      },
                      child: _buildGenreItem(
                        imagePath: "images/comedy.png",
                        genre: "Comedy",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DramaDetailPage(), // Navigate to DramaDetailPage for drama genre
                          ),
                        );
                      },
                      child: _buildGenreItem(
                        imagePath: "images/drama.png",
                        genre: "Drama",
                      ),
                    ),
                    // Add more genres as needed
                  ],
                ),
              ),
            ],
          ), // Column
        ), // SafeArea
      ), // SingleChildScrollView
      bottomNavigationBar: CustomNavBar(),
    );
  }

  Widget _buildGenreItem({required String imagePath, required String genre}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              height: 70,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            genre,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 23,
          ),
        ],
      ),
    );
  }
}

// You should have separate detail pages for each genre:
// ActionDetailPage.dart, AdventureDetailPage.dart, RomanceDetailPage.dart,
// ComedyDetailPage.dart, DramaDetailPage.dart
// You can implement them similarly to the existing detail pages.
