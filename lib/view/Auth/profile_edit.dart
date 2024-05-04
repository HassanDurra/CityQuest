import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/Auth/buttons/editprofilebutton.dart';
import 'package:cityquest/view/Auth/buttons/register.button.dart';
import 'package:cityquest/view/Auth/login.dart';
import 'package:cityquest/view/widgets/User/partial/navbar.dart';
import 'package:cityquest/webapi/cityquestweb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  bool _isObscure = true;
  bool _isObscurepassword = true;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  Map<String, dynamic> userData = {};
  String? userImage;
  String? userID;
  String unknowImagePath =
      "https://static.vecteezy.com/system/resources/previews/027/448/973/original/avatar-account-icon-default-social-media-profile-photo-vector.jpg";
  Future<void> getData() async {
    var pref = await SharedPreferences.getInstance();
    String? user = pref.getString('user');

    if (user != null) {
      setState(() {
        userData = jsonDecode(user);
        userNameController.text = userData['username'] ?? "";
        nameController.text = userData['name'] ?? "";
        emailController.text = userData['email'] ?? "";
        userImage = userData['image'] ?? "";
        userID = userData['id'];
      });
    }
  }

  // Image Picker Function
  File? imagePath;
  String? imageName;
  String? imageData;
  ImagePicker _imagePicker = new ImagePicker();
  Future<void> storeData(data) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString('user', data);
  }

  Future<void> chooseImage() async {
    var getImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    imagePath = File(getImage!.path);
    List<int> imageBytes = await getImage!.readAsBytes();
    String base64encoded = base64Encode(imageBytes);
    setState(() {
      imageData = base64encoded;
    });
  }

  bool isValidEmail(String email) {
    RegExp emailRegx = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    return emailRegx.hasMatch(email);
  }

  Future<void> UpdateUser() async {
    if (userNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(children: [
          Icon(Ionicons.alert_circle_outline, color: Colors.white),
          SizedBox(width: 10),
          Text("Username is required")
        ]),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    } else if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(children: [
          Icon(Ionicons.alert_circle_outline, color: Colors.white),
          SizedBox(width: 10),
          Text("Full name is required")
        ]),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    } else if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(children: [
          Icon(Ionicons.alert_circle_outline, color: Colors.white),
          SizedBox(width: 10),
          Text("Email is required")
        ]),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    } else if (!isValidEmail(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(
              Ionicons.alert_circle_outline,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Please enter a valid email',
              style: TextStyle(
                  fontSize: 13, color: Colors.white, fontFamily: 'poppins'),
            )
          ],
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    } else {
      try {
        final URL =
            Uri.parse(apiCredientals.base_url+'CityQuestWEB/User/update?id=${userID}');
        var response = await http.post(URL, body: {
          'name': nameController.text,
          'username': userNameController.text,
          'email': emailController.text,
          'image': imageData ?? "",
        });
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          if (jsonResponse['message'] == "success") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.checkbox_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Profile Data has been Updated',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontFamily: 'poppins'),
                  )
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ));
            setState(() {
              storeData(jsonResponse['data']);
              getData();
            });
          } else if (jsonResponse['message'] == "error") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${jsonResponse["error"]}',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontFamily: 'poppins'),
                  )
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ));

            Timer(Duration(seconds: 2), () {
              Get.offAll(() => Navbar());
            });
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Icon(
                Ionicons.alert_circle_outline,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '${e}',
                style: TextStyle(
                    fontSize: 13, color: Colors.white, fontFamily: 'poppins'),
              )
            ],
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  void initState() {
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
                      backgroundImage: userImage != null
                          ? NetworkImage(userImage.toString())
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
                            onTap: () {
                              chooseImage();
                            },
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
                            onTap: () {
                              UpdateUser();
                            },
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
