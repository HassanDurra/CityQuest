import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/config/webapi.dart';
import 'package:cityquest/view/widgets/User/pages/Cities_details.dart';
import 'package:cityquest/view/widgets/User/pages/attraction.dart';
import 'package:cityquest/view/widgets/User/partial/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';

class Cities extends StatefulWidget {
  const Cities({Key? key}) : super(key: key);

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  final List<Map<String, dynamic>> cities = [];

  Future<void> getCities() async {
    try {
      var response = await http.get(
          Uri.parse(ApiCredientals.base_path + "CityQuestWeb/City/get_cities"));
      var data = json.decode(response.body);
      if (data['message'] == 'success') {
        setState(() {
          cities.addAll(List<Map<String, dynamic>>.from(data['data']));
        });
      } else {
        // Handle error message
        print('Error: ${data['message']}');
      }
    } catch (e) {
      // Handle network or parsing errors
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getCities();
  }

  TextEditingController searchController = TextEditingController();
  String filter = '';
  String selectedCategory = 'All'; // Initially set to 'All'

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCities = cities.where((city) {
      return city['name'].toLowerCase().contains(filter) ||
          city['short_description'].toLowerCase().contains(filter);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        title: Text(
          'Cities',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Text('Filter'),
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selectedCategory = 'All'; // Set back to 'All'
                filter = ''; // Clear the filter
              });
            },
            icon: Icon(Ionicons.filter_outline,
                color: Colors.black), // Clear filter button
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Search By Name',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    suffixIcon: IconButton(
                      onPressed: () => searchController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      filter = value.toLowerCase();
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: filteredCities.isNotEmpty
                  ? ListView.builder(
                      itemCount: (filteredCities.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        int firstIndex = index * 2;
                        int secondIndex = index * 2 + 1;
                        return Row(
                          children: [
                            if (firstIndex < filteredCities.length)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildCard(filteredCities[firstIndex],
                                      index),
                                ),
                              ),
                            if (secondIndex < filteredCities.length)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildCard(filteredCities[secondIndex],
                                     index),
                                ),
                              ),
                          ],
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No result found',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(Map<String, dynamic> city, filtered) {
    return Container(
      child: InkWell(
        onTap: () {
          Get.to(() => CityDetails(id: city['id']));
        },
        child: CityCard(
          imagePath: city['image'],
          id: city['id'],
          cityLength: city.length.toString(),
          cityname: city['name'],
          description: city['short_description'],
          rating: city['total_ratings'] ??
              "0", // Assuming 'rating' is a key in your city map
          reviewsCount: city['total_reviews'] ??
              "0", // Assuming 'reviews_count' is a key in your city map
        ),
      ),
    );
  }

  Future<Uint8List> _fetchImage(String url) async {
    final response = await http.get(Uri.parse('$url'));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Cities(),
  ));
}

class CityCard extends StatelessWidget {
  final String? imagePath;
  final String? id;
  final String? cityLength;
  final String? cityname;
  final String? description;
  final String? rating;
  final String? reviewsCount;
  final Color? starColor;
  final Color? ratingTextColor;
  final Color? reviewsCountColor;

  const CityCard({
    this.imagePath,
    this.cityname,
    this.id,
    this.description,
    this.cityLength,
    this.rating,
    this.reviewsCount,
    this.starColor = Colors.amber,
    this.ratingTextColor = Colors.blue,
    this.reviewsCountColor = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate star rating based on total ratings
    double starRating = double.parse(rating!) / 5.0;
    print(cityLength);
    return Card(
      elevation: 4,
      child: Container(
        height: cityLength!.length > 1 ? 380 : 550,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[300],
                      image: DecorationImage(
                        image: NetworkImage(imagePath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cityname!,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    description!,
                    style: TextStyle(fontSize: 12.0),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Star Rating
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < starRating.floor()
                            ? Icons.star
                            : index < starRating.ceil()
                                ? Icons.star_half
                                : Icons.star_border,
                        size: 16,
                        color: starColor,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(Attraction(id: id));
                    },
                    child: Tooltip(
                      message: 'View Attractions',
                      child: Row(
                        children: [
                          Text(
                            'Attractions',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Icon(
                            Ionicons.chevron_forward_circle,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                        GlobalColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
