import 'dart:convert';
import 'package:cityquest/view/widgets/User/pages/category_page.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Welcome back, ${userData['username']}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            ///search bar
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            CarouselWithIndicators(),

            ///categories
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CategoryTile(
                          icon: Icons.directions_walk,
                          text: 'Things to Do',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CategoryTile(
                          icon: Icons.event,
                          text: 'Events',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CategoryTile(
                          icon: Icons.local_dining,
                          text: 'Food & Drinks',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CategoryTile(
                          icon: Icons.restaurant,
                          text: 'Restaurants',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CategoryTile(
                          icon: Icons.park,
                          text: 'Parks',
                        ),
                      ),
                      const SizedBox(width: 10),
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
                  const Text(
                    'Recommmended',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 16, // Increased main axis spacing
                      crossAxisSpacing: 16, // Increased cross axis spacing
                      children: [
                        GridCard(
                          title: 'One of the most under-rated countries in Asia for adventurous, independent travellers is Pakistan. ',
                          imageUrl: 'assets/images/card 1.jpg',
                        ),
                        GridCard(
                          title: 'The Amazing Pakistan - Can you guess the City ?',
                          imageUrl: 'assets/images/card 2.jpg',
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

      ///power icon
      appBar: AppBar(
        title: const Text(""),
        actions: [
          IconButton(
            icon: const Icon(Icons.schedule),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

///last 2 cards
class GridCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const GridCard({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16), // Rounded corners
        child: Card(
          elevation: 0, // No elevation for the card inside the container
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///carousel
class CarouselWithIndicators extends StatefulWidget {
  @override
  _CarouselWithIndicatorsState createState() => _CarouselWithIndicatorsState();
}

class _CarouselWithIndicatorsState extends State<CarouselWithIndicators> {
  int _current = 0;
  final List<String> images = [
    'assets/images/tokyo.jpg',
    'assets/images/newyork.jpg',
    'assets/images/london.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: const Text(
            'Popular',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        CarouselSlider(
          items: images.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.map((url) {
            int index = images.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin:
              const EdgeInsets.symmetric(vertical: 10.2, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                _current == index ? const Color(0xFF00416A) : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
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
              MaterialPageRoute(builder: (context) => ThingsToDoPage()),
            );
            break;
          case 'Events':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventsPage()),
            );
            break;
          case 'Food & Drinks':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodAndDrinksPage()),
            );
            break;
             case 'Resturants':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RestaurantsPage()),
            );
              break;
             case 'Seas':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SeasPage()),
            );
              break;
             case 'Parks':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ParksPage()),
            );


          default:
            // Add handling for other categories if needed
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
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cityquest/view/widgets/User/pages/category_page.dart';
// import 'package:cityquest/view/widgets/User/pages/events_page.dart';
// import 'package:cityquest/view/widgets/User/pages/food_drinks_page.dart';
// import 'package:cityquest/view/widgets/User/pages/parks_page.dart';
// import 'package:cityquest/view/widgets/User/pages/restaurants_page.dart';
// import 'package:cityquest/view/widgets/User/pages/seas_page.dart';
// import 'package:cityquest/view/widgets/User/pages/things_to_do_page.dart';


// class HomeView extends StatefulWidget {
//   const HomeView({Key? key}) : super(key: key);

//   @override
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
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
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 "Welcome back, ${userData['username']}",
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),


// /////search bar
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: TextField(
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.search),
//                   hintText: 'Search...',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ),
//             ),



//             const SizedBox(height: 20),
//             CarouselWithIndicators(),


// /////categories
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Categories',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),

//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: CategoryTile(
//                           icon: Icons.directions_walk,
//                           text: 'Things to Do',
//                         ),
//                       ),


//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: CategoryTile(
//                           icon: Icons.event,
//                           text: 'Events',
//                         ),
//                       ),



//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: CategoryTile(
//                           icon: Icons.local_dining,
//                           text: 'Food & Drinks',
//                         ),
//                       ),
//                     ],
//                   ),


//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: CategoryTile(
//                           icon: Icons.restaurant,
//                           text: 'Restaurants',
//                         ),
//                       ),


//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: CategoryTile(
//                           icon: Icons.park,
//                           text: 'Parks',
//                         ),
//                       ),



//                       const SizedBox(width: 10),
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

//  //// Grid Layout Cards
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Recommmended',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: GridView.count(
//                       crossAxisCount: 2,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       mainAxisSpacing: 16, // Increased main axis spacing
//                       crossAxisSpacing: 16, // Increased cross axis spacing
//                       children: [
//                         GridCard(
//                           title: 'One of the most under-rated countries in Asia for adventurous, independent travellers is Pakistan. ',
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


// ////power icon
//       appBar: AppBar(
//         title: const Text(""),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.schedule),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.power_settings_new),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
// /////last 2 cards 

// class GridCard extends StatelessWidget {
//   final String title;
//   final String imageUrl;

//   const GridCard({required this.title, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16), // Rounded corners
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 4,
//             offset: const Offset(0, 2), // Shadow position
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16), // Rounded corners
//         child: Card(
//           elevation: 0, // No elevation for the card inside the container
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
// /////carousel 
// class CarouselWithIndicators extends StatefulWidget {
//   @override
//   _CarouselWithIndicatorsState createState() => _CarouselWithIndicatorsState();
// }

// class _CarouselWithIndicatorsState extends State<CarouselWithIndicators> {
//   int _current = 0;
//   final List<String> images = [
//     'assets/images/tokyo.jpg',
//     'assets/images/newyork.jpg',
//     'assets/images/london.jpeg',
//   ];


//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: const Text(
//             'Popular',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         CarouselSlider(
//           items: images.map((image) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                   decoration: BoxDecoration(
//                     color: Colors.grey,
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       image: NetworkImage(image),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               },
//             );
//           }).toList(),
//           options: CarouselOptions(
//             autoPlay: true,
//             enlargeCenterPage: true,
//             aspectRatio: 16 / 9,
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _current = index;
//               });
//             },
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: images.map((url) {
//             int index = images.indexOf(url);
//             return Container(
//               width: 8.0,
//               height: 8.0,
//               margin:
//                   const EdgeInsets.symmetric(vertical: 10.2, horizontal: 2.0),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color:
//                     _current == index ? const Color(0xFF00416A) : Colors.grey,
//               ),
//             );
//           }).toList(),
//         ),
//       ],
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
//               MaterialPageRoute(builder: (context) => ThingsToDoPage()),
//             );
//             break;
//           case 'Events':
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => EventsPage()),
//             );
//             break;
//           case 'Food & Drinks':
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => FoodAndDrinksPage()),
//             );
//             break;
//           case 'Restaurants':
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => RestaurantsPage()),
//             );
//             break;
//           case 'Parks':
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ParksPage()),
//             );
//             break;
//           case 'Seas':
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => SeasPage()),
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


