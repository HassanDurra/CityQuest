// import 'package:flutter/material.dart';

// class ThingsToDoPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Things to Do'),
//       ),
//       body: Center(
//         child: Text(
//           'Welcome to Things to Do Page!',
//           style: TextStyle(fontSize: 24.0),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ThingsToDoCard extends StatelessWidget {
  final String imagePath;
  final String thingName;
  final String history;
  final String reviews;

  const ThingsToDoCard({
    required this.imagePath,
    required this.thingName,
    required this.history,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[300],
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              thingName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              history,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 18,
                  color: Colors.amber,
                ),
                SizedBox(width: 5),
                Text(
                  reviews,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: Colors.grey,
                ),
                SizedBox(width: 5),
                Text(
                  'Open',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
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

class ThingsToDoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Things to Do'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ThingsToDoCard(
              imagePath: 'assets/images/historical_site.jpg',
              thingName: 'Historical Sites',
              history: 'Learn about the rich history of our city.',
              reviews: '5 Reviews',
            ),
            SizedBox(height: 20.0),
            ThingsToDoCard(
              imagePath: 'assets/images/museum.jpg',
              thingName: 'Museums',
              history: 'Explore fascinating exhibits from around the world.',
              reviews: '8 Reviews',
            ),
          ],
        ),
      ),
    );
  }
}
