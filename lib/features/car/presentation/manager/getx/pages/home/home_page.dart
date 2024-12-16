import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rahnegar/common/utils/constants.dart';
import 'package:rahnegar/common/widgets/my_button.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/presentation/widgets/car_item_list_widget.dart';
import 'package:rahnegar/features/car/presentation/manager/getx/pages/home/controller/home_page_controller.dart';
import 'package:rahnegar/features/car/presentation/widgets/chart_widget.dart';
import 'package:rahnegar/theme/app_themes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../widgets/custom_switch.dart';
import '../../../../widgets/home_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({super.key}) {
    controller.loadDefaultCar();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => buildBody(context));
  }

  buildBody(context) {
    Locale currentLocale = Localizations.localeOf(context);
    if (controller.getMyCarsStatus.value.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else
      if (controller.getMyCarsStatus.value.isSuccess) {
      if (controller.myCars.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context)!.pleaseAddYourCarFromSettingsMyCars,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 400.h,
              pinned: false,
              // backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : flexibleSpaceDarkColor,
                  // padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  // color: Colors.white,
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(16.0),
                  //   border: Border.all(color: Colors.grey.shade300,width: 1.5),
                  //
                  // ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      InkWell(
                        onTap: controller.myCars.length == 1
                            ? null
                            : () {
                                showMyCarsBottomSheet(context);
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "assets/images/main/turn_off.png",
                                  height: 50,
                                ),
                              ),
                              onTap: () {
                                _showMyDialog(context);
                              },
                            ),
                            Container(
                              width: 200.w,
                              height: 40.w,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade300
                                      : appBarDarkColor,
                                  borderRadius: currentLocale.languageCode ==
                                          'fa'
                                      ? const BorderRadius.only(
                                          topRight: Radius.circular(50.0),
                                          bottomRight: Radius.circular(50.0))
                                      : const BorderRadius.only(
                                          topLeft: Radius.circular(50.0),
                                          bottomLeft: Radius.circular(50.0))),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  Expanded(
                                      child: Text(
                                    controller.selectedCar.value.nickname ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )),
                                  controller.myCars.length > 1
                                      ? IconButton(
                                          onPressed:
                                              controller.myCars.length == 1
                                                  ? null
                                                  : () {
                                                      showMyCarsBottomSheet(
                                                          context);
                                                    },
                                          icon: const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Colors.grey,
                                          ))
                                      : Container(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100.w,
                              width: 100.w,
                              child: controller.selectedCar.value.iconLink !=
                                      null
                                  ? CachedNetworkImage(
                                      imageUrl: controller
                                              .selectedCar.value.iconLink ??
                                          '',
                                      placeholder: (context, url) => SizedBox(),
                                      fit: BoxFit.scaleDown,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black87
                                          : Colors.white70,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .workHours,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                        Text('28',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .kilometersTraveled,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                        Text('2200',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .distanceToDestination,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                        Text(
                                          '140 کیلومتر',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // const SizedBox(
                      //   height: 30.0,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SizedBox(
                            //   height: 20.0,
                            //   width: Get.width / 2,
                            //   child: Stack(
                            //     children: [
                            //       Align(
                            //         alignment: Alignment.bottomCenter,
                            //         child: Image.asset(
                            //             "assets/images/main/speed.png"),
                            //       ),
                            //       Positioned(
                            //           left: 50.0,
                            //           child: Image.asset(
                            //             "assets/images/main/car.png",
                            //             color: Theme.of(context).brightness ==
                            //                     Brightness.light
                            //                 ? Colors.black87
                            //                 : Colors.white,
                            //           )),
                            //     ],
                            //   ),
                            // ),
                            Text(
                              AppLocalizations.of(context)!
                                  .allowTheVehicleToStart,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            CustomSwitch(
                                value: controller.switchValue.value,
                                onChanged: (value) {
                                  controller.switchValue.value = value;
                                  if (value) {
                                    controller.sendCommand(
                                        command: Commands.allowTurnOn,
                                        value: Values.allow_turn_on,
                                        onDone: () => Get.snackbar(
                                            "",
                                            AppLocalizations.of(context)!
                                                .theCarCanBeStarted,
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white));
                                  } else {
                                    controller.sendCommand(
                                        command: Commands.allowTurnOn,
                                        value: Values.not_allow_turn_on,
                                        onDone: () => Get.snackbar(
                                            "",
                                            AppLocalizations.of(context)!
                                                .theCarCannotBeStarted,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white));
                                  }
                                })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     controller.getBatteryStatus();
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //     child: Column(
                      //       children: [
                      //         Row(
                      //           children: [
                      //             Image.asset(
                      //               "assets/images/main/battery_pack.png",
                      //               height: 40,
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                            width: 400,
                            child: ChartWidget(
                              chartData: controller.percentData.toList(),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: 32.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: HomeButtonWidget(
                          width: Get.width / 6,
                          title: AppLocalizations.of(context)!
                              .carInternalListening,
                          child: Image.asset(
                              "assets/images/main/car_internal_listening.png"),
                        ),
                        onTap: () async {
                          const String phoneNumber = "09999999999";
                          final Uri phoneUri =
                              Uri(scheme: 'tel', path: phoneNumber);
                          if (await canLaunchUrl(phoneUri)) {
                            await launchUrl(phoneUri);
                          } else {
                            throw 'Could not launch $phoneUri';
                          }
                        },
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 6,
                        title: AppLocalizations.of(context)!.carPowerCut,
                        child:
                            Image.asset("assets/images/main/car_power_cut.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 6,
                        title: AppLocalizations.of(context)!.stopTheCar,
                        child: Image.asset("assets/images/main/stop_car.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 6,
                        title:
                            AppLocalizations.of(context)!.turnTheLightsOnAndOff,
                        child: Image.asset(
                          "assets/images/main/car_on_off.png",
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (commandStatus[Commands.doorVehicleStatus] ==
                                  Values.open_door_vehicle ||
                              commandStatus[Commands.doorVehicleStatus] ==
                                  Values.none) {
                            controller.sendCommand(
                                command: Commands.doorVehicleStatus,
                                value: Values.close_door_vehicle,
                                onDone: () => Get.snackbar(
                                    "",
                                    AppLocalizations.of(context)!
                                        .theCarDoorClosed,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white));
                          } else if (commandStatus[
                                      Commands.doorVehicleStatus] ==
                                  Values.close_door_vehicle ||
                              commandStatus[Commands.doorVehicleStatus] ==
                                  Values.none) {
                            controller.sendCommand(
                                command: Commands.doorVehicleStatus,
                                value: Values.open_door_vehicle,
                                onDone: () => Get.snackbar(
                                    "",
                                    AppLocalizations.of(context)!
                                        .theCarDoorOpened,
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white));
                          }
                        },
                        child: HomeButtonWidget(
                          width: Get.width / 6,
                          title: AppLocalizations.of(context)!
                              .openingAndClosingTheCarDoor,
                          child: Image.asset(
                            "assets/images/main/car_door.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title: AppLocalizations.of(context)!.impactWarning,
                        child: Image.asset(
                            "assets/images/main/impact_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title: AppLocalizations.of(context)!.motionWarning,
                        child: Image.asset(
                            "assets/images/main/motion_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title:
                            AppLocalizations.of(context)!.switchOpeningWarning,
                        child: Image.asset(
                            "assets/images/main/switch_opening_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title: AppLocalizations.of(context)!.carIgnitionWarning,
                        child: Image.asset(
                            "assets/images/main/car_ignition_warning.png"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title: AppLocalizations.of(context)!.lowBatteryWarning,
                        child: Image.asset(
                            "assets/images/main/low_battery_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title:
                            AppLocalizations.of(context)!.batteryTheftWarning,
                        child: Image.asset(
                            "assets/images/main/battery_theft_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title: AppLocalizations.of(context)!
                            .disconnectingTheDeviceWarning,
                        child: Image.asset(
                            "assets/images/main/disconnecting_the_device_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title:
                            AppLocalizations.of(context)!.gpsBlindSpotWarning,
                        child: Image.asset(
                            "assets/images/main/gps_blind_spot_warning.png"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title: AppLocalizations.of(context)!.oilChangeWarning,
                        child: Image.asset(
                            "assets/images/main/oil_change_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title: AppLocalizations.of(context)!
                            .externalPowerFailureWarning,
                        child: Image.asset(
                            "assets/images/main/external_power_failure_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title: AppLocalizations.of(context)!.sosAlert,
                        child: Image.asset("assets/images/main/sos_alert.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title: AppLocalizations.of(context)!.speedWarning,
                        child:
                            Image.asset("assets/images/main/speed_warning.png"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title: AppLocalizations.of(context)!.lowFuelWarning,
                        child: Image.asset(
                            "assets/images/main/low_fuel_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title: AppLocalizations.of(context)!
                            .sparkPlugReplacementWarning,
                        child: Image.asset(
                            "assets/images/main/spark_plug_replacement_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title:
                            AppLocalizations.of(context)!.padReplacementWarning,
                        child: Image.asset(
                            "assets/images/main/pad_replacement_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: Get.width / 5,
                        title: AppLocalizations.of(context)!
                            .bluetoothDisconnectionWarning,
                        child: Image.asset(
                            "assets/images/main/bluetooth_disconnection_warning.png"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 64.0,
                  ),
                ],
              ),
            )
          ],
        );
      }
    }
      else if(controller.getMyCarsStatus.value.isError){
        return IconButton(onPressed: (){
          controller.getMyCars();
          controller.loadDefaultCar();
          controller.getBatteryStatus();
        }, icon: const Icon(Icons.refresh));
      }
  }

  showMyCarsBottomSheet(context) {
    controller.getMyCars(isBottomSheet: true);
    Get.bottomSheet(Obx(() => controller.getMyCarsBottomSheetStatus.value.isLoading
        ? const LinearProgressIndicator()
        : controller.getMyCarsBottomSheetStatus.value.isSuccess
            ? Container(
                // color: Colors.white,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : appBarDarkColor,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: 0.5,
                    color: Colors.grey.shade100,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(() => Animate(
                        effects: const [FadeEffect()],
                        delay: Duration(milliseconds: 100 * index),
                        child: SizedBox(
                          height: 100,
                          child: CarItemListWidget(
                            car: controller.myCars[index],
                            onTap: (car) {
                              controller
                                  .saveDefaultCar(CarModel.fromCarEntity(car));
                              controller.selectedCar.value = car;
                              Future.delayed(Duration(milliseconds: 500))
                                  .then((onValue) {
                                Get.back();
                              });
                            },
                            selectedCar: controller.selectedCar.value,
                          ),
                        )));
                  },
                  itemCount: controller.myCars.length,
                ),
              )
            : Container()));
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // User must tap button for close
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('Dialog Title'),
          content: Text(
            AppLocalizations.of(context)!.turnOffTheCar,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(AppLocalizations.of(context)!.no),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.yes),
                  onPressed: () {
                    // Handle your action here
                    String title =
                        AppLocalizations.of(context)!.theCarTurnedOff;
                    Future.delayed(const Duration(milliseconds: 500))
                        .then((onValue) {
                      controller.sendCommand(
                          command: Commands.turnOffVehicle,
                          value: Values.turn_off_vehicle,
                          onDone: () => Get.snackbar("", title,
                              backgroundColor: Colors.red,
                              colorText: Colors.white));
                    });

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
