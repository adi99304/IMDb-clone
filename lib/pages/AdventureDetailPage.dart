// AdventureDetailPage.dart
import 'package:flutter/material.dart';

class AdventureDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adventure Detail"),
      ),
      body: Center(
        child: Text("Details for Adventure Genre"),
      ),
    );
  }
}
