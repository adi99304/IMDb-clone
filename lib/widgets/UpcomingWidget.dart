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
  late List<String> _imageUrls; // Add list for image URLs
  late List<VideoPlayerController> _controllers;
  int _currentSlideIndex = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
    _videoUrls = [
      // Add your video URLs here
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/Doctor%20strange.mp4?alt=media&token=ab104d05-624b-42af-90d9-984cdcd6b424',
      // Add more video URLs if needed
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/Doctor%20strange.mp4?alt=media&token=ab104d05-624b-42af-90d9-984cdcd6b424',
    ];
    _imageUrls = [
      // Add your image URLs here
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/images%2Fdownload%20(2).jpeg?alt=media&token=855787d3-1156-4a18-bd60-00b0c08a36a8',
      'https://firebasestorage.googleapis.com/v0/b/imdb-1bdbd.appspot.com/o/images%2Fimages.jpeg?alt=media&token=e0931de1-0e4b-4912-8ac6-ad843db78edd',
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
          // Video playback finished, move to the next slide
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
            color: Colors.black, // Set background color to black
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
                return Stack(
                  children: [
                    // Video Player
                    VideoPlayer(_controllers[index]),
                    // Play/Pause Button
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
                    // Image Overlay
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_controllers[index].value.isPlaying) {
                            _controllers[index].pause();
                          } else {
                            _controllers[index].play();
                          }
                        });
                      },
                      child: Visibility(
                        visible: !_controllers[index].value.isPlaying,
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Image.network(
                            _imageUrls[index], // Use corresponding image URL
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ],
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
