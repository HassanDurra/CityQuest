
import 'package:flutter/material.dart';

class Listing extends StatelessWidget {
  // List of places
  final List<Map<String, dynamic>> places = [
    {
      'name': 'Eiffel Tower',
      'description':
          'The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars in Paris, France...',
      'image': 'assets/images/eiffeltower.jpg',
      'rating': 4.8,
      'reviews': 1200,
    },
    {
      'name': 'Statue of Liberty',
      'description':
          'The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor...',
      'image': 'assets/images/statueofliberty.png',
      'rating': 4.7,
      'reviews': 1500,
    },
    {
      'name': 'Sydney Opera House',
      'description':
          'The Sydney Opera House is a multi-venue performing arts center in Sydney, New South Wales, Australia...',
      'image': 'assets/images/SydneyOperaHouse.jpg',
      'rating': 4.9,
      'reviews': 1300,
    },
    {
      'name': 'Taj Mahal',
      'description':
          'The Taj Mahal is an ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra...',
      'image': 'assets/images/Taj Mahal.jpg',
      'rating': 4.9,
      'reviews': 1800,
    },
    {
      'name': 'Great Wall of China',
      'description':
          'The Great Wall of China is the collective name of a series of fortification systems generally built across the historical northern borders of China to protect and consolidate territories of Chinese states and empires against various nomadic groups of the steppe and their polities...',
      'image': 'assets/images/greatwallofchina.webp',
      'rating': 4.8,
      'reviews': 2000,
    },
    {
      'name': 'Machu Picchu',
      'description':
          'Machu Picchu is a 15th-century Inca citadel located in the Eastern Cordillera of southern Peru on a mountain ridge 2,430 meters (7,970 ft) above sea level...',
      'image': 'assets/images/Machu_Picchu.jpg',
      'rating': 4.9,
      'reviews': 1600,
    },
   
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places'),
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(8),
                leading: Image.asset(
                  places[index]['image'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(places[index]['name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      places[index]['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        SizedBox(width: 4),
                        Text(
                          '${places[index]['rating']} (${places[index]['reviews']} reviews)',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
            




                },
              ),
            ),
          );
        },
      ),
    );
  }
}
