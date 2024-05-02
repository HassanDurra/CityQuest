




import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'custom_carousel_indicator.dart'; // Import the custom carousel indicator 

class Details extends StatefulWidget {
  const Details({Key? key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int _currentIndex = 0;
  final TextEditingController _userReviewController = TextEditingController();
  final List<Map<String, String>> _userReviews = [];

  final List<String> _images = [
    'images/quaid.jpg',
    'images/tomb.jpg',
    'images/mazar.jpg',
    'images/mazarequaid.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double portraitWidth = screenWidth;
    double portraitHeight = screenHeight * 0.5;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Stack(
                children: [
                  CarouselSlider(
                    items: _images.map((image) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            image,
                            height: portraitHeight,
                            width: portraitWidth,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.red, // Change color as needed
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCategory(Icons.contact_phone_rounded, 'Contact'),
                  buildCategory(Icons.comment_rounded, 'Review'),
                  InkWell(
                    onTap: () {
                      // Add your logic here
                    },
                    child: buildCategory(Icons.map_rounded, 'Map'),
                  )
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Mazar e Quaid',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Mazar-e-Quaid (Urdu: مزارِ قائد), also known as Jinnah Mausoleum or the National Mausoleum, is the final resting place of Muhammad Ali Jinnah, the founder of Pakistan. Designed in a 1960s',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Location',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'M.A Jinnah Rd, Central Jacob Lines Ghm، Karachi, Karachi City, Sindh, Pakistan',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Contacts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Phone: +39 031 950 205',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Email: info@bellagio.com',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red, // Change color as needed
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    for (var review in _userReviews) buildReview(review['name']!, review['comment']!),
                    SizedBox(height: 16),
                    // User review input box and submit button
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), // Square shape
                          border: Border.all(color: Colors.grey), // Border color
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _userReviewController,
                                decoration: InputDecoration(
                                  hintText: 'Write your review...',
                                  border: InputBorder.none, // Remove TextField border
                                  contentPadding: EdgeInsets.all(12),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _userReviews.add({
                                    'name': 'Your Name', // You can replace 'Your Name' with the actual name of the user
                                    'comment': _userReviewController.text,
                                  });
                                  _userReviewController.clear();
                                });
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Place the custom carousel indicator below the carousel
              SizedBox(height: 16),
              CustomCarouselIndicator(
                count: _images.length,
                currentIndex: _currentIndex,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  // Add your logic here
                },
                icon: Icon(Icons.home),
              ),
              IconButton(
                onPressed: () {
                  // Add your logic here
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  // Add your logic here
                },
                icon: Icon(Icons.notifications),
              ),
              IconButton(
                onPressed: () {
                  // Add your logic here
                },
                icon: Icon(Icons.account_circle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategory(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            size: 25,
            color: Colors.blue, // Change color as needed
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildReview(String name, String comment) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('images/avatar.jpg'),
          radius: 24,
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                comment,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomCarouselIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  CustomCarouselIndicator({required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  }
}





















///wrong navbar
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'custom_carousel_indicator.dart'; // Import the custom carousel indicator 

// class Details extends StatefulWidget {
//   const Details({Key? key});

//   @override
//   State<Details> createState() => _DetailsState();
// }

// class _DetailsState extends State<Details> {
//   int _currentIndex = 0;

//   final List<String> _images = [
//     'images/quaid.jpg',
//     'images/tomb.jpg',
//     'images/mazar.jpg',
//     'images/mazarequaid.jpg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     double portraitWidth = screenWidth;
//     double portraitHeight = screenHeight * 0.5;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 16),
//               Stack(
//                 children: [
//                   CarouselSlider(
//                     items: _images.map((image) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(25),
//                           child: Image.asset(
//                             image,
//                             height: portraitHeight,
//                             width: portraitWidth,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     options: CarouselOptions(
//                       autoPlay: true,
//                       aspectRatio: 16 / 9,
//                       enlargeCenterPage: true,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           _currentIndex = index;
//                         });
//                       },
//                     ),
//                   ),
//                   Positioned(
//                     top: 16,
//                     right: 16,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 5,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: IconButton(
//                         icon: Icon(
//                           Icons.favorite_border,
//                           color: Colors.red, // Change color as needed
//                         ),
//                         onPressed: () {},
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   buildCategory(Icons.contact_phone_rounded, 'Contact'),
//                   buildCategory(Icons.comment_rounded, 'Review'),
//                   InkWell(
//                     onTap: () {
//                       // Add your logic here
//                     },
//                     child: buildCategory(Icons.map_rounded, 'Map'),
//                   )
//                 ],
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Mazar e Quaid',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Description',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Mazar-e-Quaid (Urdu: مزارِ قائد), also known as Jinnah Mausoleum or the National Mausoleum, is the final resting place of Muhammad Ali Jinnah, the founder of Pakistan. Designed in a 1960s',
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: Colors.grey[700],
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Location',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'M.A Jinnah Rd, Central Jacob Lines Ghm، Karachi, Karachi City, Sindh, Pakistan',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[700],
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Contacts',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Phone: +39 031 950 205',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[700],
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Email: info@bellagio.com',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[700],
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Reviews',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red, // Change color as needed
//                 ),
//               ),
//               SizedBox(height: 8),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 8,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     buildReview('John Doe', 'Great place to visit!'),
//                     SizedBox(height: 16),
//                     buildReview(
//                         'Jane Doe', 'Beautiful town with amazing views!'),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16),
//               // Place the custom carousel indicator below the carousel
//               SizedBox(height: 16),
//               CustomCarouselIndicator(
//                 count: _images.length,
//                 currentIndex: _currentIndex,
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.white,
//         child: Container(
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   // Add your logic here
//                 },
//                 icon: Icon(Icons.home),
//               ),
//               IconButton(
//                 onPressed: () {
//                   // Add your logic here
//                 },
//                 icon: Icon(Icons.search),
//               ),
//               IconButton(
//                 onPressed: () {
//                   // Add your logic here
//                 },
//                 icon: Icon(Icons.notifications),
//               ),
//               IconButton(
//                 onPressed: () {
//                   // Add your logic here
//                 },
//                 icon: Icon(Icons.account_circle),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildCategory(IconData icon, String label) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Icon(
//             icon,
//             size: 25,
//             color: Colors.blue, // Change color as needed
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }

//   Widget buildReview(String name, String comment) {
//     return Row(
//       children: [
//         CircleAvatar(
//           backgroundImage: AssetImage('images/avatar.jpg'),
//           radius: 24,
//         ),
//         SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 comment,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[700],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class CustomCarouselIndicator extends StatelessWidget {
//   final int count;
//   final int currentIndex;

//   CustomCarouselIndicator({required this.count, required this.currentIndex});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(count, (index) {
//         return Container(
//           width: 8.0,
//           height: 8.0,
//           margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: currentIndex == index ? Colors.blue : Colors.grey,
//           ),
//         );
//       }),
//     );
//   }
// }

















