import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:rahnegar/features/car/presentation/widgets/car_item_list_widget.dart';
import 'package:rahnegar/features/map/presentation/manager/GetX/page/map_page/controller/osm_map_controller.dart';
import 'package:rahnegar/features/map/presentation/manager/GetX/page/map_page/widgets/marked_locations_widget.dart';

import '../../../../../../../../common/widgets/my_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../../theme/app_themes.dart';

class OsmWidget extends GetView<OsmMapController> {
  OsmWidget({super.key,required int selectedIndex}){
    // controller.getMyCars();
    if(selectedIndex !=0){
      controller.pauseTimer();
    }else{
      controller.loadDefaultCar();
      controller.resumeTimer();
      controller.showMarkedLocations();
    }

  }

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: [

          OSMFlutter(

            onLocationChanged: (GeoPoint position) {
              print('Location changed: ${position.latitude}, ${position.longitude}');
            },
            controller:controller.mapController,
            mapIsLoading: const Center(child: CircularProgressIndicator()),
            osmOption: const OSMOption(
              zoomOption: ZoomOption(
                initZoom: 12,
                minZoomLevel: 9,
                maxZoomLevel: 19,
                stepZoom: 1.0,
              ),

              // userLocationMarker: UserLocationMaker(
              //   personMarker: const MarkerIcon(
              //     icon: Icon(
              //       Icons.circle,
              //       color: Colors.blue,
              //       size: 40,
              //     ),
              //   ),
              //   directionArrowMarker: const MarkerIcon(
              //     icon: Icon(
              //       Icons.double_arrow,
              //       size: 48,
              //     ),
              //   ),
              // ),
              roadConfiguration: RoadOption(
                roadColor: Colors.purple,
                roadWidth: 10
              ),
            ),
          ),
          Obx(()=>
              Align(
            alignment: Alignment.topCenter,
            child: Column(children: [

              Padding(
                padding: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0),
                child:
                TextFormField(
                  controller: controller.searchController,
                  onChanged: (text){
                    controller.searchCityByName(text);
                    if(text.isEmpty){
                      controller.showClearIcon.value = false;
                    }
                    else{
                      controller.showClearIcon.value = true;
                    }
                  },
                  onFieldSubmitted: (text){
                    controller.searchCityByName(text);
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
                                  controller.showClearIcon.value = false;
                                  controller.isExpanded.value = false;
                                  controller.searchController.clear();
                                  Get.focusScope!.unfocus();
                                },
                              ):Container(),
                            ),
                            Expanded(
                              child: InkWell(
                                  child: Icon(Icons.search,color: Theme.of(context).textTheme.bodyLarge!.color!,),
                                onTap: (){
                                  controller.searchCityByName(controller.searchController.text);
                                  Get.focusScope!.unfocus();
                                },
                              ),
                            ),
                            SizedBox(width: 8.0,)
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FloatingActionButton(
                          heroTag: 'tag2',
                          onPressed: (){

                            controller.goToLocation(GeoPoint(latitude: controller.location.value.latitude!, longitude: controller.location.value.longitude!));
                          },child: Icon(Icons.gps_fixed, size: 20,color: Colors.black54,),
                          mini: true,
                          backgroundColor: Colors.white70,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FloatingActionButton(
                          heroTag: 'tag1',
                          onPressed: (){

                            showMyCarsBottomSheet(context);
                          },
                          mini: true,
                          backgroundColor: Colors.white70,child: const Icon(Icons.car_crash_outlined, size: 20,color: Colors.black54),
                        ),
                      ),
                    ],
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
                          return ListTile(
                            onTap: (){
                              controller.onListTileTap(controller.searchResults[index],'${controller.searchResults[index].address!.name!} , ${getSubtitle(controller.searchResults[index].address!.state??'', controller.searchResults[index].address!.country??'')}');
                            },
                            title: Text(controller.searchResults[index].address!.name!,style: Theme.of(context).textTheme.bodyLarge!,),
                            subtitle: Text(getSubtitle(controller.searchResults[index].address!.state??'', controller.searchResults[index].address!.country??''),style: Theme.of(context).textTheme.bodySmall!,),
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
                            margin: EdgeInsets.symmetric(horizontal: 8.5,vertical: 1),
                            height: 30,
                            color:Theme.of(context).brightness == Brightness.light? Colors.white70:Colors.black26,
                            // color: Colors.red,
                            child: Center(child: Text(AppLocalizations.of(context)!.noItemFound,style: Theme.of(context).textTheme.bodyLarge)),
                          ):Container(),
                ],
              ),

            ],),
          ),),
          Obx(()=>Align(
            alignment: Alignment.bottomCenter,
            child:
            controller.showMarkedLocationsWidget.value?
            const MarkedLocationsWidget():Container(),
          ))

          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: FloatingActionButton(
          //     child: Icon(Icons.add),
          //     onPressed: (){
          //       controller.getAllMarkedLocations();
          //       // controller.addMarker(controller.allMarkedLocationEntity.value.data![i]);
          //       // i++;
          //     },
          //   ),
          // )
          // Align(
          //   alignment: Alignment.topRight,
          //     child: SizedBox(
          //       height: 70,
          //         width: 70,
          //         child: NorthIndicator(rotation: null,))),
          // const Row(
          //   children: [
          //     Icon(Icons.car_crash_outlined),
          //     Icon(Icons.directions_bike),
          //     Icon(Icons.square_foot),
          //   ],
          // ),
        ],
      );
  }

  String getSubtitle(String state,String country){
    if(state.isEmpty && country.isEmpty){
      return '';
    }else if(state.isEmpty && country.isNotEmpty){
      return country;
    }else if(state.isNotEmpty && country.isNotEmpty){
      return '$state , $country';
    }else if(state.isNotEmpty && country.isEmpty){
      return state;
    }
    return '';
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
                    effects: [FadeEffect()],
                    delay: Duration(milliseconds: 100*index),
                    child: SizedBox(
                      height: 100,
                      child: CarItemListWidget(car: controller.myCars[index],onTap: (car){
                        controller.selectedCar.value = car;
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

class NorthIndicator extends StatelessWidget {
  final double rotation;

  NorthIndicator({required this.rotation});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -rotation * (3.141592653589793 / 180.0), // Convert degrees to radians
      child: Icon(
        Icons.arrow_upward,
        size: 50.0,
        color: Colors.blue,
      ),
    );
  }
}


