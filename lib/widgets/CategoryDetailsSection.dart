import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoryDetailsScreen(category: 1),
    );
  }
}

class CategoryDetailsScreen extends StatelessWidget {
  final int category;
  final List<Color> backgroundColors = [
    Colors.blueAccent,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.tealAccent,
    Colors.amberAccent,
    Colors.deepOrangeAccent,
    Colors.pinkAccent,
    Colors.indigoAccent,
  ];

  CategoryDetailsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("CATEGORY $category DETAILS"),
      ),
      body: SafeArea(
        child: Hero(
          tag: 'category_$category',
          child: Container(
            color: backgroundColors[category - 1],
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Category $category",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Discover more about Category $category here. This is a creative and informative description that showcases the uniqueness of this category.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                     itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to item details page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemDetailsScreen(
                                itemName: "Item ${index + 1}",
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text("Item ${index + 1}"),
                          subtitle: Text("Description of item ${index + 1}"),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}

class ItemDetailsScreen extends StatelessWidget {
  final String itemName;

  ItemDetailsScreen({required this.itemName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
      ),
      body: Center(
        child: Text("Details for $itemName go here."),
      ),
    );
  }
}