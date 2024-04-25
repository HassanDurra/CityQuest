import 'package:flutter/material.dart';

class Food extends StatelessWidget {
  // List of food items
  final List<Map<String, dynamic>> foods = [
    {
      'name': 'Pizza',
      'description': 'Pizza is a savory dish of Italian origin...',
      'image': 'images/pizza.jpeg',
      'rating': 4.5,
      'reviews': 800,
    },
    {
      'name': 'Burger',
      'description': 'A burger is a sandwich consisting of one or more cooked patties of ground meat...',
      'image': 'images/burger.jpg',
      'rating': 4.2,
      'reviews': 700,
    },
    {
      'name': 'Sushi',
      'description': 'Sushi is a Japanese dish of prepared vinegared rice, usually with some sugar and salt, accompanying a variety of ingredients such as seafood, often raw, and vegetables...',
      'image': 'images/sushi.jpg',
      'rating': 4.7,
      'reviews': 900,
    },
    {
       'name': 'Biryani',
      'description': 'Biryani is a mixed rice dish originating from the Indian subcontinent...',
      'image': 'images/biryani.jpg',
      'rating': 4.7,
      'reviews': 900,
    },
    {
      'name': 'Pasta',
      'description': 'Pasta is a type of food typically made from an unleavened dough of wheat flour mixed with water or eggs, and formed into sheets or other shapes, then cooked by boiling or baking...',
      'image': 'images/pasta.jpg',
      'rating': 4.8,
      'reviews': 850,
    },
    {
      'name': 'Tacos',
      'description': 'Tacos are a traditional Mexican dish consisting of a small hand-sized corn or wheat tortilla topped with a filling...',
      'image': 'images/tacos.jpg',
      'rating': 4.6,
      'reviews': 750,
    },
 
  ];


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food'),
      ),
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(8),
                leading: Image.asset(
                  foods[index]['image'], 
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(foods[index]['name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      foods[index]['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        SizedBox(width: 4),
                        Text(
                          '${foods[index]['rating']} (${foods[index]['reviews']} reviews)',
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
