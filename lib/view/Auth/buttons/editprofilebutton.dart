import 'package:flutter/material.dart';

class EditProfileButton extends StatefulWidget {
  final String? ImagePath;
  final TextEditingController? email;
  final TextEditingController? username;
  final TextEditingController? fullname;

  const EditProfileButton(
      {super.key, this.ImagePath, this.email, this.username, this.fullname});

  @override
  State<EditProfileButton> createState() => _EditProfileButtonState();
}

class _EditProfileButtonState extends State<EditProfileButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
