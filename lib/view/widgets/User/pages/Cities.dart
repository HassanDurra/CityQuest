import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cityquest/view/widgets/User/pages/attraction.dart';

import 'package:cityquest/assets/colors.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class Cities extends StatefulWidget {
  const Cities({Key? key}) : super(key: key);

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  final List<Map<String, dynamic>> cities = [
    {
      'name': 'Karachi',
      'description':
          'Karachi (/ k ə ˈ r ɑː tʃ i /; Urdu: کراچی; Sindhi: ڪراچي ‎; IPA: [kəˈraːtʃi] ⓘ) is the capital city of the Pakistani province of Sindh. It is the largest city in Pakistan and the 12th largest in the world, with ',
      'image': 'images/karachi.jpg',
      'rating': 4.5,
      'reviews': 1000,
      'category': 'Food',
    },
    {
      'name': 'New York',
      'description':
          'New York City is the most populous city in the United States...',
      'image': 'images/newyork.jpg',
      'rating': 4.5,
      'reviews': 1000,
      'category': 'Food',
    },
    // Add other cities
  ];

  TextEditingController searchController = TextEditingController();
  String filter = '';
  String selectedCategory = 'All'; // Initially set to 'All'

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCities = cities.where((city) {
      return city['category'] == selectedCategory || selectedCategory == 'All';
    }).where((city) {
      return city['name'].toLowerCase().contains(filter) ||
          city['description'].toLowerCase().contains(filter);
    }).toList();

    return Container(
      child: Scaffold(
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
                                    child:
                                        buildCard(filteredCities[firstIndex]),
                                  ),
                                ),
                              if (secondIndex < filteredCities.length)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        buildCard(filteredCities[secondIndex]),
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
                            Image.asset(
                              'images/noresult.jpg',
                              height: 150,
                            ),
                            SizedBox(height: 20),
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
      ),
    );
  }

  Widget buildCard(Map<String, dynamic> city) {
    return Container(
        child: InkWell(
      onTap: () {
        Get.off(() => Attraction());
      },
      child: Card(
        elevation: 3,
        color: GlobalColors.mainColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              city['image'],
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                city['name'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                city['description'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  SizedBox(width: 5),
                  Text(
                    '${city['rating']} (${city['reviews']} reviews)',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Cities(),
  ));
}
