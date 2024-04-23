
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _query = '';


  void _search()
   {
   print('Searching for: $_query');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _query = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    border: InputBorder.none,
                    hintText: 'Enter your search...',
                  ),
                ),
              ),
              IconButton(
                onPressed: _search,
                icon: Icon(Icons.search),
              ),
            ],
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
