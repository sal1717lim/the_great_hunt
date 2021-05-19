import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main-page.dart';
import '../ressource/bdd.dart';

class load extends StatelessWidget{


  @override
  build(BuildContext context) {
    /*script de base de donnée*/
    bddexiste();

    return Stack(
      children: [

        Positioned(
          bottom: 0,top: 0,left: 0,right: 0,
            child: AnimatedSplash(
          imagePath: "assets\\images\\mcGH.gif",
          home: MyHomePage(),
          duration: 5000,
              //type: AnimatedSplashType.StaticDuration,

        ))
      ],
    );
  }
}