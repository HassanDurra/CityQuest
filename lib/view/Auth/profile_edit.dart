import 'dart:convert';
import 'dart:io';

import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/Auth/buttons/editprofilebutton.dart';
import 'package:cityquest/view/Auth/buttons/register.button.dart';
import 'package:cityquest/view/Auth/login.dart';
import 'package:cityquest/view/widgets/User/partial/navbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  Map<String, dynamic> userData = {};
  String unknowImagePath =
      "https://static.vecteezy.com/system/resources/previews/027/448/973/original/avatar-account-icon-default-social-media-profile-photo-vector.jpg";
  Future<void> getData() async {
    var pref = await SharedPreferences.getInstance();
    String? user = pref.getString('user');

    if (user != null) {
      setState(() {
        userData = jsonDecode(user);
      });
    }
  }

  bool _isObscure = true;
  File? _image;
  late XFile _pickedFile;
  bool _isObscurepassword = true;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  // Image Picker Function
  @override
  void initState() {
    super.initState();
    userNameController.text = userData['username'] ?? "";
    nameController.text = userData['name'] ?? "";
    emailController.text = userData['email'] ?? "";
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          )),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(color: Color.fromARGB(41, 0, 0, 0), blurRadius: 7)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    CircleAvatar(
                      backgroundImage: userData['image'] != null
                          ? NetworkImage(userData['image'])
                          : NetworkImage(unknowImagePath),
                      radius: 30,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Edit Account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Profile Image",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),

                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: GlobalColors.mainColor,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(41, 0, 0, 0),
                                  blurRadius: 7)
                            ]),
                        margin: EdgeInsets.all(5),
                        child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Ionicons.image_outline,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Choose Image",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ))),

                    ///email
                    ///
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      child: TextFormField(
                        controller: userNameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter Username',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Enter Name',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    ///password
                    SizedBox(height: 10),

                    // button
                    SizedBox(height: 15),

                    EditProfileButton(
                      username: userNameController,
                      email: emailController,
                      fullname: nameController,
                    ),
                    //Forgot Password
                    SizedBox(height: 10),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: GlobalColors.mainColor,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(41, 0, 0, 0),
                                  blurRadius: 7)
                            ]),
                        margin: EdgeInsets.all(5),
                        child: InkWell(
                            onTap: () {},
                            child: Text(
                              "Save Changes",
                              style: TextStyle(color: Colors.white),
                            ))),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          // Navigate to Forgot Password view
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Navbar(),
                            ),
                          );
                        },
                        child: Text(
                          'Back to Home ?',
                          style: TextStyle(
                            color: GlobalColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
