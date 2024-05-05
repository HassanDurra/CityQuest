import 'dart:convert';

import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/config/webapi.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:http/http.dart' as http;

class CityDetails extends StatefulWidget {
  final String? id;
  const CityDetails({Key? key, this.id});

  @override
  State<CityDetails> createState() => _CityDetailsState();
}

class _CityDetailsState extends State<CityDetails> {
  int _currentIndex = 0;
  double _userRating = 0.0; // Track user's selected rating

  @override
  void initState() {
    super.initState();
    get_city();
  }

  Map<String, dynamic> city_info = {};

  Future<void> get_city() async {
    var Url = Uri.parse(ApiCredientals.base_path +
        'CityQuestWEB/City/single_city?id=${widget.id}');
    var response = await http.get(Url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData != null) {
        setState(() {
          city_info = jsonData[0];
        });
      }
    }
  }

  final List<String> _images = [
    'images/quaid.jpg',
    'images/tomb.jpg',
    'images/mazar.jpg',
    'images/mazarequaid.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(city_info['name'] ?? 'City Name'),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Implement your logic to show preview on image click
                    },
                    child: InstaImageViewer(
                      child: ClipRRect(
                        child: Image.asset(
                          'images/cocktail_bar.jpg',
                          width: screenWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Ionicons.heart_circle_outline,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.location_on,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      city_info['name'] ?? "City Name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            '4.0', // Replace with your average rating
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  city_info['long_description'] ?? "City Description",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Attractions And Activites",
                  style: TextStyle(
                    color: GlobalColors.mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              CarouselSlider(
                items: [
                  // Button items
                  buildCategoryButton(
                      "Foods and Restaurants", Icons.restaurant),
                  buildCategoryButton("Hotels", Icons.hotel),
                  buildCategoryButton("Shopping", Icons.shopping_cart),
                  buildCategoryButton("Attractions", Icons.location_pin),
                  buildCategoryButton("Events", Icons.event),
                  buildCategoryButton("Activities", Icons.directions_run),
                ].take(4).toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    height: 60,
                    enlargeCenterPage: true,
                    viewportFraction: 0.4,
                    aspectRatio: 0.4),
              ),

              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Reviews',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red, // Change color as needed
                  ),
                ),
              ),
              SizedBox(height: 8),
              // Add your testimonials slider here
              CarouselSlider(
                items: [
                  // Testimonial items
                  Container(
                    child: Text('Testimonial 1'),
                  ),
                  Container(
                    child: Text('Testimonial 2'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Align items in the center vertically
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Align items in the center horizontally
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              Image.asset('images/cocktail_bar.jpg').image,
                          radius: 30,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Hassan'),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Align stars in the center horizontally
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                '4.0', // Replace with your average rating
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('This is my message for you')
                      ],
                    ),
                  ),
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  height: 200,
                  enlargeCenterPage: true,
                ),
              ),

              SizedBox(height: 8),
              // Add your review section here
              Row(
                children: [
                  for (int i = 1; i <= 5; i++)
                    IconButton(
                      icon: Icon(
                        _userRating >= i ? Icons.star : Icons.star_border,
                        color: Colors.yellow,
                      ),
                      onPressed: () {
                        setState(() {
                          _userRating = i.toDouble();
                        });
                      },
                    ),
                ],
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Write a Review',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Write your review...',
                        border: OutlineInputBorder(),
                      ),
                      minLines: 3,
                      maxLines: 5,
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Add your logic to submit review
                      },
                      child: Text('Submit Review'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCategoryButton(String label, IconData icon) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: GlobalColors.mainColor),
      borderRadius: BorderRadius.circular(30),
    ),
    child: ElevatedButton.icon(
      onPressed: () {
        // Add your onPressed logic here
      },
      icon: Icon(
        icon,
        color: GlobalColors.mainColor,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: GlobalColors.mainColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}
