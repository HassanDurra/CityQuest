import 'dart:convert';
import 'package:cityquest/view/widgets/User/pages/attraction.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Map<String, dynamic>> places = [
    {
      'name': 'Tokyo',
      'image': 'images/tokyo.jpg',
      'description': 'Capital of Japan',
      'rating': 4.54,
      'reviews': 120,
    },
    {
      'name': 'New York',
      'image': 'images/newyork.jpg',
      'description': 'City in New York State',
      'rating': 4.22,
      'reviews': 90,
    },
    {
      'name': 'London',
      'image': 'images/london.jpeg',
      'description': 'Capital of England',
      'rating': 4.33,
      'reviews': 80,
    },
  ];

  Map<String, dynamic> userData = {};

  Future<void> getData() async {
    var pref = await SharedPreferences.getInstance();
    String? user = pref.getString('user');

    if (user != null) {
      setState(() {
        userData = jsonDecode(user);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.alarm),
            onPressed: () {
           
            },
          ),
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
         
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Welcome back, ${userData['username']}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            ///search bar
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2), 
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            CarouselWithCards(places: places),

            ///categories
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CategoryTile(
                          icon: Icons.directions_walk,
                          text: 'Things to Do',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CategoryTile(
                          icon: Icons.event,
                          text: 'Events',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CategoryTile(
                          icon: Icons.local_dining,
                          text: 'Food & Drinks',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CategoryTile(
                          icon: Icons.restaurant,
                          text: 'Restaurants',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CategoryTile(
                          icon: Icons.park,
                          text: 'Parks',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CategoryTile(
                          icon: Icons.beach_access,
                          text: 'Seas',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Grid Layout Cards
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommended',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: [
                        GridCard(
                          title: 'Can you guess the City ?',
                          imageUrl: 'images/card1.jpg',
                        ),
                        GridCard(
                          title: 'The Amazing Pakistan',
                          imageUrl: 'images/card2.jpg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselWithCards extends StatefulWidget {
  final List<Map<String, dynamic>> places;

  CarouselWithCards({Key? key, required this.places}) : super(key: key);

  @override
  _CarouselWithCardsState createState() => _CarouselWithCardsState();
}

class _CarouselWithCardsState extends State<CarouselWithCards> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Popular',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        CarouselSlider(
          items: widget.places.map((place) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[300],
                              image: DecorationImage(
                                image: NetworkImage(place['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            place['name'],
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            place['description'],
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '${place['rating']} (${place['reviews']} reviews)',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 400,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.95,
            enableInfiniteScroll: false,
            pauseAutoPlayOnTouch: true,
            autoPlayAnimationDuration: Duration(seconds: 1),
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.places.map((place) {
            int index = widget.places.indexOf(place);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? Colors.blueAccent : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class GridCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const GridCard({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.0,
              width: double.infinity,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '4.5 (120 reviews)', // Replace with actual rating and reviews
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const CategoryTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (text) {
          case 'Things to Do':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Attraction()),
            );
            break;
          case 'Events':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Attraction()),
            );
            break;
          case 'Food & Drinks':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Attraction()),
            );
            break;
          case 'Restaurants':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Attraction()),
            );
            break;
          case 'Seas':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Attraction()),
            );
            break;
          case 'Parks':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Attraction()),
            );
            break;
          default:
            break;
        }
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 36,
                color: const Color(0xFF00416A),
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







































































// import 'dart:convert';
// import 'package:cityquest/view/widgets/User/pages/attraction.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({Key? key}) : super(key: key);

//   @override
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   List<Map<String, dynamic>> places = [
//     {
//       'name': 'Tokyo',
//       'image': 'images/tokyo.jpg',
//       'description': 'Capital of Japan',
//       'rating': 4.54,
//       'reviews': 120,
//     },
//     {
//       'name': 'New York',
//       'image': 'images/newyork.jpg',
//       'description': 'City in New York State',
//       'rating': 4.22,
//       'reviews': 90,
//     },
//     {
//       'name': 'London',
//       'image': 'images/london.jpeg',
//       'description': 'Capital of England',
//       'rating': 4.33,
//       'reviews': 80,
//     },
//   ];

//   Map<String, dynamic> userData = {};

//   Future<void> getData() async {
//     var pref = await SharedPreferences.getInstance();
//     String? user = pref.getString('user');

//     if (user != null) {
//       setState(() {
//         userData = jsonDecode(user);
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(Icons.alarm),
//             onPressed: () {
           
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.power_settings_new),
//             onPressed: () {
         
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 "Welcome back, ${userData['username']}",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),

//             ///search bar
//             SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 4,
//                       offset: Offset(0, 2), 
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.search),
//                     hintText: 'Search...',
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(height: 20),
//             CarouselWithCards(places: places),

//             ///categories
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Categories',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: CategoryTile(
//                           icon: Icons.directions_walk,
//                           text: 'Things to Do',
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: CategoryTile(
//                           icon: Icons.event,
//                           text: 'Events',
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: CategoryTile(
//                           icon: Icons.local_dining,
//                           text: 'Food & Drinks',
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: CategoryTile(
//                           icon: Icons.restaurant,
//                           text: 'Restaurants',
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: CategoryTile(
//                           icon: Icons.park,
//                           text: 'Parks',
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: CategoryTile(
//                           icon: Icons.beach_access,
//                           text: 'Seas',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             /// Grid Layout Cards
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Recommended',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: GridView.count(
//                       crossAxisCount: 2,
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       mainAxisSpacing: 16,
//                       crossAxisSpacing: 16,
//                       children: [
//                         GridCard(
//                           title: 'One of the most under-rated countries in Asia for adventurous, independent travellers is Pakistan.',
//                           imageUrl: 'assets/images/card 1.jpg',
//                         ),
//                         GridCard(
//                           title: 'The Amazing Pakistan - Can you guess the City ?',
//                           imageUrl: 'assets/images/card 2.jpg',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CarouselWithCards extends StatefulWidget {
//   final List<Map<String, dynamic>> places;

//   CarouselWithCards({Key? key, required this.places}) : super(key: key);

//   @override
//   _CarouselWithCardsState createState() => _CarouselWithCardsState();
// }

// class _CarouselWithCardsState extends State<CarouselWithCards> {
//   int _current = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             'Popular',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         SizedBox(height: 10),
//         CarouselSlider(
//           items: widget.places.map((place) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     elevation: 4,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             height: 200.0,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.0),
//                               color: Colors.grey[300],
//                               image: DecorationImage(
//                                 image: NetworkImage(place['image']),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20.0),
//                           Text(
//                             place['name'],
//                             style: TextStyle(
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 10.0),
//                           Text(
//                             place['description'],
//                             style: TextStyle(fontSize: 16.0),
//                           ),
//                           SizedBox(height: 10.0),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.star,
//                                 size: 18,
//                                 color: Colors.amber,
//                               ),
//                               SizedBox(width: 5),
//                               Text(
//                                 '${place['rating']} (${place['reviews']} reviews)',
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }).toList(),
//           options: CarouselOptions(
//             height: 400,
//             autoPlay: true,
//             enlargeCenterPage: true,
//             aspectRatio: 16 / 9,
//             viewportFraction: 0.95,
//             enableInfiniteScroll: false,
//             pauseAutoPlayOnTouch: true,
//             autoPlayAnimationDuration: Duration(seconds: 1),
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _current = index;
//               });
//             },
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: widget.places.map((place) {
//             int index = widget.places.indexOf(place);
//             return Container(
//               width: 8.0,
//               height: 8.0,
//               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: _current == index ? Colors.blueAccent : Colors.grey,
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }

// class GridCard extends StatelessWidget {
//   final String title;
//   final String imageUrl;

//   const GridCard({required this.title, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: Card(
//           elevation: 0,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Image.network(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     title,
//                     style: const TextStyle(fontSize: 14),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CategoryTile extends StatelessWidget {
//   final IconData icon;
//   final String text;

//   const CategoryTile({required this.icon, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         switch (text) {
//           case 'Things to Do':
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Attraction()),
//             );
//             break;
//           case 'Events':
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Attraction()),
//             );
//             break;
//           case 'Food & Drinks':
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Attraction()),
//             );
//             break;
//           case 'Restaurants':
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Attraction()),
//             );
//             break;
//           case 'Seas':
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Attraction()),
//             );
//             break;
//           case 'Parks':
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Attraction()),
//             );
//             break;
//           default:
//             break;
//         }
//       },
//       child: Card(
//         elevation: 4,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: 36,
//                 color: const Color(0xFF00416A),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 text,
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

