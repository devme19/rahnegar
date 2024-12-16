import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:rahnegar/common/widgets/my_text_form_field.dart';
import 'package:rahnegar/features/car/presentation/widgets/car_item_list_widget.dart';
import 'package:rahnegar/features/map/presentation/manager/GetX/page/map_page/controller/neshan_map_controller.dart';
import 'package:rahnegar/native/native_bridge.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rahnegar/theme/app_themes.dart';

class NeshanMapWidget extends GetView<NeshanMapController> {
  NeshanMapWidget({super.key,required int selectedIndex}){
    // controller.getMyCars();
    if(selectedIndex !=0){
      controller.pauseTimer();
    }else{
      controller.loadDefaultCar();
      controller.resumeTimer();
      controller.getMyCars();
      // controller.showMarkedLocations();
    }

  }
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      Stack(

        children: [

          AndroidView(
            viewType: 'native_map_view',
            onPlatformViewCreated: (int id) {
              NativeBridge().createChannel(id);
            },
          ),
          Positioned(
           bottom: 0,
            left: 0,
            child: Container(
              width: 100,
              height: 45,
              color: Colors.transparent,
            ),
          ),
          Obx(()=>Align(
            alignment: Alignment.topCenter,
            child: Column(children: [

              Padding(
                padding: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0),
                child:
                TextFormField(
                  controller: searchController,
                  onChanged: (text){
                    // controller.search(text);
                    // if(text.isEmpty){
                    //   controller.showClearIcon.value = false;
                    // }
                    // else{
                    //   controller.showClearIcon.value = true;
                    // }
                  },
                  onFieldSubmitted: (text){
                    controller.search(text);
                  },
                  decoration:  MyTextFormField(
                      labelText: AppLocalizations.of(context)!.search,
                      context: context,
                      borderColor: Colors.transparent,
                      suffixIcon: Container(
                        padding: const EdgeInsets.only(left: 16.0),
                        // color: Colors.blue,
                        width: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: controller.showClearIcon.value?InkWell(
                                child: const Icon(Icons.close,color: Colors.red,),
                                onTap: (){
                                  searchController.clear();
                                  controller.clearSearch();
                                },
                              ):Container(),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Icon(Icons.search,color: Theme.of(context).textTheme.bodyLarge!.color!,),
                                onTap: (){
                                  controller.search(searchController.text);
                                  Get.focusScope!.unfocus();
                                },
                              ),
                            ),
                            const SizedBox(width: 8.0,)
                          ],
                        ),
                      ),
                      fillColor: Theme.of(context).brightness == Brightness.light? Colors.white70:Colors.black26,
                      textColor: Theme.of(context).textTheme.bodyLarge!.color!
                  ).decoration(),
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          heroTag: 'tag2',
                          onPressed: (){
                            controller.goToLocation();
                            // controller.goToLocation(GeoPoint(latitude: controller.location.value.latitude!, longitude: controller.location.value.longitude!));
                          },
                          mini: true,
                          backgroundColor: Colors.white70,child: const Icon(Icons.gps_fixed, size: 20,color: Colors.black54,),
                        ),
                        InkWell(
                          onTap: (){
                            if(controller.myCarsLength.value>1){
                              showMyCarsBottomSheet(context);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.only(top: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Theme.of(context).brightness == Brightness.light? Colors.white70:Colors.black26,
                            ),
                            child: Text(controller.selectedCar.value.nickname??'',style: Theme.of(context).textTheme.bodySmall,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  controller.searchByNameStatus.value.isLoading?
                  Container(
                    height: 2.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const LinearProgressIndicator(borderRadius: BorderRadius.all(Radius.circular(45)),),
                  ):
                  controller.searchByNameStatus.value.isSuccess?
                  controller.searchResults.isNotEmpty?
                  AnimatedContainer(
                    height: controller.isExpanded.value?MediaQuery.of(context).size.height/3:0,
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).brightness==Brightness.dark?Colors.black26:Colors.white70,
                    ),
                    child: ListView.separated(
                        itemBuilder: (BuildContext context,int index){
                          final item = controller.searchResults[index];
                          return ListTile(
                            onTap: (){
                              final location = controller.searchResults[index].location;
                              controller.onSearchListTileTap(latitude: location.latitude,longitude: location.longitude);
                            },
                            title: Text(item.title,style: Theme.of(context).textTheme.bodyLarge!,),
                            subtitle: Text(item.address,style: Theme.of(context).textTheme.bodySmall!,),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Theme.of(context).brightness==Brightness.dark?Colors.black12:Colors.grey.shade300,
                            thickness: 1.0,
                          );
                        },
                        itemCount: controller.searchResults.length
                    ),
                  ):Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.5,vertical: 1),
                    height: 30,
                    color:Theme.of(context).brightness == Brightness.light? Colors.white70:Colors.black26,
                    // color: Colors.red,
                    child: Center(child: Text(AppLocalizations.of(context)!.noItemFound,style: Theme.of(context).textTheme.bodyLarge)),
                  ):Container(),
                ],
              ),

            ],),
          ),)
        ],
      );
  }
  showMyCarsBottomSheet(context){
    controller.getMyCars();
    Get.bottomSheet(
        Obx(()=>
        controller.getMyCarsStatus.value.isLoading?
        const LinearProgressIndicator():
        controller.getMyCarsStatus.value.isSuccess?
        controller.myCars.isEmpty?
        Container(
          height: 70,
          color:Theme.of(context).brightness==Brightness.dark?Colors.black54:Colors.white.withOpacity(0.65),
          // color: Colors.red,
          child: Center(child: Text(AppLocalizations.of(context)!.noItemFound,style: Theme.of(context).textTheme.bodyLarge)),
        ):
        Container(
          // color: Colors.white,
          color: Theme.of(context).brightness == Brightness.light?Colors.white:appBarDarkColor,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(height: 0.5,color: Colors.grey.shade100,),
            itemBuilder:
                (BuildContext context, int index) {
              return
                Obx(()=>Animate(
                    effects: const [FadeEffect()],
                    delay: Duration(milliseconds: 100*index),
                    child: SizedBox(
                      height: 100,
                      child: CarItemListWidget(car: controller.myCars[index],onTap: (car){
                        controller.selectedCar.value = car;
                        controller.saveDefaultCar();
                        Future.delayed(const Duration(milliseconds: 500)).then((onValue){
                          Get.back();
                        });
                      },selectedCar: controller.selectedCar.value,),
                    )
                ));
            },
            itemCount: controller.myCars.length,
          ),
        ):Container()
        )
    );
  }
}
