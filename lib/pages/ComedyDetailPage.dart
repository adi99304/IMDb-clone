import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comedy Detail"),
      ),
      body: Center(
        child: Text("Details for Comedy Genre"),
      ),
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
    'comedy16.jpeg',
    'comedy17.jpeg',

  ];

  final List<String> movieNames = [
    'Now You See Me 2',
    'Boys',
    'Golmaal Fun Unlimited',
    'Chillar Party',
    'Poshter Boys',
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
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  }
