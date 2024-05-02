
// import 'package:flutter/material.dart';

// class FoodCard extends StatelessWidget {
//   final String imagePath;
//   final String foodName;
//   final String description;
//   final double rating;
//   final int reviewsCount;

//   const FoodCard({
//     required this.imagePath,
//     required this.foodName,
//     required this.description,
//     required this.rating,
//     required this.reviewsCount,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 150.0,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: Colors.grey[300],
//                 image: DecorationImage(
//                   image: AssetImage(imagePath),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: 2.0),
//             Text(
//               foodName,
//               style: TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             SizedBox(height: 2.0),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 2.0),
//               child: Text(
//                 description,
//                 style: TextStyle(fontSize: 12.0),
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             SizedBox(height: 2.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.star,
//                       size: 16,
//                       color: Colors.amber,
//                     ),
//                     SizedBox(width: 2),
//                     Text(
//                       '5.0', // Star always set to 5
//                       style: TextStyle(
//                         fontSize: 12.0,
//                         color: Colors.blue, // Set text color to blue
//                       ),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   '$reviewsCount reviews',
//                   style: TextStyle(
//                     fontSize: 12.0,
//                     color: Colors.amber, // Set text color to amber
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Food extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Food'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 4.0,
//             mainAxisSpacing: 4.0,
//           ),
//           itemCount: 8, // Change this to the desired number of cards
//           itemBuilder: (BuildContext context, int index) {
//             return FoodCard(
//               imagePath: 'images/pizza.jpeg',
//               foodName: 'Pizza',
//               description: 'Pizza is a savory dish of Italian origin...',
//               rating: 5.0, // Always set to 5
//               reviewsCount: 800,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Food(),
//   ));
// }


import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String imagePath;
  final String foodName;
  final String description;
  final double rating;
  final int reviewsCount;
  final Color starColor;
  final Color ratingTextColor;
  final Color reviewsCountColor;

  const FoodCard({
    required this.imagePath,
    required this.foodName,
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
              foodName,
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

class Food extends StatefulWidget {
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food'),
      ),
      backgroundColor: Colors.white, // Setting background color to white
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
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
                itemCount: 8, // Change this to the desired number of cards
                itemBuilder: (BuildContext context, int index) {
                  return FoodCard(
                    imagePath: 'images/pizza.jpeg',
                    foodName: 'Pizza',
                    description: 'Pizza is a savory dish of Italian origin...',
                    rating: 5.0, // Always set to 5
                    reviewsCount: 800,
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
    home: Food(),
  ));
}

