// import 'package:flutter/material.dart';

// class Cities extends StatefulWidget {
//   const Cities({super.key});

//   @override
//   State<Cities> createState() => _CitiesState();
// }

// class _CitiesState extends State<Cities> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(alignment: Alignment.center, child: Text("Cities")),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Cities extends StatefulWidget {
  const Cities({Key? key}) : super(key: key);

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  // List of cities
  final List<Map<String, dynamic>> cities = [
    {
      'name': 'New York',
      'description': 'New York City is the most populous city in the United States...',
      'image': 'assets/images/newyork.jpg',
      'rating': 4.5,
      'reviews': 1000,
    },
    {
      'name': 'London',
      'description': 'London is the capital and largest city of England and the United Kingdom...',
      'image': 'assets/images/london.jpeg',
      'rating': 4.8,
      'reviews': 1200,
    },
    {
      'name': 'Paris',
      'description': 'Paris is the capital and most populous city of France...',
      'image': 'assets/images/paris.jpg',
      'rating': 4.7,
      'reviews': 1500,
    },
    {
      'name': 'Tokyo',
      'description': 'Tokyo is the capital city of Japan and one of its 47 prefectures...',
      'image': 'assets/images/tokyo.jpg',
      'rating': 4.6,
      'reviews': 1100,
    },
    {
      'name': 'Los Angeles',
      'description': 'Los Angeles is the largest city in California and the second-largest city in the United States...',
      'image': 'assets/images/los_angeles.jpg',
      'rating': 4.4,
      'reviews': 900,
    },
    {
      'name': 'Sydney',
      'description': 'Sydney is the capital city of the state of New South Wales, and the most populous city in Australia...',
      'image': 'assets/images/sydney.jpg',
      'rating': 4.9,
      'reviews': 1300,
    },
    {
      'name': 'Dubai',
      'description': 'Dubai is the largest and most populous city in the United Arab Emirates...',
      'image': 'assets/images/dubai.jpg',
      'rating': 4.7,
      'reviews': 1600,
    },
    {
      'name': 'Rome',
      'description': 'Rome is the capital city and a special comune of Italy...',
      'image': 'assets/images/rome.webp',
      'rating': 4.5,
      'reviews': 950,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cities'),
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
            child: Card(
              child: ListTile(
                leading: Image.asset(
                  cities[index]['image'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                title: Text(cities[index]['name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cities[index]['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Text('${cities[index]['rating']} (${cities[index]['reviews']} reviews)'),
                      ],
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
