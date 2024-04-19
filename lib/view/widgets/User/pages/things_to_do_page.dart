import 'package:flutter/material.dart';

class ThingsToDoCard extends StatelessWidget {
  final String imagePath;
  final String thingName;
  final String history;
  final int reviewsCount;

  const ThingsToDoCard({
    required this.imagePath,
    required this.thingName,
    required this.history,
    required this.reviewsCount,
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
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.amber,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '$reviewsCount Reviews',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(width: 10), // Add space here
                Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: Colors.amber, // Change color to yellow
                ),
                SizedBox(width: 5),
                Text(
                  'Open',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
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
              imagePath: 'assets/images/historica.jpg',
              thingName: 'Historical Sites',
              history: 'Learn about the rich history of our city.',
              reviewsCount: 5,
            ),
            SizedBox(height: 20.0),
            ThingsToDoCard(
              imagePath: 'assets/images/museum.jpg',
              thingName: 'Museums',
              history: 'Explore fascinating exhibits from around the world.',
              reviewsCount: 8,
            ),
            SizedBox(height: 20.0),
            ThingsToDoCard(
              imagePath: 'assets/images/shopping.webp',
              thingName: 'Shopping Centers',
              history: 'Shop till you drop at our city\'s diverse shopping centers.',
              reviewsCount: 10,
            ),
            SizedBox(height: 20.0),
            ThingsToDoCard(
              imagePath: 'assets/images/sports.jpg',
              thingName: 'Sports Facilities',
              history: 'Stay active and enjoy various sports activities at our state-of-the-art facilities.',
              reviewsCount: 6,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ThingsToDoPage(),
  ));
}