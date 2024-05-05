import 'dart:convert';
import 'dart:typed_data';

import 'package:cityquest/config/webapi.dart';
import 'package:cityquest/view/widgets/User/pages/attraction_details.dart';
import 'package:flutter/material.dart';
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
  final List<Map<String, dynamic>> attractions = [];
  String filter = '';
  String selectedCategory = 'All'; // Initially set to 'All'

  Future<void> getAttractions() async {
    try {
      var response = await http.get(Uri.parse(ApiCredientals.base_path +
          'CityQuestWEB/Attraction/getActivity?id=${widget.id}'));
      var data = json.decode(response.body);
      if (data.length > 0) {
        setState(() {
          attractions.addAll(List<Map<String, dynamic>>.from(data));
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
      return attraction['title'].toLowerCase().contains(filter) ||
          attraction['description'].toLowerCase().contains(filter);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        title: Text(
          'Attractions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Text('Filter'),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {
              setState(() {
                selectedCategory = 'All'; // Set back to 'All'
                filter = ''; // Clear the filter
              });
            },
            icon: Icon(
              Ionicons.filter_outline,
              color: Colors.black,
            ), // Clear filter button
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
                                      filteredAttractions[firstIndex]),
                                ),
                              ),
                            if (secondIndex < filteredAttractions.length)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildCard(
                                      filteredAttractions[secondIndex]),
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

  Widget buildCard(Map<String, dynamic> attraction) {
    return Container(
      child: InkWell(
        onTap: () {
          // Navigate to attraction details page
          Get.to(() => AttractionDetails(
                id: attraction['id'],
              ));
        },
        child: AttractionCard(
          imagePath: attraction['image'],
          attractionName: attraction['title'],
          description: attraction['description'],
          rating: attraction['ratings'], // Assuming 'no_views' is the rating
          reviewsCount: attraction['ratings'], // Assuming 'location' is the reviews count
        ),
      ),
    );
  }
}

class AttractionCard extends StatelessWidget {
  final String? imagePath;
  final String? attractionName;
  final String? description;
  final String? rating;
  final String? reviewsCount;

  const AttractionCard({
    this.imagePath,
    this.attractionName,
    this.description,
    this.rating,
    this.reviewsCount,
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
              attractionName!,
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
                      color: Colors.amber,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '$rating',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Text(
                  '$reviewsCount reviews',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.amber,
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
