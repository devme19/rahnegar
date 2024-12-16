

import 'package:flutter/material.dart';
import 'package:rahnegar/common/utils/constants.dart';

class MyButton extends StatefulWidget {
  Color color;
  String text;
  Color textColor;
  Function onTap;
  String text2;
  Color? textColor2;

  MyButton({super.key,required this.color,required this.text,this.textColor = Colors.white,this.text2='',this.textColor2,required this.onTap});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  Color? splashColor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashColor = widget.color;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTap();
        setState(() {
          splashColor = widget.color.withOpacity(0.6);
          // splashColor = Colors.red;
        });

      },
      child: AnimatedContainer(
        height: 55.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(customButtonBorderRadius),
          color: splashColor,
        ),
        duration: const Duration(milliseconds: 200),
        child:
        widget.text2.isNotEmpty?
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white),
              ),
              Text(
                widget.text2,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: widget.textColor2),
              ),
          ],),
        ):
        Center(
          child: Text(
              widget.text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: widget.textColor)
          ),
        ),
      ),
    );
  }
}
