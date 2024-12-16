import 'package:flutter/material.dart';
import 'package:get/get.dart';
class BackGroundWidget extends StatelessWidget {
  BackGroundWidget({super.key,required this.children});
  List<Widget> children;
  Widget? child2;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: Colors.white,
        child: Stack(
        children: [
          Positioned(
            bottom: 50,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/main/background.png',width: MediaQuery.of(context).size.width,fit: BoxFit.cover,)),
          // Align(
          //     alignment: Alignment.bottomCenter,
          //     child: Image.asset('assets/images/main/background.png')),
          ...children,
        ],
            ),
      );
  }
}
