
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cityquest/assets/colors.dart';

class Cities extends StatefulWidget {
  const Cities({Key? key}) : super(key: key);

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  final List<Map<String, dynamic>> cities = [
    {
      'name': 'New York',
      'description':
          'New York City is the most populous city in the United States...',
      'image': 'images/newyork.jpg',
      'rating': 4.5,
      'reviews': 1000,
      'category': 'Food',
    },
    {
      'name': 'London',
      'description':
          'London is the capital and largest city of England and the United Kingdom...',
      'image': 'images/london.jpeg',
      'rating': 4.8,
      'reviews': 1200,
      'category': 'Hotels',
    },
    // Add other cities
    {
      'name': 'Paris',
      'description':
          'Paris is the capital and most populous city of France...',
      'image': 'images/paris.jpg',
      'rating': 4.7,
      'reviews': 1100,
      'category': 'Food',
    },
    {
      'name': 'Tokyo',
      'description':
          'Tokyo is the capital and most populous prefecture of Japan...',
      'image': 'images/tokyo.jpg',
      'rating': 4.9,
      'reviews': 1500,
      'category': 'Hotels',
    },
    {
      'name': 'Dubai',
      'description':
          'Dubai is the largest and most populous city in the United Arab Emirates...',
      'image': 'images/dubai.jpg',
      'rating': 4.6,
      'reviews': 900,
      'category': 'Shopping',
    },
    {
      'name': 'Sydney',
      'description':
          'Sydney is the capital city of the state of New South Wales...',
      'image': 'images/sydney.jpg',
      'rating': 4.7,
      'reviews': 1000,
      'category': 'Shopping',
    },
  ];

  TextEditingController searchController = TextEditingController();
  String filter = '';
  String selectedCategory = 'All'; 

  final List<CategoryItem> categories = [
    CategoryItem(icon: Icons.list, label: "All", isActive: true),
    CategoryItem(icon: Icons.restaurant, label: 'Food', isActive: false),
    CategoryItem(icon: Icons.hotel, label: 'Hotels', isActive: false),
    CategoryItem(icon: Icons.shopping_cart, label: 'Shopping', isActive: false),
  
  ];

  int visibleCitiesCount = 6; 

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCities = cities.where((city) {
      return city['category'] == selectedCategory || selectedCategory == 'All';
    }).where((city) {
      return city['name'].toLowerCase().contains(filter) ||
          city['description'].toLowerCase().contains(filter);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cities'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                selectedCategory = 'All'; // Set back to 'All'
                filter = ''; // Clear the filter
              });
            },
            icon: Icon(Icons.clear), // Clear filter button
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search by Cities',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
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
              'Categories',
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
                      selectedCategory = item.label; 
                    });
                  },
                  child: CategoryItem(
                    icon: item.icon,
                    label: item.label,
                    isActive: item.label == selectedCategory,
                    onTap: () {
                      setState(() {
                        selectedCategory =
                            item.label;
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
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: visibleCitiesCount,
              itemBuilder: (context, index) {
                final city = filteredCities[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 500,
                    child: Card(
                      color: city['category'] == 'Food'
                          ? GlobalColors.mainColor
                          : Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            child: Image.asset(
                              city['image'],
                              fit: BoxFit.cover,
                              height: 100,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              city['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: city['category'] == 'Food'
                                    ? Colors.white
                                    : GlobalColors.mainColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            child: Text(
                              city['description'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: city['category'] == 'Food'
                                    ? Colors.white
                                    : GlobalColors.mainColor,
                                fontSize: 10,
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
                                    color: city['category'] == 'Food'
                                        ? Colors.white
                                        : GlobalColors.mainColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          if (visibleCitiesCount < filteredCities.length)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (visibleCitiesCount + 2 < filteredCities.length) {
                    visibleCitiesCount += 2;
                  } else {
                    visibleCitiesCount = filteredCities.length;
                  }
                });
              },
              child: Text('Load More...'),
            ),
        ],
      ),
    );
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
          border: isActive
              ? null
              : Border.all(
                  color: GlobalColors.mainColor,
                ),
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
