import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home_page.dart';

class SlashScreen extends StatelessWidget {
  const SlashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      duration: const Duration(seconds: 3),
      // setStateTimer: const Duration(seconds: 5),
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
              "https://assets4.lottiefiles.com/packages/lf20_mzgub9x6.json"),
          Column(
            children: const [
              CupertinoActivityIndicator(),
              Text("Loading...."),
            ],
          )
        ],
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      defaultNextScreen: const HomePage(),
    );
  }
}
