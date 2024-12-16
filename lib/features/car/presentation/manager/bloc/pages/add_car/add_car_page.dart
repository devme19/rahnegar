import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rahnegar/common/model/production_year_model.dart';
import 'package:rahnegar/common/utils/constants.dart';
import 'package:rahnegar/common/utils/failure_action.dart';
import 'package:rahnegar/common/utils/get_failure_description.dart';
import 'package:rahnegar/common/widgets/custom_button.dart';
import 'package:rahnegar/common/widgets/dismissible_widget.dart';
import 'package:rahnegar/common/widgets/failure_widget.dart';
import 'package:rahnegar/common/widgets/my_text_form_field.dart';
import 'package:rahnegar/common/widgets/searchable_list_widget.dart';
import 'package:rahnegar/features/car/data/model/brand_data_model.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/domain/entity/brand_data_entity.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/blocs/car/car_bloc.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/blocs/get_brands_cubit/get_brands_cubit.dart';
import 'package:rahnegar/features/car/presentation/widgets/add_car_widget.dart';
import 'package:rahnegar/features/car/presentation/widgets/qr_code_scanner_widget.dart';
import 'package:rahnegar/features/car/presentation/widgets/remove_car_bottom_sheet.dart';
import 'package:rahnegar/locator.dart';
import 'package:rahnegar/theme/app_themes.dart';

class AddCarPage extends StatefulWidget {
  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final TextEditingController _carNameController = TextEditingController();

  final TextEditingController _serialController = TextEditingController();
  late CarBloc carBloc ;
  bool cancelDelete = false;

  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    carBloc = BlocProvider.of<CarBloc>(context);
    carBloc.add(LoadMyCarsEvent());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightPrimaryColor,
        title: Text(AppLocalizations.of(context)!.myCars,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!.copyWith(color: Colors.white)),
        // iconTheme: IconThemeData(
        //   color: lightPrimaryColor, // Change back button color
        // ),
      ),
      body:
      BlocConsumer<CarBloc, CarState>(
        buildWhen: (previous, current) {
          return current is CarUpdated;
        },
        builder: (context, state) {
          if (state is CarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CarUpdated) {
            final cars = state.cars;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Add Car Button
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {
                            showBottomSheet(
                                car: CarModel(), context: context);
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
                  cars.isEmpty?
                  Expanded(child: Center(child: Text(AppLocalizations.of(context)!.noItemFound),)):
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16.0,
                        ),
                        Expanded(
                          child: ReorderableListView.builder(
                            itemCount: cars.length,
                            itemBuilder: (context, index) {
                              final car = cars[index];
                              return Animate(
                                key: ValueKey(car),
                                effects: const [FadeEffect()],
                                delay: Duration(milliseconds: 250 * index),
                                child: DismissibleWidget(
                                  car: cars[index],
                                  onTap: (car) {
                                    showBottomSheet(car: car, context: context);
                                  },
                                  isFirst: index == 0 && cars.length > 1,
                                  onDeleteTap: (car) async {
                                    cancelDelete = false;
                                    bool result =
                                        await removeCarBottomSheet(context);
                                    selectedIndex = cars.indexOf(car);
                                    if (result) {
                                      carBloc.add(DeleteCarEvent(car));
                                      // carBloc.add(DeleteCarEvent(car));

                                    } else {
                                      setState(() {
                                        cancelDelete = true;
                                      });
                                      Future.delayed(
                                              const Duration(milliseconds: 100))
                                          .then((onValue) {
                                        cancelDelete = false;
                                      });
                                    }
                                  },
                                  cancelDelete: cancelDelete,
                                  index: index,
                                  selectedIndex: selectedIndex,
                                ),
                              );
                            },
                            onReorder: (int oldIndex, int newIndex) {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              final item = state.cars.removeAt(oldIndex);
                              state.cars.insert(newIndex, item);
                              carBloc.add(SaveDefaultCarEvent(
                                  CarModel.fromCarEntity(item)));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CarError) {
            return InkWell(
              onTap: (){
                carBloc.add(LoadMyCarsEvent());
              },
                child: FailureWidget(failure: state.failure)
            );
          }
          return Container();
        }, listener: (BuildContext context, CarState state) {
       if(state is CarAdded || state is CarDeleted){
          carBloc.add(LoadMyCarsEvent());
        }
        // else if(state is CarUpdated){
        //   setState(() {
        //   });
        // }

      },
      ),
    );
  }

  void showBottomSheet({required CarEntity car, required context}) {
    _carNameController.clear();
    BrandDataEntity selectedModelEntity = BrandDataEntity();
    BrandDataEntity selectedBrandEntity = BrandDataEntity();
    ProductionYearModel? selectedProductionYear;
    String serialNumber = '';

    if (car.id != null) {
      serialNumber = car.serialNumber!;
      selectedProductionYear = ProductionYearModel(
          jalaliYear: car.year.toString(), georgianYear: '');
      // controller.getBrands();
      // locator<GetBrandsCubit>().getBrands(id: '');
      selectedModelEntity.id = car.modelId;
    }

    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
            value: locator<GetBrandsCubit>(),
            child: StatefulBuilder(
              builder: (context, setModelState) {
                return AddCarWidget(
                  car: CarModel.fromCarEntity(car),
                  onBrandTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    locator<GetBrandsCubit>().getBrands(id: '');
                    showModalBottomSheet(
                      context: context,
                      builder: (innerContext) {
                        return BlocProvider.value(
                          value: BlocProvider.of<GetBrandsCubit>(context),
                          child: BlocBuilder<GetBrandsCubit, GetBrandsState>(
                            builder: (context, state) {
                              if (state is GetBrandsLoading) {
                                return const LinearProgressIndicator();
                              } else if (state is GetBrandsSuccess) {
                                return SearchableListWidget<BrandDataEntity>(
                                  items: state.brands,
                                  onSelect: (brand) {
                                    selectedBrandEntity = brand;
                                    selectedModelEntity = BrandDataEntity();
                                    setModelState(() {});
                                    // context.read<CarBloc>().add(SelectBrandEvent(brand: brand));
                                  },
                                  itemToString: (item) => item.nameFa!,
                                );
                              } else if (state is GetBrandsFailure) {
                                failureDialog(state.failure, context);
                                return Container();
                              }
                              return Container(); // Return empty container for initial or unknown states
                            },
                          ),
                        );
                      },
                    );
                  },
                  onSubmit: (carName, serial) {
                    String alias =
                        '${AppLocalizations.of(context)!.car} ${locator<CarBloc>().myCars.length + 1}';
                    if (carName.isNotEmpty) {
                      alias = carName;
                    }
                    CarModel carObj = CarModel(
                      nickname: alias,
                      year: int.parse(selectedProductionYear!.jalaliYear),
                      modelFa: selectedModelEntity.nameFa,
                      serialNumber: serialNumber,
                      model: selectedModelEntity.id,
                      id: car.serialNumber!=null?car.id:null
                    );
                    if (car.serialNumber == null) {
                      carBloc.add(
                          AddCarEvent(car: CarModel.fromCarEntity(carObj)));
                    } else {
                      carBloc.add(
                          UpdateCarEvent(car: CarModel.fromCarEntity(carObj)));
                    }
                  },
                  selectedBrandEntity: selectedBrandEntity,
                  selectedModelEntity: selectedModelEntity,
                  onModelTap: () {
                    context
                        .read<GetBrandsCubit>()
                        .getBrands(id: selectedBrandEntity.id.toString());
                    showModalBottomSheet(
                      context: context,
                      builder: (innerContext) {
                        return BlocProvider.value(
                          value: BlocProvider.of<GetBrandsCubit>(context),
                          child: BlocBuilder<GetBrandsCubit, GetBrandsState>(
                            builder: (context, state) {
                              if (state is GetBrandsLoading) {
                                return const LinearProgressIndicator();
                              } else if (state is GetBrandsSuccess) {
                                return SearchableListWidget<BrandDataEntity>(
                                  items: state.brands,
                                  onSelect: (brand) {
                                    selectedModelEntity = brand;
                                    setModelState(() {});
                                    // context.read<CarBloc>().add(SelectBrandEvent(brand: brand));
                                  },
                                  itemToString: (item) => item.nameFa!,
                                );
                              } else if (state is GetBrandsFailure) {
                                failureDialog(state.failure, context);
                                return Container();
                              }
                              return Container(); // Return empty container for initial or unknown states
                            },
                          ),
                        );
                      },
                    );
                  },
                  onProductionYearSelect: (year) {
                    if (year.jalaliYear
                            .contains(AppLocalizations.of(context)!.before) ||
                        year.georgianYear
                            .contains(AppLocalizations.of(context)!.before)) {
                      year.jalaliYear = "1366";
                      year.georgianYear = "1987";
                    }
                    selectedProductionYear = year;
                  },
                  onAddDeviceTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SizedBox(
                            height: 200,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _serialController,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  showCursor: false,
                                  textInputAction: TextInputAction.done,
                                  decoration: MyTextFormField(
                                    labelText: AppLocalizations.of(context)!
                                        .serialNumber,
                                    context: context,
                                    borderColor: Colors.transparent,
                                    fillColor: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.grey.shade100
                                        : appBarDarkColor!,
                                    textColor: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white70,
                                  ).decoration(),
                                ),
                                SizedBox(height: 30.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButton(
                                      borderRadius: 20.0,
                                      color: Colors.green,
                                      onTap: () async {
                                        serialNumber =convertPersianNumbers(_serialController.text);
                                        Navigator.of(context).pop();
                                        setModelState((){});
                                      },
                                      width: 100,
                                      height: 100,
                                      image: const Icon(Icons.add,
                                          size: 70, color: Colors.white),
                                    ),
                                    CustomButton(
                                      borderRadius: 20.0,
                                      color: lightPrimaryColor,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                QrCodeScannerWidget(
                                              onDetect: (barCode) {
                                                serialNumber = barCode;
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      width: 100,
                                      height: 100,
                                      image: Icon(Icons.qr_code_2_sharp,
                                          size: 70, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  serialNumber: serialNumber,
                );
              },
            ));
      },
    );
  }

  Future<bool> removeCarBottomSheet(BuildContext context) async {
    bool? result = await showModalBottomSheet<bool>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return RemoveCarBottomSheet(
          onNoTap: () => Navigator.of(context).pop(false),
          onYesTap: () => Navigator.of(context).pop(true),
        );
      },
    );

    // Ensure result is non-null before returning
    return result ?? false;
  }
  String convertPersianNumbers(String input) {
    const persianToEnglishMap = {
      '۰': '0',
      '۱': '1',
      '۲': '2',
      '۳': '3',
      '۴': '4',
      '۵': '5',
      '۶': '6',
      '۷': '7',
      '۸': '8',
      '۹': '9',
    };

    return input.split('').map((char) {
      return persianToEnglishMap[char] ?? char; // Replace if Persian, else keep char
    }).join('');
  }
}
