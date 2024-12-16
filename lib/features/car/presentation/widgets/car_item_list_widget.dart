import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/entity/my_cars_entity.dart';
class CarItemListWidget extends StatefulWidget {
  CarEntity car;
  CarEntity? selectedCar;
  bool? isFirst;
  Function(CarEntity)? onTap;


  CarItemListWidget({required this.car,this.isFirst,this.selectedCar,this.onTap});

  @override
  State<CarItemListWidget> createState() => _CarItemListWidgetState();
}

class _CarItemListWidgetState extends State<CarItemListWidget> {

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: (){
          if(widget.onTap!=null){
            widget.onTap!(widget.car);
            setState(() {
            });
          }
        },
        child:
        Column(
          children: [
            widget.isFirst!=null?widget.isFirst!?Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(AppLocalizations.of(context)!.defaultCar,style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),),
            ):Container():Container(),
            Expanded(
              child: Row(
              children: [
                check(),
                Expanded(child:Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
              
                      Row(
                        children: [
                          Expanded(child: Text(widget.car.nickname??'',maxLines:2,overflow: TextOverflow.ellipsis))
                        ],
                      ),
                      Row(
                        children: [
                          Text(AppLocalizations.of(context)!.serialNumber,style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(width: 8.0,),
                          Text(widget.car.serialNumber??'',style: Theme.of(context).textTheme.bodySmall),
                        ],
                      )
                    ],),
                )),
              
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0,),
                  // Set your desired border radius
                  child: CachedNetworkImage(
                    height: 40,
                    width: 40,
                    imageUrl: widget.car.iconLink??'',fit: BoxFit.scaleDown,placeholder: (context, url) => SizedBox(),
                    errorWidget: (context, url, error) => Icon(Icons.error),),
                ),
                const SizedBox(width: 16.0,)
              ],
                  ),
            ),
          ],
        ),
      );
  }
  check(){
    if(widget.selectedCar!= null){
      if(widget.car.id == widget.selectedCar!.id){
        return
          Animate(
            effects: [FadeEffect()],
            child: SizedBox(
            width: 40,
            height: 40,
            child: Center(child: Image.asset("assets/images/home/check.png",width: 30,)),
                    ),
          );
      }
      return const SizedBox(
        width: 40,
        height: 40,
      );
    }else {
      return Container();
    }

  }
}
