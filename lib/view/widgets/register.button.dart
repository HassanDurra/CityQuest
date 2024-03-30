import 'package:cityquest/assets/colors.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       
      },
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 8, 111, 145),
          borderRadius: BorderRadius.circular(6),
          border:
              Border.all(color: Color.fromARGB(255, 8, 111, 145),
 width: 1.5),
          boxShadow: [
            BoxShadow(
              color:  Color.fromARGB(82, 4, 5, 5),
              blurRadius: 5,
            )
          ],
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
              fontFamily: 'poppins',

          ),
        ),
      ),
    );
  }
}
