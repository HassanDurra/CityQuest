



// import 'package:flutter/material.dart';

// class PlaceCard extends StatelessWidget {
//   final String imagePath;
//   final String placeName;
//   final String description;
//   final double rating;
//   final int reviewsCount;

//   const PlaceCard({
//     required this.imagePath,
//     required this.placeName,
//     required this.description,
//     required this.rating,
//     required this.reviewsCount,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 200.0,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: Colors.grey[300],
//                 image: DecorationImage(
//                   image: AssetImage(imagePath),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               placeName,
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               description,
//               style: TextStyle(fontSize: 16.0),
//             ),
//             SizedBox(height: 10.0),
//             Row(
//               children: [
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.star,
//                       size: 18,
//                       color: Colors.amber,
//                     ),
//                     SizedBox(width: 5),
//                     Text(
//                       '$rating (${reviewsCount} reviews)',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Listing extends StatelessWidget {
//   // List of places
//   final List<Map<String, dynamic>> places = [
//     {
//       'name': 'Eiffel Tower',
//       'description':
//           'The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars in Paris, France...',
//       'image': 'images/eiffeltower.jpg',
//       'rating': 4.8,
//       'reviews': 1200,
//     },
//     {
//       'name': 'Statue of Liberty',
//       'description':
//           'The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor...',
//       'image': 'images/statueofliberty.png',
//       'rating': 4.7,
//       'reviews': 1500,
//     },
//     {
//       'name': 'Sydney Opera House',
//       'description':
//           'The Sydney Opera House is a multi-venue performing arts center in Sydney, New South Wales, Australia...',
//       'image': 'images/SydneyOperaHouse.jpg',
//       'rating': 4.9,
//       'reviews': 1300,
//     },
//     {
//       'name': 'Taj Mahal',
//       'description':
//           'The Taj Mahal is an ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra...',
//       'image': 'images/TajMahal.jpg',
//       'rating': 4.9,
//       'reviews': 1800,
//     },
//     {
//       'name': 'Great Wall of China',
//       'description':
//           'The Great Wall of China is the collective name of a series of fortification systems generally built across the historical northern borders of China to protect and consolidate territories of Chinese states and empires against various nomadic groups of the steppe and their polities...',
//       'image': 'images/greatwallofchina.webp',
//       'rating': 4.8,
//       'reviews': 2000,
//     },
//     {
//       'name': 'Machu Picchu',
//       'description':
//           'Machu Picchu is a 15th-century Inca citadel located in the Eastern Cordillera of southern Peru on a mountain ridge 2,430 meters (7,970 ft) above sea level...',
//       'image': 'images/MachuPicchu.jpg',
//       'rating': 4.9,
//       'reviews': 1600,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Places'),
//       ),
//       body: ListView.builder(
//         itemCount: places.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: PlaceCard(
//               imagePath: places[index]['image'],
//               placeName: places[index]['name'],
//               description: places[index]['description'],
//               rating: places[index]['rating'],
//               reviewsCount: places[index]['reviews'],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Listing(),
//   ));
// }

import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String imagePath;
  final String placeName;
  final String description;
  final double rating;
  final int reviewsCount;
  final Color starColor;
  final Color ratingTextColor;
  final Color reviewsCountColor;

  const PlaceCard({
    required this.imagePath,
    required this.placeName,
    required this.description,
    required this.rating,
    required this.reviewsCount,
    this.starColor = Colors.amber,
    this.ratingTextColor = Colors.blue,
    this.reviewsCountColor = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[300],
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              placeName,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 12.0),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 2.0),
            Row(
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
          ],
        ),
      ),
    );
  }
}

class Listing extends StatefulWidget {
  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                // Implement your search functionality here
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return PlaceCard(
                    imagePath: 'images/eiffeltower.jpg',
                    placeName: 'Eiffel Tower',
                    description: 'It was the world\'s tallest building',
                    rating: 4.5, // Example rating
                    reviewsCount: 200,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Listing(),
  ));
}
