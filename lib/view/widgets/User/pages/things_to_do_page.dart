import 'package:flutter/material.dart';

class ThingsToDoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Things to Do'),
      ),
      body: Center(
        child: Text(
          'Welcome to Things to Do Page!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

