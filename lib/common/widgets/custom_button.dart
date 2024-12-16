

import 'package:flutter/material.dart';
import 'package:rahnegar/common/utils/constants.dart';

class CustomButton extends StatefulWidget {
  Color color;
  String? text;
  Color textColor;
  Function onTap;
  double width,height;
  Widget? image;
  double borderRadius;

  CustomButton({super.key,required this.color,this.text,this.textColor = Colors.white,this.width=0,this.height=0,this.borderRadius=10,this.image,required this.onTap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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
        // Future.delayed(const Duration(milliseconds: 200)).then((onValue){
        //   setState(() {
        //     splashColor = widget.color;
        //   });
        // });
      },
      child: AnimatedContainer(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: splashColor,
        ),
        duration: const Duration(milliseconds: 200),
        child:
        widget.text!=null?
        Center(
          child: Text(
              widget.text!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: widget.textColor)
          ),
        ):widget.image ?? Container(),
      ),
    );
  }
}
