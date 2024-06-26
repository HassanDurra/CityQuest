import 'package:cityquest/assets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';

class SociaLogin extends StatelessWidget {
  const SociaLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            '- Or sign in with -',
            style: TextStyle(
              color: const Color.fromARGB(214, 0, 0, 0),
              fontFamily: 'poppins',
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            children: [
     ///google
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(118, 0, 0, 0).withOpacity(0.1),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: SvgPicture.asset('images/googlesvg.svg',
                      height: 20),
                ),
              ),

              const SizedBox(width: 10),

  ///facebook
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(118, 0, 0, 0).withOpacity(0.1),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.facebook,
                    color: Colors.blue,
                  ),
                ),
              ),

              const SizedBox(width: 10),

   ///TWITTER
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(188, 0, 0, 0).withOpacity(0.1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(Ionicons.logo_github)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
