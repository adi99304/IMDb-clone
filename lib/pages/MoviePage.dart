//'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/Videos%2FDoctor%20strange.mp4?alt=media&token=10beb4d8-5ae6-4e03-8d87-63ca582fcfe9',

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final List<String> videoUrls; // Change type to List<String>

  MoviePage({
    required this.movieName,
    required this.movieType,
    required this.rating,
    required this.movieImage,
    required this.description,
    required this.videoUrls,
    required String videoUrl, // Change type to List<String>
  });

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late VideoPlayerController _controller;
  bool _isVideoLoading = false;
  DeviceOrientation? _deviceOrientation;
  bool _isPlaying = false;
  late Timer _pauseButtonTimer;
  bool _showPauseButton = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _updateOrientation();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pauseButtonTimer.cancel();
    super.dispose();
  }

  void _updateOrientation() {
    final orientation = MediaQuery.of(context).orientation;
    setState(() {
      _deviceOrientation = orientation == Orientation.portrait
          ? DeviceOrientation.portraitUp
          : DeviceOrientation.landscapeRight;
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  void _handlePauseButtonVisibility() {
    if (_showPauseButton) {
      _pauseButtonTimer = Timer(Duration(seconds: 2), () {
        setState(() {
          _showPauseButton = false;
        });
      });
    } else {
      setState(() {
        _showPauseButton = true;
      });
    }
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.network(
      widget.videoUrls[
          0], // Choose the video URL based on index (e.g., 0 for the first trailer)
    )..initialize().then((_) {
        _controller.play();
        _isPlaying = true;
        setState(() {});
      });
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
                              clipper: MovieImageClipper(),
                              child: Image.asset(
                                widget.movieImage,
                                height: 250,
                                width: 200,
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
                                _initializeVideoPlayer();
                              } else {
                                _togglePlayPause();
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
              child: GestureDetector(
                onTap: _handlePauseButtonVisibility,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.black,
                    ),
                    Center(
                      child: _deviceOrientation == DeviceOrientation.portraitUp
                          ? FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: _controller.value.size.width,
                                height: _controller.value.size.height,
                                child: VideoPlayer(_controller),
                              ),
                            )
                          : AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                    ),
                    if (_showPauseButton)
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: _togglePlayPause,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                              ),
                              child: Text(
                                _isPlaying ? 'Pause' : 'Play',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70),
                              ),
                            ),
                          ],
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
