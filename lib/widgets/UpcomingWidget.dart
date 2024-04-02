import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class UpcomingWidget extends StatefulWidget {
  @override
  _UpcomingWidgetState createState() => _UpcomingWidgetState();
}

class _UpcomingWidgetState extends State<UpcomingWidget> {
  late CarouselController _carouselController;
  late List<String> _videoUrls;
  late List<String> _imageUrls;
  late List<VideoPlayerController> _controllers;
  int _currentSlideIndex = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
    _videoUrls = [
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/Videos%2FDoctor%20strange.mp4?alt=media&token=10beb4d8-5ae6-4e03-8d87-63ca582fcfe9',
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/Videos%2FThe%20Conjuring%20-%20Official%20Main%20Trailer%20%5BHD%5D.mp4?alt=media&token=0e45b008-17ff-4379-b1d2-356ef7840e07',
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/Videos%2F_Thor_%20Ragnarok_%20Official%20Trailer.mp4?alt=media&token=aa3075c8-440c-4ebd-acc1-5148e5a45a9a',
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/Videos%2Fvideoplayback.mp4?alt=media&token=d02e004f-755e-411f-a76d-ec6c4dc56c86',
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/Videos%2FTitanic%203D%20Re-Release%20Official%20Trailer%20%231%20-%20Leonardo%20DiCaprio%2C%20Kate%20Winslet%20Movie%20(2012)%20HD.mp4?alt=media&token=57d8ea81-ff2e-4155-98fe-f1a07c41c2d3',
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/Videos%2FNO%20HARD%20FEELINGS%20%E2%80%93%20Official%20Red%20Band%20Trailer%20(HD).mp4?alt=media&token=25e651a1-8412-4021-a009-86c0d716568b',
    ];
    _imageUrls = [
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/images%2Fimages%20(1).jpeg?alt=media&token=1dc93a02-9bd1-4224-b0ee-0030d6004fd8',
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/images%2FThe%20Conjuring.jpg?alt=media&token=93b85ddf-187a-4ef0-bd61-c6843bcb2e68',
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/images%2Fimages.jpeg?alt=media&token=e0931de1-0e4b-4912-8ac6-ad843db78edd',
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/images%2FMarvels.jpg?alt=media&token=a80f2bc4-d557-4b01-a676-3c212264891c',
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/images%2F3.jpg?alt=media&token=ccce6166-deb7-4f60-843f-1d4485333875',
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/images%2FNo%20hard%20feelings.jpeg?alt=media&token=b1a6f202-88f5-4f59-a588-6f433bf53891',
    ];
    _controllers = List.generate(
      _videoUrls.length,
      (index) => VideoPlayerController.network(_videoUrls[index]),
    );
    _initializeVideoControllers();
  }

  void _initializeVideoControllers() async {
    for (final controller in _controllers) {
      await controller.initialize();
      controller.setLooping(false);
      // Play the video by default
      controller.addListener(() {
        if (controller.value.position == controller.value.duration) {
          _carouselController.nextPage();
        }
      });
    }
    setState(() {});
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Upcoming Movies",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 15),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.black,
            child: CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: _videoUrls.length,
              options: CarouselOptions(
                height: 300,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                onPageChanged: (index, _) {
                  setState(() {
                    _currentSlideIndex = index;
                  });
                },
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_controllers[index].value.isPlaying) {
                        _controllers[index].pause();
                      } else {
                        _controllers[index].play();
                      }
                    });
                  },
                  child: Stack(
                    children: [
                      VideoPlayer(_controllers[index]),
                      Center(
                        child: IconButton(
                          icon: Icon(
                            _controllers[index].value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_controllers[index].value.isPlaying) {
                                _controllers[index].pause();
                              } else {
                                _controllers[index].play();
                              }
                            });
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(Icons.fullscreen),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullscreenTrailerScreen(
                                  videoUrl: _videoUrls[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Visibility(
                        visible: !_controllers[index].value.isPlaying,
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Image.network(
                            _imageUrls[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _videoUrls.length,
            (index) => Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentSlideIndex == index
                    ? Color.fromARGB(255, 9, 9, 9)
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FullscreenTrailerScreen extends StatefulWidget {
  final String videoUrl;

  FullscreenTrailerScreen({required this.videoUrl});

  @override
  _FullscreenTrailerScreenState createState() =>
      _FullscreenTrailerScreenState();
}

class _FullscreenTrailerScreenState extends State<FullscreenTrailerScreen> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
