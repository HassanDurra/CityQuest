import 'package:flutter/material.dart';

class RestaurantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
      ),
      body: Center(
        child: Text(
          'Welcome to Restaurants Page !',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
