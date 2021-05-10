import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main-page.dart';
class load extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        SvgPicture.asset("assets\\images\\paper.svg"),
        Positioned(
          bottom: 0,top: 0,left: 0,right: 0,
            child: AnimatedSplash(
          imagePath: "assets\\images\\mcGH.gif",
          home: MyHomePage(),
          duration: 6000,
              type: AnimatedSplashType.StaticDuration,

        ))
      ],
    );
  }
}