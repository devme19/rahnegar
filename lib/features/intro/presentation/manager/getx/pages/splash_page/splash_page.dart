import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'controller/splash_page_controller.dart';


class SplashPage extends StatelessWidget {
  SplashPage({super.key}){
    SplashPageController controller = Get.find();
    controller.isAuthorized();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body:
           Stack(children: [
             Animate(
               effects: [FadeEffect()],
               // delay: Duration(milliseconds: 500),
               child: SizedBox(
                   height: double.infinity,
                   width: double.infinity,
                   child: Image.asset("assets/images/splash/bottom.png",fit: BoxFit.fill,)
               ),
             ),
             Align(
               alignment: Alignment.topLeft,
               child: Animate(
                 effects: [FadeEffect()],
                 delay: Duration(milliseconds: 400),
                 child: SizedBox(
                     height: 300,
                     width: double.infinity,
                     child: Image.asset("assets/images/splash/map.png",fit: BoxFit.fill,)
                 ),
               ),
             ),
             Positioned(
               left: 110,
               top: 100,
               child: Animate(
                 effects: [FadeEffect(duration: Duration(milliseconds: 500))],
                 delay: Duration(milliseconds: 1000),
                 child: SizedBox(
                     height: 60,
                     width: 50,
                     child: Image.asset("assets/images/splash/marker.png",fit: BoxFit.fill,)
                 ),
               ),
             ),
             Align(
               alignment: Alignment.bottomCenter,
               child: Animate(
                 effects: [FadeEffect(duration: Duration(milliseconds: 500))],
                 delay: Duration(milliseconds: 1300),
                 child:
                 Padding(
                   padding: const EdgeInsets.only(bottom: 100.0),
                   child: Image.asset("assets/images/splash/rahnegar.png",fit: BoxFit.fill,),
                 ),
               ),
             ),
           ],)
        // SizedBox(
        //     height: double.infinity,
        //     width: double.infinity,
        //     child: Image.asset("assets/images/splash/splash.png",fit: BoxFit.fill,)
        // ),
        )
    );
  }
}