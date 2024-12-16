import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:rahnegar/common/widgets/keep_alive_widget.dart';
import 'package:rahnegar/features/map/presentation/manager/GetX/page/route_history_page/controller/route_history_page_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rahnegar/features/map/presentation/manager/GetX/page/route_history_page/widgets/date_time_picker_widget.dart';
import 'package:rahnegar/native/native_bridge.dart';

import '../../../../../../../theme/app_themes.dart';
import '../../../../../../car/presentation/widgets/car_item_list_widget.dart';

class RouteHistoryPage extends GetView<RouteHistoryPageController> {
  RouteHistoryPage({super.key}){
    controller.getMyCars();
    controller.loadDefaultCar();
  }

  @override
  Widget build(BuildContext context) {
    return
      Obx(()=>Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.historyOfRoutes,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
          actions: [

            InkWell(
              onTap: (){
                showMyCarsBottomSheet(context);
              },
            child: Text(controller.carName.value,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
          ),
            const SizedBox(width: 16.0,),
          ]
        ),
        body:

        Stack(
          children: [
            KeepAliveWidget(
              child: AndroidView(
                viewType: 'native_map_view',
                onPlatformViewCreated: (int id) {
                  NativeBridge().createChannel(id);
                },
              ),
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
            Align(
              alignment: Alignment.topCenter,
              child: DateTimePickerWidget(onSubmit: (startDate,endDate) {
                print("Start Date: $startDate");
                print("End Date: $endDate");
                Map<String,dynamic> body={
                  'device_sn':controller.selectedCar.value.serialNumber,
                  'start':startDate,
                  'end':endDate,
                  'type':'jalali'
                };
                controller.getRoutesHistory(body);
              },),
            )
          ],
        ),
      ));
  }

  showMyCarsBottomSheet(context){
    controller.getMyCars();

    Get.bottomSheet(
        Obx(()=>
        controller.getMyCarsStatus.value.isLoading?
        const LinearProgressIndicator():
        controller.getMyCarsStatus.value.isSuccess?
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
                      child: CarItemListWidget(car: controller.myCars[index],
                        onTap: (car){
                        controller.selectedCar.value = car;
                        controller.carName.value = controller.getCarName(context);
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
