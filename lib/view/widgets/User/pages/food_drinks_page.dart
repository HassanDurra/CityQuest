import 'package:flutter/material.dart';

class FoodAndDrinksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food And rinks'),
      ),
      body: Center(
        child: Text(
          'Welcome to Food And rinks Page !',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}