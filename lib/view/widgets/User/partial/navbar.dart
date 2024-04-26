import 'dart:convert';

import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/widgets/User/home.dart';
import 'package:cityquest/view/widgets/User/pages/Cities.dart';
import 'package:cityquest/view/widgets/User/pages/Food.dart';
import 'package:cityquest/view/widgets/User/pages/Profile.dart';
import 'package:cityquest/view/widgets/User/pages/Map.dart';
import 'package:cityquest/view/widgets/User/pages/Listing.dart';
import 'package:cityquest/view/widgets/User/pages/Search.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int CurrentTab = 0;
  final List<Widget> screens = [
    ProfileScreen(),
    Cities(),
    MapView(),
    Listing(),
    Search(),
    Food(),
    HomeView()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeView();
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

  // logout Function
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipOval(
          child: Material(
            color: CurrentTab == 0 ? GlobalColors.mainColor : Colors.white,
            child: InkWell(
              splashColor: GlobalColors.secondaryColor,
              onTap: () {
                setState(() {
                  currentScreen = HomeView();
                  CurrentTab = 0;
                });
                // Add your onPressed logic here
              },
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Ionicons.home,
                  color: CurrentTab == 0
                      ? Color.fromARGB(255, 255, 255, 255)
                      : GlobalColors.mainColor,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomAppBar(
        height: 65,
        color: Colors.white10,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = MapView();
                        CurrentTab = 2;
                      });
                    },
                    minWidth: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.map_outline,
                          color: CurrentTab == 2
                              ? GlobalColors.mainColor
                              : Colors.black54,
                        ),
                        Text(
                          "Map",
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'poppins',
                            color: CurrentTab == 2
                                ? GlobalColors.mainColor
                                : Colors.black54,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Listing();
                        CurrentTab = 1;
                      });
                    },
                    minWidth: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.image_outline,
                          color: CurrentTab == 1
                              ? GlobalColors.mainColor
                              : Colors.black54,
                        ),
                        Text(
                          "Places",
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'poppins',
                              color: CurrentTab == 1
                                  ? GlobalColors.mainColor
                                  : Colors.black54),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Cities();
                        CurrentTab = 6;
                      });
                    },
                    minWidth: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.business_outline,
                          color: CurrentTab == 6
                              ? GlobalColors.mainColor
                              : Colors.black54,
                        ),
                        Text(
                          "Cities",
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'poppins',
                              color: CurrentTab == 6
                                  ? GlobalColors.secondaryColor
                                  : Colors.black54),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // Right side data
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Search();
                        CurrentTab = 3;
                      });
                    },
                    minWidth: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.search_outline,
                          color: CurrentTab == 3
                              ? GlobalColors.mainColor
                              : Colors.black54,
                        ),
                        Text(
                          "Search",
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'poppins',
                              color: CurrentTab == 3
                                  ? GlobalColors.mainColor
                                  : Colors.black54),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Food();
                        CurrentTab = 4;
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.restaurant_outline,
                          color: CurrentTab == 4
                              ? GlobalColors.mainColor
                              : Colors.black54,
                        ),
                        Text(
                          "Foods",
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'poppins',
                              color: CurrentTab == 4
                                  ? GlobalColors.mainColor
                                  : Colors.black54),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfileScreen();
                        CurrentTab = 5;
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.person_circle_outline,
                          color: CurrentTab == 5
                              ? GlobalColors.mainColor
                              : Colors.black54,
                        ),
                        Text(
                          "Setting",
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'poppins',
                              color: CurrentTab == 5
                                  ? GlobalColors.mainColor
                                  : Colors.black54),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
