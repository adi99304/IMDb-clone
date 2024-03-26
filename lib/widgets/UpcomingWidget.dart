import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class UpcomingWidget extends StatefulWidget {
  @override
  _UpcomingWidgetState createState() => _UpcomingWidgetState();
}

class _UpcomingWidgetState extends State<UpcomingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.5, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start animation
    _controller.repeat(reverse: true);

    super.initState();
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
        CarouselSlider.builder(
          itemCount: 10000, // Large number to make it virtually infinite
          options: CarouselOptions(
            height: 250,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            enableInfiniteScroll: true,
            autoPlayInterval: Duration(seconds: 4),
            scrollDirection: Axis.horizontal,
          ),
          itemBuilder: (BuildContext context, int index, int realIndex) {
            final movieIndex =
                (index % 4) + 1; // Assuming you have 4 upcoming movies
            return AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: _animation.value,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "images/up$movieIndex.jpg",
                        height: 250,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
