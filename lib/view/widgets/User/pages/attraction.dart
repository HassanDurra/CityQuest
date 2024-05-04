import 'dart:ui';

import 'package:cityquest/view/widgets/User/pages/details.dart';
import 'package:cityquest/webapi/cityquestweb.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cityquest/assets/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';

class Attraction extends StatefulWidget {
  final String? id;
  const Attraction({Key? key, this.id}) : super(key: key);

  @override
  State<Attraction> createState() => _AttractionState();
}

class _AttractionState extends State<Attraction> {
  final List<Map<String, dynamic>> Attraction = [
    {
      'name': 'Mazar e Quaid',
      'description':
          'Mazar-e-Quaid (Urdu: مزارِ قائد), also known as Jinnah Mausoleum or the National Mausoleum, is the final resting place of Muhammad Ali Jinnah, the founder of Pakistan. Designed in a 1960s',
      'image': 'images/quaid.jpg',
      'rating': 4.5,
      'reviews': 1000,
      'category': 'All',
    },

    // Add other Attraction
  ];
  getAttractions() async {
    var URL = Uri.parse(
        apiCredientals.base_url + "CityQuestWeb/Attraction/getActivity?id=${widget.id}");
    var response  = await http.get(URL);
    
  }

  TextEditingController searchController = TextEditingController();
  String filter = '';
  String selectedCategory = 'All'; // Initially set to 'All'

  final List<CategoryItem> categories = [
    CategoryItem(icon: Icons.list, label: "All", isActive: true),
    CategoryItem(icon: Icons.restaurant, label: 'Food', isActive: false),
    CategoryItem(icon: Icons.hotel, label: 'Hotels', isActive: false),
    CategoryItem(icon: Icons.shopping_cart, label: 'Shopping', isActive: false),
    CategoryItem(icon: Icons.shopping_cart, label: 'Shopping', isActive: false),
    CategoryItem(icon: Icons.shopping_cart, label: 'Shopping', isActive: false),
    CategoryItem(icon: Icons.shopping_cart, label: 'Shopping', isActive: false),
    // Add more categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredAttraction = Attraction.where((city) {
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
            'Categories',
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
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search By Name',
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
              SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Popular Categories',
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 60.0,
                  aspectRatio: 20 / 10,
                  viewportFraction: 0.4,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: categories.map((item) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategory =
                              item.label; // Update selected category
                        });
                      },
                      child: CategoryItem(
                        icon: item.icon,
                        label: item.label,
                        isActive: item.label == selectedCategory,
                        onTap: () {
                          setState(() {
                            selectedCategory =
                                item.label; // Update selected category
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: filteredAttraction.isNotEmpty
                    ? ListView.builder(
                        itemCount: (filteredAttraction.length / 2).ceil(),
                        itemBuilder: (context, index) {
                          int firstIndex = index * 2;
                          int secondIndex = index * 2 + 1;
                          return Row(
                            children: [
                              if (firstIndex < filteredAttraction.length)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: buildCard(
                                        filteredAttraction[firstIndex]),
                                  ),
                                ),
                              if (secondIndex < filteredAttraction.length)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: buildCard(
                                        filteredAttraction[secondIndex]),
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
        Get.offAll(() => Details());
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

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const CategoryItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isActive,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isActive ? GlobalColors.mainColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isActive ? null : Border.all(color: GlobalColors.mainColor),
          boxShadow: [
            if (isActive)
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : GlobalColors.mainColor,
            ),
            SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : GlobalColors.mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
