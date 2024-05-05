import 'dart:convert';
import 'dart:typed_data';

import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/config/webapi.dart';
import 'package:cityquest/view/widgets/User/pages/Cities.dart';
import 'package:cityquest/view/widgets/User/pages/attraction_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';

class Place extends StatefulWidget {
  final String? id;

  final String? category;
  const Place({Key? key, this.id, this.category}) : super(key: key);

  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  int? cityLength;
  final List<Map<String, dynamic>> attractions = [];
  String filter = '';
  String selectedCategory = 'All'; // Initially set to 'All'

  Future<void> getAttractions() async {
    try {
      var response = await http.get(Uri.parse(ApiCredientals.base_path +
          'CityQuestWEB/Attraction/allActivity?id=${widget.id}'));
      var data = json.decode(response.body);
      if (data.length > 0) {
        setState(() {
          attractions.addAll(List<Map<String, dynamic>>.from(data));
          cityLength = attractions.length;
        });
      } else {
        // Handle error message
      }
    } catch (e) {
      // Handle network or parsing errors
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getAttractions();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  
    List<Map<String, dynamic>> filteredAttractions =
        attractions.where((attraction) {
      return (attraction['title'].toLowerCase().contains(filter) ||
              attraction['description'].toLowerCase().contains(filter)) &&
          (widget.category == null ||
              attraction['category'] == widget.category);
    }).toList();

    cityLength = filteredAttractions.length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        title: Text(
          'Attractions',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
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
              child: filteredAttractions.isNotEmpty
                  ? ListView.builder(
                      itemCount: (filteredAttractions.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        int firstIndex = index * 2;
                        int secondIndex = index * 2 + 1;
                        return Row(
                          children: [
                            if (firstIndex < filteredAttractions.length)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildCard(
                                      filteredAttractions[firstIndex], index),
                                ),
                              ),
                            if (secondIndex < filteredAttractions.length)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildCard(
                                      filteredAttractions[secondIndex], index),
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

  Widget buildCard(Map<String, dynamic> attraction, filtered) {
    return Container(
      child: InkWell(
        onTap: () {
          Get.to(() => AttractionDetails(id: attraction['id']));
        },
        child: CityCard(
          imagePath: attraction['image'],
          id: attraction['id'],
          cityLength: cityLength,
          cityname: attraction['title'],
          description: attraction['description'],
          rating: attraction['total_ratings'] ??
              "0", // Assuming 'rating' is a key in your attraction map
          reviewsCount: attraction['total_reviews'] ??
              "0", // Assuming 'reviews_count' is a key in your attraction map
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
  final int? cityLength;
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
        height: cityLength! > 1 ? 320 : 500,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
