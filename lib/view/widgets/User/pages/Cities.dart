import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

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
                                  child: buildCard(filteredCities[firstIndex]),
                                ),
                              ),
                            if (secondIndex < filteredCities.length)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildCard(filteredCities[secondIndex]),
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

  Widget buildCard(Map<String, dynamic> city) {
    return Container(
      child: InkWell(
        onTap: () {
          Get.to(() => CityDetails(id: city['id']));
        },
        child: FoodCard(
          imagePath: city['image'],
          foodName: city['name'],
          description: city['short_description'],
          rating: city['id']
              .toString(), // Assuming 'rating' is a key in your city map
          reviewsCount: city['country']
              .toString(), // Assuming 'reviews_count' is a key in your city map
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

class FoodCard extends StatelessWidget {
  final String? imagePath;
  final String? foodName;
  final String? description;
  final String? rating;
  final String? reviewsCount;
  final Color? starColor;
  final Color? ratingTextColor;
  final Color? reviewsCountColor;

  const FoodCard({
    this.imagePath,
    this.foodName,
    this.description,
    this.rating,
    this.reviewsCount,
    this.starColor = Colors.amber,
    this.ratingTextColor = Colors.blue,
    this.reviewsCountColor = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
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
              foodName!,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: starColor,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '$rating',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: ratingTextColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  '$reviewsCount reviews',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: reviewsCountColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
