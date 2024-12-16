import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rahnegar/common/widgets/my_button.dart';
import 'package:rahnegar/features/map/presentation/manager/GetX/page/map_page/controller/osm_map_controller.dart';


class MarkedLocationsWidget extends StatefulWidget {
  const MarkedLocationsWidget({super.key});

  @override
  State<MarkedLocationsWidget> createState() => _MarkedLocationsWidgetState();
}

class _MarkedLocationsWidgetState extends State<MarkedLocationsWidget> {

  OsmMapController controller  = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAllMarkedLocations();

  }
  bool isExpand = false;
  @override
  Widget build(BuildContext context) {
    return
      Obx(()=>AnimatedContainer(
        color:Theme.of(context).brightness==Brightness.dark?Colors.black54:Colors.white.withOpacity(0.65),
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        height: isExpand?320: 60,
        duration: const Duration(milliseconds: 150),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  isExpand = !isExpand;
                });
                if(isExpand){
                  controller.getAllMarkedLocations();
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(AppLocalizations.of(context)!.markedLocations,style: Theme.of(context).textTheme.bodyLarge,),
                  AnimatedSwitcher(
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    duration: const Duration(milliseconds: 500),
                    child: Icon(
                      isExpand ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                      key: ValueKey<bool>(isExpand),
                      size: 25,
                      // color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            controller.allMarkedLocationEntity.value.data!.isEmpty?
            Text(AppLocalizations.of(context)!.noItemFound):
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                  // separatorBuilder: (context,index)=>Divider(color: Theme.of(context).brightness == Brightness.light?Colors.grey:Colors.white,),
                    itemCount: controller.allMarkedLocationEntity.value.data!.length,
                    itemBuilder: (BuildContext context, int index){
                      return ListTile(
                        title: Text(controller.allMarkedLocationEntity.value.data![index].name??'',
                        style: Theme.of(context).textTheme.bodyLarge,),
                        trailing: InkWell(
                          child: const Icon(Icons.delete,color: Colors.red,),
                          onTap: (){
                            Get.defaultDialog(
                              title: AppLocalizations.of(context)!.deleteMarkedItem,
                              content:
                              Column(
                                children: [
                                  Text('${controller.allMarkedLocationEntity.value.data![index].name!} ${AppLocalizations.of(context)!.delete}'),
                                  const SizedBox(height: 16.0,),
                                  Row(
                                    children: [
                                      Expanded(child: MyButton(color: Colors.green, text: AppLocalizations.of(context)!.submit, onTap: (){
                                        controller.deleteMarkedLocation(controller.allMarkedLocationEntity.value.data![index]);
                                        Get.back();
                                      })),
                                      const SizedBox(width: 8.0,),
                                      Expanded(child: MyButton(color: Colors.red, text: AppLocalizations.of(context)!.cancel, onTap: (){
                                        Get.back();
                                      })),
                                    ],
                                  ),
                                ],
                              ),

                            );
                            print(controller.allMarkedLocationEntity.value.data![index].name);
                          },),
                        onTap:(){
                          setState(() {
                            isExpand = false;
                          });
                          controller.goToLocation(GeoPoint(latitude: controller.allMarkedLocationEntity.value.data![index].latitude!, longitude: controller.allMarkedLocationEntity.value.data![index].longitude!));
                        },
                      );
                    }),
              ),
            )
          ],
        ),
      ));
  }
}
