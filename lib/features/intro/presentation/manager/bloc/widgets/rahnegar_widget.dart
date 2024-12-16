import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RahnegarWidget extends StatelessWidget {
  const RahnegarWidget({super.key});


  final int startAnimateTime = 1000;
  final int timeOffset = 300;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Animate(
            delay: Duration(milliseconds: startAnimateTime+8*timeOffset),
            effects: const [FadeEffect()],
            child:
            Image.asset("assets/images/splash/r.png", fit: BoxFit.contain,height: 50,width: 50,),
          ),
        ),
        Expanded(
          child: Animate(
            delay: Duration(milliseconds: startAnimateTime+7*timeOffset),
            effects: const [FadeEffect()],
            child:
            Image.asset("assets/images/splash/a.png", fit: BoxFit.contain,height: 50,width: 50,),
          ),
        ),
        Expanded(
          child: Animate(
            delay: Duration(milliseconds: startAnimateTime+6*timeOffset),
            effects: const [FadeEffect()],
            child:
            Image.asset("assets/images/splash/g.png", fit: BoxFit.contain,height: 50,width: 50,),
          ),
        ),
        Expanded(
          child: Animate(
            delay: Duration(milliseconds: startAnimateTime+5*timeOffset),
            effects: const [FadeEffect()],
            child:
            Image.asset("assets/images/splash/e1.png", fit: BoxFit.contain,height: 50,width: 50,),
          ),
        ),
        Expanded(
          child: Animate(
            delay: Duration(milliseconds: startAnimateTime+4*timeOffset),
            effects: const [FadeEffect()],
            child:
            Image.asset("assets/images/splash/n.png", fit: BoxFit.contain,height: 50,width: 50,),
          ),
        ),
        Expanded(
          child: Animate(
            delay: Duration(milliseconds: startAnimateTime+3*timeOffset),
            effects: const [FadeEffect()],
            child:
            Image.asset("assets/images/splash/h2.png", fit: BoxFit.contain,height: 50,width: 50,),
          ),
        ),
        Expanded(
          child: Animate(
            delay: Duration(milliseconds: startAnimateTime+2*timeOffset),
            effects: const [FadeEffect()],
            child:
            Image.asset("assets/images/splash/h1.png", fit: BoxFit.contain,height: 50,width: 50,),
          ),
        ),
        Expanded(
          child: Animate(
            delay: Duration(milliseconds: startAnimateTime+timeOffset),
            effects: const [FadeEffect()],
            child:
            Image.asset("assets/images/splash/a.png", fit: BoxFit.contain,height: 50,width: 50,),
          ),
        ),
        Expanded(
          child: Animate(
            delay: Duration(milliseconds: startAnimateTime),
            effects: const [FadeEffect()],
            child:
            Image.asset("assets/images/splash/r.png", fit: BoxFit.contain,height: 50,width: 50,),
          ),
        ),





        // Expanded(
        //   child: Animate(
        //     delay: Duration(milliseconds: startAnimateTime+8*timeOffset),
        //     effects: const [FadeEffect()],
        //     child:
        //     Image.asset("assets/images/splash/r.png", fit: BoxFit.contain,height: 50,width: 50,),
        //   ),
        // ),
      ],
    );
  }
}
