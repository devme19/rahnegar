import 'package:flutter/material.dart';

class BackGroundWidget extends StatelessWidget {
  const BackGroundWidget({super.key,this.widget});
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey.shade300,
      color: Colors.white,
      child: Stack(
        children: [
          if (widget!=null) widget! else Container(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/splash/negar_logo.png", fit: BoxFit.contain,width: 70,),
                  Image.asset("assets/images/splash/negar.png", fit: BoxFit.contain,width: 70),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
