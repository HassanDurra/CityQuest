

// class FoodAndDrinksPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Food And rinks'),
//       ),
//       body: Center(
//         child: Text(
//           'Welcome to Food And rinks Page !',
//           style: TextStyle(fontSize: 24.0),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(FoodAndDrinksPage());
}



class FoodAndDrinksPage extends StatefulWidget {
  @override
  _FoodAndDrinkScreenState createState() => _FoodAndDrinkScreenState();
}

class _FoodAndDrinkScreenState extends State<FoodAndDrinksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food and Drink'),
      ),
      body: ListView(
        children: [
          buildSection(
            title: 'Recommended Restaurants',
            items: [
              'Indian Restaurant',
              'Italian Restaurant',
              'Chinese Restaurant',
              'Thai Restaurant',
            ],
          ),
          buildSection(
            title: 'Popular Bars',
            items: [
              'Sports Bar',
              'Pub',
              'Cocktail Bar',
              'Wine Bar',
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSection({required String title, required List<String> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: items
              .map((item) => ListTile(
                    title: Text(item),
                    onTap: () {
                      // Navigate to the restaurant or bar screen
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }
}