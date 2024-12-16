import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class HomeButtonWidget extends StatefulWidget {
  HomeButtonWidget({super.key,required this.child,this.title="",required this.width,this.isActive});
  Widget child;
  String? title;
  double width;
  bool? isActive;

  @override
  State<HomeButtonWidget> createState() => _HomeButtonWidgetState();
}

class _HomeButtonWidgetState extends State<HomeButtonWidget> {
  // Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      width: widget.width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: widget.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    // color: Theme.of(context).brightness == Brightness.light?Colors.black12:Colors.grey,
                    color:getColor(),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Colors.black12,
                    //     blurRadius: 6.0,
                    //     offset: Offset(5, 3),
                    //   ),
                    // ],
                  ),
                  // duration: Duration(milliseconds: 200),
                  child: widget.child,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0,),
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(widget.title!,style:Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,),
          ))
        ],
      ),
    );
  }
  Color getColor(){
    if(widget.isActive == null){
      if(Theme.of(context).brightness == Brightness.light){
        return Colors.black12;
      }else{
        return Colors.grey;
      }
    }else {
      if(widget.isActive!){
        return Colors.green.shade200;
      }else{
        return Colors.red.shade200;
      }
    }
  }
}
