import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpacerWithMessageWidget extends StatelessWidget {
  SpacerWithMessageWidget({super.key,required this.height,required this.showMessage,required this.message,this.messageColor = Colors.red,this.fontSize=10});
  double height;
  bool showMessage;
  String message;
  Color messageColor;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: showMessage?
      Animate(
        effects: [FadeEffect()],
        child: Row(
          children: [
            Text(message,style: TextStyle(color: messageColor,fontSize: fontSize),),
          ],
        ),
      ):Container(),
    );
  }
}
