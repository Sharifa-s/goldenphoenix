import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goldenphoenix/Design/colors.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 4),
      () {
        Navigator.of(context).popAndPushNamed('/welcome');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Golden",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontFamily: 'EagleLake',
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 50,width: 50,child: Image.asset('images/wine.png')),
                const Text("phoenix",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontFamily: 'EagleLake',
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          LottieBuilder.network(
              'https://lottie.host/17229599-6a97-42c6-9787-9ae98e58b647/NYyUQ8DX49.json')
        ],
      ),
    );
  }
}
