import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rahnegar/common/model/production_year_model.dart';
import 'package:rahnegar/common/utils/constants.dart';
import 'package:rahnegar/common/widgets/background_widget.dart';
import 'package:rahnegar/common/widgets/custom_button.dart';
import 'package:rahnegar/common/widgets/dismissible_widget.dart';
import 'package:rahnegar/common/widgets/searchable_list_widget.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/domain/entity/brand_data_entity.dart';
import 'package:rahnegar/features/car/presentation/manager/getx/pages/add_car/widgets/serial_item_widget.dart';
import 'package:rahnegar/features/car/presentation/widgets/qr_code_scanner_widget.dart';
import '../../../../../../../common/widgets/my_text_form_field.dart';
import '../../../../../../../routes/route_names.dart';
import '../../../../../../../theme/app_themes.dart';
import '../../../../widgets/add_car_widget.dart';
import '../../../../widgets/remove_car_bottom_sheet.dart';
import 'controller/add_car_page_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCarPage extends StatefulWidget {
  AddCarPage({super.key,this.isSetting=false}){
    if(Get.arguments!=null){
      final Map<String, dynamic> arguments = Get.arguments;
      isSetting = arguments["isSetting"] ?? false;
    }
  }
  bool isSetting;

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final TextEditingController _carNameController = TextEditingController();
  final TextEditingController _serialController = TextEditingController();
  final controller = Get.find<AddCarPageController>();
  bool cancelDelete = false;

  int carLength = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.myCars,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
          ),
          body:
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () {
                                showBottomSheet(CarModel());
                              },
                              label: Text(AppLocalizations.of(context)!.addCar),
                              icon: const Icon(
                                Icons.add_circle_outline,
                                size: 25.0,
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      textButtonBorderRadius), // Adjust border radius as needed
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Expanded(
                        child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors
                                  .transparent, // Set your background color here
                            ),
                            child: Obx(
                              () =>
                              controller.getMyCarsStatus.value.isLoading?
                                  const Center(child: CircularProgressIndicator()):
                                  ReorderableListView.builder(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final cars = controller.myCarsEntity.value.data;
                                    return

                                      Animate(
                                        key: ValueKey(cars![index]),
                                        effects: const [FadeEffect()],
                                        delay: Duration(milliseconds: 250*index),
                                        child:
                                        DismissibleWidget(
                                        car: cars[index],
                                        onTap: (car){
                                          showBottomSheet(CarModel.fromCarEntity(car));
                                        },
                                        isFirst: index == 0 &&
                                            cars.length > 1,
                                        onDeleteTap: (car) async {
                                          cancelDelete = false;
                                          bool result =
                                              await removeCarBottomSheet();
                                          controller.selectedIndex = cars.indexOf(car);
                                          if (result) {
                                            controller.deleteCar(
                                                cars[index]);
                                          } else {
                                            setState(() {
                                              cancelDelete = true;
                                            });
                                            Future.delayed(
                                                    Duration(milliseconds: 100))
                                                .then((onValue) {
                                              cancelDelete = false;
                                            });
                                          }
                                        },
                                        cancelDelete: cancelDelete,
                                        index : index,
                                        selectedIndex: controller.selectedIndex,
                                                                            ),
                                      );
                                  },
                                  itemCount: controller.myCarsEntity.value.data!.length,
                                  onReorder: (int oldIndex, int newIndex) {
                                    if (newIndex > oldIndex) {
                                      newIndex -= 1;
                                    }
                                    final item =
                                    controller.myCarsEntity.value.data!.removeAt(oldIndex);
                                    controller.myCarsEntity.value.data!.insert(newIndex, item);
                                    controller.saveDefaultCar(CarModel.fromCarEntity(item));
                                  }),
                            )),
                      ),
                      const SizedBox(
                        height: 60.0,
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => controller.myCarsEntity.value.data!.isNotEmpty
                  ?
              Animate(
                effects: [FadeEffect()],
                delay: Duration(milliseconds: 250* controller.myCarsEntity.value.data!.length),
                child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              widget.isSetting?
                              Container():
                              TextButton.icon(
                                onPressed: () {
                                    Get.offAllNamed(RouteNames.mainPage);
                                },
                                label: Text((AppLocalizations.of(context)!.next)),
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  size: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              )
                  : Container())
            ],
          )),
    );
  }

  showBottomSheet(CarModel car) {
    _carNameController.clear();
    clearData();
    // if(car.modelFa != null) {
    //   if (car.modelFa!.isNotEmpty) {
    //     car.modelFa = controller.brandEntity.value.data!
    //         .firstWhere((str) => str.nameFa!.contains(car.brand!))
    //         .nameFa;
    //   }
    // }
    if(car.serialNumber!=null){
      controller.serialNumber = car.serialNumber!;
      controller.productionYear = ProductionYearModel(jalaliYear: car.year.toString(), georgianYear: '');
      controller.selectedProductionYear = controller.productionYear;
      controller.getBrands();
      controller.selectedModelEntity.id = car.modelId;
    }
    Get.bottomSheet(
        isScrollControlled: true,
        ignoreSafeArea: false,
        StatefulBuilder(
          builder:(BuildContext context, StateSetter setState){
            return
              AddCarWidget(
                car: car,
                onBrandTap: () {
                  controller.getBrands();
                  Get.bottomSheet(
                    Obx(()=>
                    controller.getBrandsStatus.value.isLoading?
                        const LinearProgressIndicator():
                        controller.getBrandsStatus.value.isSuccess?
                    SearchableListWidget<BrandDataEntity>(
                        items: controller.brandEntity.value.data??[],
                        onSelect: (brand){
                          controller.selectedBrandEntity = brand;
                          controller.selectedModelEntity.nameFa = ' ';
                          setState((){});
                        },
                      itemToString:(item)=>item.nameFa!,
                    ):Container()
                    )
                  );
                },
                onSubmit: (carName,serial) {
                  String alias = '${AppLocalizations.of(context)!.car} ${controller.myCarsEntity.value.data!.length + 1}';
                  if(carName.isNotEmpty){
                    alias = carName;
                  }
                  CarModel carObj = CarModel(
                      nickname: alias,
                      year: int.parse(controller.selectedProductionYear!.jalaliYear),
                      modelFa: controller.selectedModelEntity.nameFa,
                    serialNumber: controller.serialNumber,
                    model: controller.selectedModelEntity.id,
                      id: car.serialNumber!=null?car.id:null
                  );
                  if(car.serialNumber==null) {
                    controller.addCar(carObj);
                  }else{
                    controller.updateCar(carObj);
                  }

                },
                selectedBrandEntity: controller.selectedBrandEntity,
                selectedModelEntity: controller.selectedModelEntity,
                onModelTap: () {
                  controller.getBrands(id: controller.selectedBrandEntity.id.toString());
                  Get.bottomSheet(
                      Obx(()=>
                      controller.getBrandsStatus.value.isLoading?
                      const LinearProgressIndicator():
                      controller.getBrandsStatus.value.isSuccess?
                          SearchableListWidget<BrandDataEntity>(
                            items: controller.brandEntity.value.data??[],
                            onSelect: (brand){
                              controller.selectedModelEntity = brand;
                              setState((){});
                            },
                            itemToString:(item)=>item.nameFa!,
                          ):Container()
                      )
                  );
                  // Get.bottomSheet(
                  //     Obx(()=>BrandBottomSheet(
                  //       state: MyState(
                  //           isSuccess: controller.getBrandsStatus.value.isSuccess,
                  //           isFailure: controller.getBrandsStatus.value.isError,
                  //           isLoading: controller.getBrandsStatus.value.isLoading,
                  //           failure: controller.failure),
                  //       list: controller.brandEntity.value.data??[],
                  //       onSelect: (brand) {
                  //         controller.selectedModelEntity = brand;
                  //         setState((){});
                  //       },
                  //       onFailure: (failure){
                  //         Get.back();
                  //         failureAction(failure,context);
                  //       },
                  //     ))
                  // );
                },
                onProductionYearSelect: (year){
                  if(year.jalaliYear.contains(AppLocalizations.of(context)!.before) || year.georgianYear.contains(AppLocalizations.of(context)!.before)){
                    year.jalaliYear = "1366";
                    year.georgianYear = "1987";
                  }
                  controller.selectedProductionYear = year;
                },

                onAddDeviceTap: (){
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true, // User must tap a button to close the dialog
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content:
                        SizedBox(
                          height: 200,
                          child: Column(children: [
                            TextFormField(
                              controller: _serialController,
                              style: Theme.of(context).textTheme.bodyMedium,
                              showCursor: false,
                              textInputAction: TextInputAction.done,
                              decoration: MyTextFormField(
                                  labelText: AppLocalizations.of(context)!.serialNumber,
                                  context: context,
                                  borderColor: Colors.transparent,
                                  fillColor: Theme.of(context).brightness == Brightness.light? Colors.grey.shade100:appBarDarkColor!,
                                  textColor: Theme.of(context).brightness == Brightness.light?Colors.black:Colors.white70
                              ).decoration(),
                            ),
                            SizedBox(height: 30.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              CustomButton(borderRadius:20.0,color: Colors.green, onTap: ()async{
                                controller.serialNumber=_serialController.text;
                                setState((){});
                                Future.delayed(Duration(milliseconds: 100)).then((onValue){
                                  Navigator.of(context).pop();
                                });
                              },width: 100,height: 100,image: Icon(Icons.add,size: 70,color: Colors.white,),),
                              CustomButton(borderRadius:20.0,color: lightPrimaryColor, onTap: (){
                                Get.to(()=>QrCodeScannerWidget(
                                  onDetect: (barCode){
                                    controller.serialNumber=barCode;
                                    Navigator.of(context).pop();
                                    setState((){});
                                  },
                                ));
                              },width: 100,height: 100,image: Icon(Icons.qr_code_2_sharp,size: 70,color: Colors.white),),
                            ],)
                          ],),
                        ),
                      );
                    },
                  );

                },
                serialNumber:controller.serialNumber
              );
          },
        ));
  }

  Future<bool> removeCarBottomSheet() async {
    bool result = await Get.bottomSheet(
        isDismissible: false,
       RemoveCarBottomSheet(
         onNoTap: ()=>Get.back(result: false),
         onYesTap: ()=>Get.back(result: true),
       )
        );
    print(result);
    return result;
  }
  clearData() {
    controller.selectedModelEntity = BrandDataEntity();
    controller.selectedBrandEntity = BrandDataEntity();
    controller.selectedProductionYear = null;
    controller.serialNumber='';
  }
}



