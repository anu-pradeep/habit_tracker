import 'package:flutter/material.dart';

import '../custom_widgets/custom_color.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 08), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.screenColor,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 275,
          left: 80,
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/habit tracker.png',
              width: 250,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 310),
              child: Text(
                'Small steps, Big changes',
                style: TextStyle(
                    color: CustomColors.blackColor,
                    fontFamily: 'PoppinsMedium',
                    fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
