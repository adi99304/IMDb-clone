// 'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/Doctor%20strange.mp4?alt=media&token=d8a1570b-e61a-45c6-8cec-011843584623',

import 'package:flutter/material.dart';
import 'package:project/widgets/CustomNavBar.dart';
import 'package:project/widgets/MoviePageButtons.dart';
import 'package:project/widgets/RecommendedWidget.dart';
import 'package:video_player/video_player.dart';

class MoviePage extends StatefulWidget {
  final String movieName;
  final String movieType;
  final double rating;
  final String movieImage;
  final String description;
  final String videoUrl;

  MoviePage({
    required this.movieName,
    required this.movieType,
    required this.rating,
    required this.movieImage,
    required this.description,
    required this.videoUrl,
  });

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late VideoPlayerController _controller;
  bool _isVideoLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Image.asset(
              widget.movieImage,
              height: 450,
              width: 400,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 8,
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: ClipRect(
                              clipper: MovieImageClipper(), // Custom clipper
                              child: Image.asset(
                                widget.movieImage,
                                height: 250, // Same height
                                width: 200, // Increased width
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                    margin: EdgeInsets.only(right: 50, top: 70),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.red,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 60,
                      ),
                      onPressed: () {
                        if (!_isVideoLoading) {
                          setState(() {
                            _isVideoLoading = true;
                          });
                          _controller = VideoPlayerController.network(
                            'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/Doctor%20strange.mp4?alt=media&token=d8a1570b-e61a-45c6-8cec-011843584623',

                          )..initialize().then((_) {
                              _controller.play();
                            });
                        }
                      },
                    ),
                  ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  MoviePageButtons(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.movieName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          widget.description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RecommendWidget(),
                ],
              ),
            ),
          ),
          if (_isVideoLoading)
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(_controller),
                    Center(
                      child: IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white38,
                          size: 40,
                          
                        ),
                        onPressed: () {
                          setState(() {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_isVideoLoading)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
              ),
            ),
        ],
      ),
      bottomNavigationBar: _isVideoLoading ? null : CustomNavBar(),
    );
  }
}

class MovieImageClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(
      -40,
      size.height * 0.01,
      size.width * 1.3,
      size.height * 1.0,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}