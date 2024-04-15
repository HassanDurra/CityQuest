import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Map<String, dynamic> userData = {};

  Future<void> getData() async {
    var pref = await SharedPreferences.getInstance();
    String? user = pref.getString('user');

    if (user != null) {
      setState(() {
        userData = jsonDecode(user);
      });
    }
  }


  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Welcome back, ${userData['username']}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

/////search bar
  const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

////categories
            const SizedBox(height: 20),
            CarouselWithIndicators(),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: const CategoryTile(
                          icon: Icons.directions_walk,
                          text: 'Things to Do',
                        ),
                      ),

                      const SizedBox(width: 10),
                      Expanded(
                        child: const CategoryTile(
                          icon: Icons.event,
                          text: 'Events',
                        ),
                      ),

                      const SizedBox(width: 10),
                      Expanded(
                        child: const CategoryTile(
                          icon: Icons.local_dining,
                          text: 'Food & Drinks',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: const CategoryTile(
                          icon: Icons.restaurant,
                          text: 'Restaurants',
                        ),
                      ),

                      const SizedBox(width: 10),
                      Expanded(
                        child: const CategoryTile(
                          icon: Icons.park,
                          text: 'Parks',
                        ),
                      ),

                      const SizedBox(width: 10),
                      Expanded(
                        child: const CategoryTile(
                          icon: Icons.beach_access,
                          text: 'Seas',
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: const Text(""),
        actions: [
          IconButton(
            icon: const Icon(Icons.schedule),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

/////carousel
class CarouselWithIndicators extends StatefulWidget {
  @override
  _CarouselWithIndicatorsState createState() => _CarouselWithIndicatorsState();
}

class _CarouselWithIndicatorsState extends State<CarouselWithIndicators> {
  int _current = 0;
  final List<String> images = [
    'assets/images/tokyo.jpg',
    'assets/images/newyork.jpg',
    'assets/images/london.jpeg',
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: const Text(
            'Popular',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        CarouselSlider(
          items: images.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.map((url) {
            int index = images.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(vertical: 10.2, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? const Color(0xFF00416A) : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}



class CategoryTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const CategoryTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36,
              color: const Color(0xFF00416A),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

