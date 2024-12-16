import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahnegar/common/utils/constants.dart';
import 'package:rahnegar/common/utils/failure_action.dart';
import 'package:rahnegar/common/widgets/failure_widget.dart';
import 'package:rahnegar/common/widgets/show_my_cars_bottom_sheet.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/blocs/car/car_bloc.dart';
import 'package:rahnegar/features/car/presentation/widgets/chart_widget.dart';
import 'package:rahnegar/locator.dart';
import 'package:rahnegar/theme/app_themes.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../widgets/custom_switch.dart';
import '../../../../widgets/home_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shamsi_date/shamsi_date.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key}) {
    // locator<CarBloc>().add(LoadMyCarsEvent());
  }
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CarBloc carBloc;
  CarEntity selectedCar = CarEntity();
  bool switchValue = true;
  late double screenWidth;
  List<PercentData> previousData = [];
  Jalali persianSelectedDate = Jalali.now();
  DateTime georgianSelectedDate = DateTime.now();

  int selectedHour = 0;
  int selectedMinute = 0;
  String? latestKilometers;
  late Locale currentLocale;
  String _georgianMonthNames(int index) {
    const List<String> georgianMonths = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return georgianMonths[index];
  }
  @override
  void initState() {
    super.initState();
    carBloc = BlocProvider.of<CarBloc>(context);
    carBloc.add(LoadMyCarsEvent());

  }

  int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  void _showDateTimePicker() async {
    Jalali? persianTempDate;
    DateTime? georgianTempDate;
    int tempHour = selectedHour;
    int tempMinute = selectedMinute;

    // Get the current locale
    Locale currentLocale = Localizations.localeOf(context);
    if (currentLocale.languageCode == 'fa') {
      persianTempDate = persianSelectedDate;
    } else {
      georgianTempDate = georgianSelectedDate;
    }
    // Show the appropriate DateTime picker based on the locale
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 250,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (currentLocale.languageCode == "fa") {
                              persianSelectedDate = persianTempDate!;
                            } else {
                              georgianSelectedDate = georgianTempDate!;
                            }
                            selectedHour = tempHour;
                            selectedMinute = tempMinute;
                          });
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 16),
                          child: Text(AppLocalizations.of(context)!.submit),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 16),
                          child: Text(AppLocalizations.of(context)!.cancel),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          // Minute Picker
                          Expanded(
                            child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem: tempMinute),
                              itemExtent: 40,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  tempMinute = index;
                                });
                              },
                              children: List.generate(
                                60,
                                (index) => Center(
                                  child: Text(
                                    index.toString().padLeft(2, '0'),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Hour Picker
                          Expanded(
                            child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem: tempHour),
                              itemExtent: 40,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  tempHour = index;
                                });
                              },
                              children: List.generate(
                                24,
                                (index) => Center(
                                  child: Text(
                                    index.toString().padLeft(2, '0'),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Day Picker
                          Expanded(
                            child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem:
                                      currentLocale.languageCode == "fa"
                                          ? persianTempDate!.day
                                          : georgianTempDate!.day - 1),
                              itemExtent: 40,
                              onSelectedItemChanged: (int index) {
                                setModalState(() {
                                  if (currentLocale.languageCode == "fa") {
                                    persianTempDate =
                                        persianTempDate!.copy(day: index + 1);
                                  } else {
                                    georgianTempDate = georgianTempDate!
                                        .copyWith(day: index + 1);
                                  }
                                });
                              },
                              children: List.generate(
                                currentLocale.languageCode == "fa"
                                    ? persianTempDate!.monthLength
                                    : getDaysInMonth(georgianTempDate!.year,
                                        georgianTempDate!.month),
                                (index) => Center(
                                  child: Text(
                                    (index + 1).toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Month Picker
                          Expanded(
                            flex: 2,
                            child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem:
                                      currentLocale.languageCode == "fa"
                                          ? persianTempDate!.month
                                          : georgianTempDate!.month - 1),
                              itemExtent: 40,
                              onSelectedItemChanged: (int index) {
                                setModalState(() {
                                  if (currentLocale.languageCode == "fa") {
                                    // Update Persian temp date
                                    persianTempDate =
                                        persianTempDate!.copy(month: index + 1);

                                    // Ensure the selected day is valid for the new month
                                    if (persianTempDate!.day >
                                        persianTempDate!.monthLength) {
                                      persianTempDate = persianTempDate!.copy(
                                          day: persianTempDate!.monthLength);
                                    }
                                  } else {
                                    // Update Georgian temp date
                                    georgianTempDate = georgianTempDate!
                                        .copyWith(month: index + 1);

                                    // Ensure the selected day is valid for the new month
                                    int daysInMonth = getDaysInMonth(
                                        georgianTempDate!.year,
                                        georgianTempDate!.month);
                                    if (georgianTempDate!.day > daysInMonth) {
                                      georgianTempDate = georgianTempDate!
                                          .copyWith(day: daysInMonth);
                                    }
                                  }
                                });
                              },
                              children: List.generate(
                                12,
                                (index) => Center(
                                  child: Text(
                                    currentLocale.languageCode == 'fa'
                                        ? Jalali(1400, index + 1, 1)
                                            .formatter
                                            .mN // Persian month name
                                        : _georgianMonthNames(
                                            index), // Georgian month name
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Year Picker
                          Expanded(
                            child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem:
                                      currentLocale.languageCode == 'fa'
                                          ? persianTempDate!.year - 1403
                                          : georgianTempDate!.year - 2024),
                              itemExtent: 40,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  if (currentLocale.languageCode == 'fa') {
                                    persianTempDate = persianTempDate!
                                        .copy(year: index + 1403);

                                    // Update the day if necessary
                                    if (persianTempDate!.day >
                                        persianTempDate!.monthLength) {
                                      persianTempDate = persianTempDate!.copy(
                                          day: persianTempDate!.monthLength);
                                    }
                                  } else {
                                    georgianTempDate = georgianTempDate!
                                        .copyWith(year: index + 2024);

                                    // Update the day if necessary
                                    int daysInMonth = getDaysInMonth(
                                        georgianTempDate!.year,
                                        georgianTempDate!.month);
                                    if (georgianTempDate!.day > daysInMonth) {
                                      georgianTempDate = georgianTempDate!
                                          .copyWith(day: daysInMonth);
                                    }
                                  }
                                });
                              },
                              children: List.generate(
                                50, // For years 1300 to 1450 (for Jalali)
                                (index) => Center(
                                  child: Text(
                                    currentLocale.languageCode == 'fa'
                                        ? (index + 1403).toString()
                                        : (index + 2024).toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    currentLocale = Localizations.localeOf(context);
    return BlocConsumer<CarBloc, CarState>(
      listener: (context, state) {
        if (state is CommandUpdated) {
          if(state.title.isNotEmpty){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.title),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        } else if (state is CarUpdated) {
          if (state.cars.isNotEmpty) {
            if (selectedCar.id != null) {
              if (selectedCar.id != state.cars.first.id) {
                selectedCar = state.cars.first;
                carBloc.add(GetBatteryStatusEvent(
                    serialNumber: selectedCar.serialNumber!));
                carBloc.add(GetMileageEvent(id: selectedCar.id.toString()));
              }
            } else {
              selectedCar = state.cars.first;
              carBloc.add(GetBatteryStatusEvent(
                  serialNumber: selectedCar.serialNumber!));
              carBloc.add(GetMileageEvent(id: selectedCar.id.toString()));
            }
          }
        }
      },
      buildWhen: (previous, current) {
        return current is CarUpdated && !current.isBottomSheet || current is CarError;
      },
      builder: (context, state) {
        return buildBody(context, state);
      },
    );
  }

  buildBody(context, state) {
    Locale currentLocale = Localizations.localeOf(context);
    if (state is CarLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is CarError) {
      return InkWell(
          onTap: (){
            carBloc.add(LoadMyCarsEvent());
          },
          child: FailureWidget(failure: state.failure)
      );
    } else
      if (state is CarUpdated) {
      if (state.cars.isEmpty) {
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
              automaticallyImplyLeading: false,
              pinned: false,
              // backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : flexibleSpaceDarkColor,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      BlocListener<CarBloc, CarState>(
                        listener: (context, state) {
                          if (state is DefaultCarSavedSuccess) {
                            selectedCar = state.carEntity;
                          }
                        },
                        child: InkWell(
                          onTap: state.cars.length == 1
                              ? null
                              : () {
                                  showMyCarsBottomSheet(
                                      context: context,
                                      onItemTap: (car) {
                                        carBloc.add(SaveDefaultCarEvent(
                                            CarModel.fromCarEntity(car)));
                                        setState(() {});
                                        selectedCar = car;
                                        carBloc.add(GetMileageEvent(
                                            id: selectedCar.id.toString()));
                                        carBloc.add(GetBatteryStatusEvent(
                                            serialNumber:
                                                selectedCar.serialNumber!));
                                      },
                                      selectedCar: selectedCar,
                                      carBloc: carBloc);
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // InkWell(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Image.asset(
                              //       "assets/images/main/turn_off.png",
                              //       height: 50,
                              //     ),
                              //   ),
                              //   onTap: () async {
                              //     _showDateTimePicker();
                              //     // _showMyDialog(context);
                              //   },
                              // ),
                              Container(
                                width: 200.w,
                                height: 40.w,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                        child: BlocListener<CarBloc, CarState>(
                                      listener: (context, state) {
                                        if (state is CarUpdated) {
                                          if(state.cars.isNotEmpty){
                                            selectedCar = state.cars.first;
                                          }
                                        }
                                      },
                                      child: Text(
                                        selectedCar.nickname ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    )),
                                    state.cars.length > 1
                                        ? IconButton(
                                            onPressed: state.cars.length == 1
                                                ? null
                                                : () {
                                                    showMyCarsBottomSheet(
                                                        context: context,
                                                        onItemTap: (car) {
                                                          carBloc.add(
                                                              SaveDefaultCarEvent(
                                                                  CarModel
                                                                      .fromCarEntity(
                                                                          car)));
                                                          setState(() {});
                                                          selectedCar = car;
                                                          carBloc.add(
                                                              GetBatteryStatusEvent(
                                                                  serialNumber:
                                                                      selectedCar
                                                                          .serialNumber!));
                                                        },
                                                        selectedCar:
                                                            selectedCar,
                                                        carBloc: carBloc);
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
                              child: selectedCar.iconLink != null
                                  ? CachedNetworkImage(
                                      imageUrl: selectedCar.iconLink ?? '',
                                      placeholder: (context, url) =>
                                          const SizedBox(),
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
                                        BlocBuilder<CarBloc, CarState>(
                                            builder: (context, state) {
                                          if (state is GetMileageStatusLoaded) {
                                            latestKilometers = state
                                                .mileageEntity
                                                .dataEntity
                                                ?.totalDistance;
                                            latestKilometers =
                                                latestKilometers != null
                                                    ? double.parse(
                                                            latestKilometers!)
                                                        .toStringAsFixed(2)
                                                    : null;
                                          }
                                          return Text(
                                            latestKilometers != null
                                                ? "$latestKilometers ${AppLocalizations.of(context)!.kilometers}"
                                                : "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          );
                                        }),
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
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         AppLocalizations.of(context)!
                      //             .allowTheVehicleToStart,
                      //         style: Theme.of(context).textTheme.headlineMedium,
                      //       ),
                      //       CustomSwitch(
                      //           value: switchValue,
                      //           onChanged: (value) {
                      //             // switchValue = value;
                      //             // setState(() {});
                      //             // if (value) {
                      //             //   carBloc.add(SendCommandEvent(
                      //             //       value: Values.allow_turn_on,
                      //             //       serialNumber: selectedCar.serialNumber!,
                      //             //       commandTitle: Commands.allowTurnOn,
                      //             //       responseTitle:
                      //             //           AppLocalizations.of(context)!
                      //             //               .theCarCanBeStarted));
                      //             // } else {
                      //             //   carBloc.add(SendCommandEvent(
                      //             //       value: Values.not_allow_turn_on,
                      //             //       serialNumber: selectedCar.serialNumber!,
                      //             //       commandTitle: Commands.allowTurnOn,
                      //             //       responseTitle:
                      //             //           AppLocalizations.of(context)!
                      //             //               .theCarCannotBeStarted));
                      //             // }
                      //           })
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                            width: 400,
                            child: BlocBuilder<CarBloc, CarState>(
                              builder: (context, state) {
                                if (state is GetBatteryStatusLoaded) {
                                  previousData = state.percentData;
                                }
                                return Stack(
                                  children: [
                                    // Show ChartWidget with data if loaded, otherwise an empty list
                                    ChartWidget(
                                      chartData: state is GetBatteryStatusLoaded
                                          ? state.percentData
                                          : previousData,
                                    ),

                                    // Show CircularProgressIndicator overlay when loading
                                    if (state is GetBatteryStatusLoading)
                                      const Positioned.fill(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                  ],
                                );
                              },
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
                  BlocBuilder<CarBloc,CarState>(
                      buildWhen: (previous, current) {
                        return current is GetCommandsLoading || current is CommandUpdated || current is GetCommandsFailure;
                      },
                      builder: (context, state){
                    if(state is GetCommandsLoading){
                      return const CircularProgressIndicator();
                    }
                    else if(state is CommandUpdated){
                      return Wrap(

                        children: state.commands.map<Widget>((command) {
                          return
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                              child: HomeButtonWidget(
                                width: screenWidth / 6,
                                title: currentLocale.languageCode == 'fa'? command.contentFa:command.content,
                                isActive: command.state,
                                child: Image.network(
                                    command.icon??''),
                              ),
                              onTap: () async {
                                carBloc.add(SendCommandEvent(
                                    serialNumber: selectedCar.serialNumber!,
                                    command: command));
                              },
                                                        ),
                            );
                        }).toList(),
                      );
                    }
                    else if(state is GetCommandsFailure){
                      return InkWell(
                        onTap: (){
                          if(carBloc.myCars.isNotEmpty) {
                            if(carBloc.myCars.first.serialNumber!=null) {
                              carBloc.add(GetCommandsEvent(serialNumber: carBloc.myCars.first.serialNumber!));
                            }
                          }
                        },
                          child: FailureWidget(failure: state.failure));
                    }
                    return Container();
                  }),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     GestureDetector(
                  //       child: HomeButtonWidget(
                  //         width: screenWidth / 6,
                  //         title: AppLocalizations.of(context)!
                  //             .carInternalListening,
                  //         child: Image.asset(
                  //             "assets/images/main/car_internal_listening.png"),
                  //       ),
                  //       onTap: () async {
                  //         const String phoneNumber = "09999999999";
                  //         final Uri phoneUri =
                  //             Uri(scheme: 'tel', path: phoneNumber);
                  //         if (await canLaunchUrl(phoneUri)) {
                  //           await launchUrl(phoneUri);
                  //         } else {
                  //           throw 'Could not launch $phoneUri';
                  //         }
                  //       },
                  //     ),
                  //     const SizedBox(
                  //       width: 10.0,
                  //     ),
                  //     HomeButtonWidget(
                  //       width: screenWidth / 6,
                  //       title: AppLocalizations.of(context)!.carPowerCut,
                  //       child:
                  //           Image.asset("assets/images/main/car_power_cut.png"),
                  //     ),
                  //     const SizedBox(
                  //       width: 10.0,
                  //     ),
                  //     HomeButtonWidget(
                  //       width: screenWidth / 6,
                  //       title: AppLocalizations.of(context)!.stopTheCar,
                  //       child: Image.asset("assets/images/main/stop_car.png"),
                  //     ),
                  //     const SizedBox(
                  //       width: 10.0,
                  //     ),
                  //     HomeButtonWidget(
                  //       width: screenWidth / 6,
                  //       title:
                  //           AppLocalizations.of(context)!.turnTheLightsOnAndOff,
                  //       child: Image.asset(
                  //         "assets/images/main/car_on_off.png",
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 10.0,
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         if (commandStatus[Commands.doorVehicleStatus] ==
                  //                 Values.open_door_vehicle ||
                  //             commandStatus[Commands.doorVehicleStatus] ==
                  //                 Values.none) {
                  //           carBloc.add(SendCommandEvent(
                  //               value: Values.close_door_vehicle,
                  //               serialNumber: selectedCar.serialNumber!,
                  //               commandTitle: Commands.doorVehicleStatus,
                  //               responseTitle: AppLocalizations.of(context)!
                  //                   .theCarDoorClosed));
                  //         } else if (commandStatus[
                  //                     Commands.doorVehicleStatus] ==
                  //                 Values.close_door_vehicle ||
                  //             commandStatus[Commands.doorVehicleStatus] ==
                  //                 Values.none) {
                  //           carBloc.add(SendCommandEvent(
                  //               value: Values.open_door_vehicle,
                  //               serialNumber: selectedCar.serialNumber!,
                  //               commandTitle: Commands.doorVehicleStatus,
                  //               responseTitle: AppLocalizations.of(context)!
                  //                   .theCarDoorOpened));
                  //         }
                  //       },
                  //       child: HomeButtonWidget(
                  //         width: screenWidth / 6,
                  //         title: AppLocalizations.of(context)!
                  //             .openingAndClosingTheCarDoor,
                  //         child: Image.asset(
                  //           "assets/images/main/car_door.png",
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HomeButtonWidget(
                        width: screenWidth / 5,
                        title: AppLocalizations.of(context)!.impactWarning,
                        child: Image.asset(
                            "assets/images/main/impact_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: screenWidth / 5,
                        title: AppLocalizations.of(context)!.motionWarning,
                        child: Image.asset(
                            "assets/images/main/motion_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: screenWidth / 5,
                        title:
                            AppLocalizations.of(context)!.switchOpeningWarning,
                        child: Image.asset(
                            "assets/images/main/switch_opening_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: screenWidth / 5,
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
                        width: screenWidth / 5,
                        title: AppLocalizations.of(context)!.lowBatteryWarning,
                        child: Image.asset(
                            "assets/images/main/low_battery_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: screenWidth / 5,
                        title:
                            AppLocalizations.of(context)!.batteryTheftWarning,
                        child: Image.asset(
                            "assets/images/main/battery_theft_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: screenWidth / 5,
                        title: AppLocalizations.of(context)!
                            .disconnectingTheDeviceWarning,
                        child: Image.asset(
                            "assets/images/main/disconnecting_the_device_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: screenWidth / 5,
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
                        width: screenWidth / 5,
                        title: AppLocalizations.of(context)!.oilChangeWarning,
                        child: Image.asset(
                            "assets/images/main/oil_change_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: screenWidth / 5,
                        title: AppLocalizations.of(context)!
                            .externalPowerFailureWarning,
                        child: Image.asset(
                            "assets/images/main/external_power_failure_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: screenWidth / 5,
                        title: AppLocalizations.of(context)!.sosAlert,
                        child: Image.asset("assets/images/main/sos_alert.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: screenWidth / 5,
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
                        width: screenWidth / 5,
                        title: AppLocalizations.of(context)!.lowFuelWarning,
                        child: Image.asset(
                            "assets/images/main/low_fuel_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: screenWidth / 5,
                        title: AppLocalizations.of(context)!
                            .sparkPlugReplacementWarning,
                        child: Image.asset(
                            "assets/images/main/spark_plug_replacement_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: screenWidth / 5,
                        title:
                            AppLocalizations.of(context)!.padReplacementWarning,
                        child: Image.asset(
                            "assets/images/main/pad_replacement_warning.png"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      HomeButtonWidget(
                        width: screenWidth / 5,
                        title: AppLocalizations.of(context)!
                            .bluetoothDisconnectionWarning,
                        child: Image.asset(
                            "assets/images/main/bluetooth_disconnection_warning.png"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100.0,
                  ),
                ],
              ),
            )
          ],
        );
      }
    }return Container();
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
                    // String title =
                    //     AppLocalizations.of(context)!.theCarTurnedOff;
                    // Future.delayed(const Duration(milliseconds: 500))
                    //     .then((onValue) {
                    //   carBloc.add(SendCommandEvent(
                    //       value: Values.turn_off_vehicle,
                    //       serialNumber: selectedCar.serialNumber!,
                    //       commandTitle: Commands.turnOffVehicle,
                    //       responseTitle: title));
                    // });
                    //
                    // Navigator.of(context).pop();
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
