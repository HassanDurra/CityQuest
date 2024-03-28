import 'package:cityquest/assets/colors.dart';
import 'package:flutter/material.dart';

class ButtonGlobal extends StatelessWidget {
  const ButtonGlobal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ignore: avoid_print
        print('Login');
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
              color: Color.fromARGB(160, 4, 5, 4),
              blurRadius: 10,
            )
          ],
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
