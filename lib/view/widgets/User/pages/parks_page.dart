import 'package:flutter/material.dart';

class ParksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parks'),
      ),
      body: Center(
        child: Text(
          'Welcome to Parks Page !',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
