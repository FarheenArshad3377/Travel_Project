import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:aniproject/screen/home/home.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late Future<void> _imageLoader;

  @override
  void initState() {
    super.initState();
    // Preload the image
    _imageLoader = _preloadImage();

    // Navigate to HomeClass after 5 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 500),
          child: HomeClass(),
        ),
      );
    });
  }

  Future<void> _preloadImage() async {
    // Preload the image to avoid initial blank screen
    await precacheImage(AssetImage("assets/img/s.jpg"), context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _imageLoader,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Display the UI once the image is loaded
          return Scaffold(
            backgroundColor: Colors.teal,
            body: Stack(
              children: [
                // Blurred Background Image
                Positioned.fill(
                  child: Image.asset(
                    "assets/img/s.jpg", // Replace with your background image path
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2,sigmaY: 2
                    ), // Moderate blur
                    child: Container(
                      color: Colors.black.withOpacity(0.2), // Slight dark overlay
                    ),
                  ),
                ),
                // Centered Lottie Animation
          Center(
            child: Lottie.asset(
              "assets/animation/Animation - 1737575155202.json",repeat: true,animate: true,
              //h to your Lottie file
              height: 200, // Adjust size as needed
              width: 200,
            ),
          ),
              ],
            ),
          );
        } else {
          // Display a loading indicator while the image is loading
          return Scaffold(
            body: Container(
              color: Colors.black, // Use a fallback color for the loading phase
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
