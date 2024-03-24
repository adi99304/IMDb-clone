import 'package:flutter/material.dart';

class RomanceDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Romance Detail"),
      ),
      body: Container(
        child: Center(
          child: Text("Details for Romance Genre"),
        ),
      ),
    );
  }
}
