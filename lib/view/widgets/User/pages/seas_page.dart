import 'package:flutter/material.dart';

class SeasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sea'),
      ),
      body: Center(
        child: Text(
          'Welcome to sea Page!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
