import 'package:flutter/material.dart';

//class to store all the colors
class MyColors {
  static const Color black = Color.fromRGBO(88, 88, 88, 1.0);
  static const Color grey = Color.fromRGBO(88, 88, 88, 1.0);
  static const Color orange = Color.fromRGBO(141, 145, 247, 1.0);
  static const Color background = Colors.white;

  Widget container = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: MyColors.orange,
    ),
    // width: MediaQuery.of(context).size.width * .9,
    height: 55,
    child: TextButton(
        style: ButtonStyle(
            foregroundColor:
            MaterialStateProperty.resolveWith((state) => MyColors.orange),
            backgroundColor:
            MaterialStateProperty.resolveWith((state) => MyColors.orange)),
        onPressed: (){},
        child: const Text(
          "Get started",
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
  );
}

