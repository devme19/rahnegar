import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';
import 'package:rahnegar/theme/app_themes.dart';

import '../../features/car/presentation/widgets/car_item_list_widget.dart';

class DismissibleWidget extends StatefulWidget {
  DismissibleWidget({super.key,required this.onTap, required this.isFirst,required this.car,required this.onDeleteTap,this.cancelDelete=false,required this.index,required this.selectedIndex});
  bool isFirst;
  CarEntity car;
  int index;
  int selectedIndex;
  Function(CarEntity) onDeleteTap;
  bool cancelDelete;
  Function(CarEntity) onTap;
  @override
  _DismissibleWidgetState createState() => _DismissibleWidgetState();
}

class _DismissibleWidgetState extends State<DismissibleWidget> with SingleTickerProviderStateMixin {
  double dragExtent = 0.0;
  double maxDragExtent = 70.0;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool tapped = false;


  @override
  void didUpdateWidget(DismissibleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.cancelDelete && widget.index == widget.selectedIndex){
      dragExtent = 0;
      // setState(() {
      // });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() {
      setState(() {
        dragExtent = _animation.value;
      });
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    dragExtent += details.primaryDelta ?? 0;
    dragExtent = dragExtent.clamp(-maxDragExtent, maxDragExtent);
    setState(() {

    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    double threshold = maxDragExtent / 5;
    if (dragExtent > threshold) {
      _animateTo(0.0);
    } else if (dragExtent < -threshold) {
      _animateTo(-maxDragExtent);
    } else {
      _animateTo(0.0);
    }
  }

  void _animateTo(double target) {
    _animation = Tween<double>(begin: dragExtent, end: target).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("cancel ${widget.cancelDelete}");
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          GestureDetector(
            // splashColor: Colors.black,
            // highlightColor: Colors.yellow,
            // overlayColor: WidgetStateProperty.all(Colors.blueAccent.withOpacity(0.2)),
            onTap: (){
              setState(() {
                tapped = true;
              });
              Future.delayed(Duration(milliseconds: 150)).then((onValue){
                tapped = false;
                setState(() {

                });
              });
              widget.onDeleteTap(widget.car);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: AnimatedContainer(
                width: 100,
                height: 120,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: tapped?Colors.black:Colors.red,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color:Theme.of(context).brightness == Brightness.light? Colors.grey.shade100:Colors.black54,width: 6),
                ),
                duration: const Duration(milliseconds: 500),
                child: const Row(children: [
                  SizedBox(width: 22.0,),
                  Icon(Icons.delete,color: Colors.white,)
                ],),
              ),
            ),
          ),
          GestureDetector(
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            onTap: (){
              print("sasa");
            },
            child: Transform.translate(
              offset: Offset(dragExtent, 0),
              child:
              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light?Colors.white:appBarDarkColor,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Colors.grey.shade300,width: 0.5),
                ),
                child:CarItemListWidget(car: widget.car,isFirst: widget.isFirst,onTap: (car)=>widget.onTap(car))
              )
            ),
          ),
        ],
      ),
    );
  }
}