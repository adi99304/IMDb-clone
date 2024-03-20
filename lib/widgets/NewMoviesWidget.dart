import 'package:flutter/material.dart';

class NewMoviesWidget extends StatelessWidget {
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
                "New Movies",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ), //textstyle
              ), //text
              Text(
                "See All",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                ), //textstyle
              ), //text
            ],
          ), //row
        ), //padding
        SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 1; i < 11; i++)
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "moviePage");
                  },
                  child: Container(
                    width: 190,
                    height: 350,
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF292B37),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF292B37).withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 6,
                        ),
                      ],
                    ), //Boxdecoration
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ), //borderradius.only
                          child: Image.asset(
                            "images/$i.jpg",
                            height: 250,
                            width: 200,
                            fit: BoxFit.cover,
                          ), //imageasset
                        ), //clipprect
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ), //edgeinsets
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Doctor Strange 2",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500,
                                ), //textstyle
                              ), //text
                              SizedBox(height: 5),
                              Text(
                                "Action/Adventure",
                                style: TextStyle(
                                  color: Colors.white54,
                                ), //textstyle
                              ), //text
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ), //icon
                                  SizedBox(width: 5),
                                  Text(
                                    "8.5",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16,
                                    ), //textstyle
                                  ), //text
                                ],
                              ), //row
                            ],
                          ), //column
                        ), //padding
                      ],
                    ), //column
                  ), //container
                ), //inkwell
            ],
          ), //row
        ), //singlechildscrollview
      ],
    ); //column
  }
}
