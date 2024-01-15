import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
                child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                child: Image.asset("../images/TravelLogo.png",
                                  height: 300,
                                  ),
                ),
              );
  }
}