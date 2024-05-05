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
  final TextEditingController messageController = TextEditingController();
  int _currentIndex = 0;
  double _userRating = 0.0; // Track user's selected rating

  @override
  void initState() {
    super.initState();
    get_city();
    getReviews();
  }

  Map<String, dynamic> city_info = {};
  List<Map<String, dynamic>> user_reviews = [];
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

  Future<void> getReviews() async {
    var Url = Uri.parse(ApiCredientals.base_path +
        'CityQuestWEB/City/getCityReviews?type=city&id=${widget.id}');
    var response = await http.get(Url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['message'] == 'success') {
        if (jsonData['data'] != null) {
          setState(() {
            user_reviews
                .addAll(List<Map<String, dynamic>>.from(jsonData['data']));
          });
        }
      }
    }
  }

  Future<void> addFavorite() async {
    var URL =
        Uri.parse(ApiCredientals.base_path + "CityQuestWEB/Review/favorite");
    var response = await http.post(URL, body: {
      'user_id': '82',
      'content_id': city_info['id'].toString() ?? "",
      'content_type': 'city'
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['message'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.checkbox_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Text('City Added to Favorites!'),
                ],
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2)),
        );
        setState(() {
          messageController.text = "";
          _userRating = 0;
        });
      } else if (jsonData['message'] == 'error') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Text('An error occured \n while saving review'),
                ],
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Text('${jsonData['message']}'),
                ],
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2)),
        );
      }
    }
  }

  Future<void> give_reviews() async {
    if (messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Row(
              children: [
                Icon(
                  Ionicons.alert_circle_outline,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 9,
                ),
                Text('Please Enter your Message'),
              ],
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2)),
      );
    } else {
      var URL =
          Uri.parse(ApiCredientals.base_path + "CityQuestWEB/Review/store");
      var response = await http.post(URL, body: {
        'user_id': '82',
        'content_id': city_info['id'].toString() ?? "",
        'message': messageController.text,
        'ratings': _userRating.toString(),
        'type': 'city'
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['message'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Row(
                  children: [
                    Icon(
                      Ionicons.checkbox_outline,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Text('Thanks for your review!'),
                  ],
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2)),
          );
          setState(() {
            messageController.text = "";
            _userRating = 0;
            getReviews();
          });
        } else if (jsonData['message'] == 'error') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Row(
                  children: [
                    Icon(
                      Ionicons.alert_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Text('An error occured \n while saving review'),
                  ],
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Row(
                  children: [
                    Icon(
                      Ionicons.alert_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Text('${jsonData['message']}'),
                  ],
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2)),
          );
        }
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
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      city_info['name'] ?? "City Name",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
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
                          child: Tooltip(
                            message: "Get Direction",
                            child: InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
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
                            child: Tooltip(
                              message: 'Add to Favorites',
                              child: InkWell(
                                onTap: () {
                                  addFavorite();
                                },
                                child: Icon(
                                  Ionicons.heart_circle_outline,
                                  color: Colors.red,
                                ),
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 10,
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
              user_reviews != null
                  ? CarouselSlider(
                      items: user_reviews.map((review) {
                        return Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(review['user_image']),
                                radius: 30,
                              ),
                              SizedBox(height: 10),
                              Text(review['user_name']),
                              SizedBox(height: 5),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0;
                                        i < int.parse(review['ratings']);
                                        i++)
                                      Icon(Icons.star, color: Colors.yellow),
                                    for (int i = 0;
                                        i < 5 - int.parse(review['ratings']);
                                        i++)
                                      Icon(Icons.star, color: Colors.grey),
                                    SizedBox(width: 8),
                                    Text(
                                      review['ratings'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(review['message']),
                            ],
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 200,
                        enlargeCenterPage: true,
                        aspectRatio: 0.4,
                        viewportFraction: 0.4,
                      ),
                    )
                  : Center(
                      child: Text("No Reviews"),
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
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Write your review...',
                        border: OutlineInputBorder(),
                      ),
                      minLines: 3,
                      maxLines: 5,
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(GlobalColors.mainColor),
                          padding:
                              MaterialStatePropertyAll(EdgeInsets.all(10))),
                      onPressed: () {
                        give_reviews();
                      },
                      child: Text(
                        'Submit Review',
                        style: TextStyle(color: Colors.white),
                      ),
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
