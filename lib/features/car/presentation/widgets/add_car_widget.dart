import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahnegar/common/model/production_year_model.dart';
import 'package:rahnegar/common/widgets/spacer_with_message_widget.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/presentation/widgets/production_year_bottom_sheet.dart';

import '../../../../common/utils/constants.dart';
import '../../../../common/widgets/my_button.dart';
import '../../../../common/widgets/my_text_form_field.dart';
import '../../../../theme/app_themes.dart';
import '../../domain/entity/brand_data_entity.dart';
import '../manager/getx/pages/add_car/widgets/serial_item_widget.dart';

class AddCarWidget extends StatefulWidget {
  AddCarWidget(
      {super.key,
      required this.onBrandTap,
      required this.onModelTap,
      required this.onSubmit,
      required this.onAddDeviceTap,
      this.selectedModelEntity,
      this.selectedBrandEntity,
      this.onProductionYearSelect,
      this.serialNumber,
      this.car});
  Function onBrandTap;
  Function onModelTap;
  Function onAddDeviceTap;
  Function(String, String) onSubmit;
  String? serialNumber;
  BrandDataEntity? selectedModelEntity = BrandDataEntity();
  BrandDataEntity? selectedBrandEntity = BrandDataEntity();
  Function(ProductionYearModel)? onProductionYearSelect;
  CarModel? car;

  @override
  State<AddCarWidget> createState() => _AddCarWidgetState();
}

class _AddCarWidgetState extends State<AddCarWidget> {
  final TextEditingController _carNameController = TextEditingController();
  final TextEditingController _deviceController = TextEditingController();
  String productionYearStr = ' ';
  bool addCarValidation = false;
  ProductionYearModel? productionYear;
  String deviceSerial = ' ';

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.carDetails,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body:
      Column(
        children: [
          const SizedBox(height: 16.0,),
          Expanded(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust padding for the keyboard
                ),
                child:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    TextFormField(
                      controller: _carNameController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      showCursor: false,
                      textInputAction: TextInputAction.done,
                      decoration: MyTextFormField(
                          labelText: AppLocalizations.of(context)!.alias,
                          context: context,
                          borderColor: Colors.transparent,
                          fillColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.grey.shade100
                              : appBarDarkColor!,
                          textColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.black
                              : Colors.white70)
                          .decoration(),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    MyButton(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade100
                          : appBarDarkColor!,
                      text: AppLocalizations.of(context)!.brand,
                      text2: widget.selectedBrandEntity!.nameFa ?? ' ',
                      textColor2: Theme.of(context).brightness == Brightness.light
                          ? Colors.blueGrey
                          : Colors.white70,
                      onTap: () {
                        widget.onBrandTap();
                      },
                      textColor: Colors.black,
                    ),
                    SpacerWithMessageWidget(
                        fontSize: 12.sp,
                        height: 30,
                        showMessage: addCarValidation &&
                            widget.selectedBrandEntity!.nameFa == ' ',
                        message: AppLocalizations.of(context)!.selectBrand),
                    MyButton(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade100
                          : appBarDarkColor!,
                      text: AppLocalizations.of(context)!.model,
                      text2: widget.selectedModelEntity!.nameFa!,
                      textColor2: Theme.of(context).brightness == Brightness.light
                          ? Colors.blueGrey
                          : Colors.white70,
                      onTap: () {
                        if (widget.selectedBrandEntity!.nameFa! == ' ') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                              Text(AppLocalizations.of(context)!.selectBrand)));
                        } else {
                          widget.onModelTap();
                        }
                      },
                      textColor: Colors.black,
                    ),
                    SpacerWithMessageWidget(
                        fontSize: 12.sp,
                        height: 30,
                        showMessage: addCarValidation &&
                            widget.selectedModelEntity!.nameFa! == ' ',
                        message: AppLocalizations.of(context)!.selectModel),
                    MyButton(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade100
                          : appBarDarkColor!,
                      text: AppLocalizations.of(context)!.productionYear,
                      text2: productionYearStr,
                      textColor2: Theme.of(context).brightness == Brightness.light
                          ? Colors.blueGrey
                          : Colors.white70,
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return ProductionYearBottomSheet(
                                onSelect: (year) {
                                  productionYearStr =
                                  '${year.jalaliYear} - ${year.georgianYear}';
                                  setState(() {});
                                  productionYear = year;
                                  widget.onProductionYearSelect!(year);
                                },
                              );
                            });
                      },
                      textColor: Colors.black,
                    ),
                    SpacerWithMessageWidget(
                        fontSize: 12.sp,
                        height: 30,
                        showMessage: addCarValidation && productionYearStr == ' ',
                        message: AppLocalizations.of(context)!.selectYear),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () {
                              widget.onAddDeviceTap();
                            },
                            label: Text(AppLocalizations.of(context)!.addDevice),
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
                        ),
                      ],
                    ),
                    SpacerWithMessageWidget(
                        fontSize: 12.sp,
                        height: 30,
                        showMessage: addCarValidation && widget.serialNumber == null,
                        message: AppLocalizations.of(context)!.addDeviceError),
                    buildSerialNumberWidget(),

                  ]),
                )

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyButton(
                color: lightPrimaryColor,
                text: AppLocalizations.of(context)!.submit,
                onTap: () {
                  addCarValidation = true;
                  if (productionYear != null &&
                      widget.selectedModelEntity!.nameFa! != ' ') {
                    widget.onSubmit(
                        _carNameController.text, _deviceController.text);
                    Navigator.of(context).pop();
                  } else {
                    setState(() {});
                  }
                }),
          ),
        ],
      )
    );
  }

  initData() {
    if (widget.car != null) {
      if (widget.car!.modelFa != null) {
        productionYearStr = widget.car!.year.toString();
        productionYear = ProductionYearModel(
            jalaliYear: productionYearStr, georgianYear: "");
        _carNameController.text = widget.car!.nickname!;
        _deviceController.text = widget.car!.serialNumber!;
        widget.selectedBrandEntity!.nameFa != widget.car!.brand;
        widget.selectedModelEntity!.nameFa = widget.car!.modelFa;
      }
    }
  }

  Widget buildSerialNumberWidget() {
    if (widget.serialNumber != null) {
      if (widget.serialNumber!.isNotEmpty) {
        return SerialItemWidget(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade100
                : appBarDarkColor!,
            serialNumber: widget.serialNumber!,
            onDeleteTap: (serial) {
              widget.serialNumber = '';
              setState(() {});
            });
      }
    }
    return Container();
  }
}
