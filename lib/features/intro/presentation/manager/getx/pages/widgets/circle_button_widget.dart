import 'package:flutter/material.dart';

class CircleButtonWidget extends StatefulWidget {
  CircleButtonWidget({super.key,required this.color,required this.onTap,required this.child});
  Color color;
  Function onTap;
  Widget child;
  @override
  State<CircleButtonWidget> createState() => _CircleButtonWidgetState();
}

class _CircleButtonWidgetState extends State<CircleButtonWidget> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          setState(() {
            isTapped = true;
            Future.delayed(const Duration(milliseconds: 200)).then((onValue){
              setState(() {
                isTapped = false;
              });
            });
          });
          widget.onTap();
      },
        child: AnimatedContainer(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isTapped?widget.color.withOpacity(0.7):widget.color
          ), duration: const Duration(milliseconds: 200),
          child: widget.child,
        ));
  }
}
