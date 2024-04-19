import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _query = ''; 


  void _search() {
  


    print('Searching for: $_query');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              _query = value; 


            });
          },
          decoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Enter your search....',
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: _search,
              icon: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Search(),
  ));
}
