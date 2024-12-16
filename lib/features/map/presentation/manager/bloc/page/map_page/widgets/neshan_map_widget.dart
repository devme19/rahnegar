import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahnegar/common/widgets/my_text_form_field.dart';
import 'package:rahnegar/common/widgets/show_my_cars_bottom_sheet.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/blocs/car/car_bloc.dart';
import 'package:rahnegar/features/map/data/model/item.dart';
import 'package:rahnegar/features/map/presentation/manager/bloc/blocs/map/map_bloc.dart';
import 'package:rahnegar/features/map/presentation/manager/bloc/page/map_page/widgets/cupertino_date_time_picker_widget.dart';
import 'package:rahnegar/features/map/presentation/manager/bloc/page/map_page/widgets/history_widget.dart';
import 'package:rahnegar/locator.dart';
import 'package:rahnegar/native/native_bridge.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shamsi_date/shamsi_date.dart';

class NeshanMapWidget extends StatefulWidget {
  NeshanMapWidget({super.key, required int selectedIndex}) {
    if (selectedIndex != 0) {
      locator<MapBloc>().pauseTimer();
    } else {
      locator<MapBloc>().resumeTimer();
    }
    // locator<MapBloc>().pauseTimer();
  }

  @override
  State<NeshanMapWidget> createState() => _NeshanMapWidgetState();
}

class _NeshanMapWidgetState extends State<NeshanMapWidget> {
  late CarBloc carBloc;
  late MapBloc mapBloc;
  TextEditingController searchController = TextEditingController();
  bool showClearIcon = false;
  bool isExpanded = false;
  CarEntity selectedCar = CarEntity();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carBloc = BlocProvider.of<CarBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);
    carBloc.add(LoadMyCarsEvent(isBottomSheet: true));
  }

  void search(String term) async {
    mapBloc.add(SearchEvent(term: term));
    showClearIcon = true;
    setState(() {});
  }

  clearSearch() async {
    showClearIcon = false;
    isExpanded = false;
    FocusScope.of(context).unfocus();
    mapBloc.clearSearch();
    mapBloc.removeSelectedLocationMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AndroidView(
          viewType: 'native_map_view',
          onPlatformViewCreated: (int id) {
            NativeBridge().createChannel(id);
          },
        ),
        // const Align(
        //   alignment: Alignment.bottomCenter,
        //   child: HistoryWidget(),
        // ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: 100,
            height: 45,
            color: Colors.transparent,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () async {
                  String dateTimeStr = "";
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return SizedBox(
                            height: 400,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 40.0,
                                ),
                                CupertinoDateTimePickerWidget(
                                    onChecked: (dateTime) {
                                  if (dateTime.year != 0) {
                                    print(dateTime);
                                    print(Jalali.now());
                                    Locale currentLocale =
                                        Localizations.localeOf(context);
                                    if (currentLocale.languageCode == "fa") {
                                      print(
                                          "${dateTime.year} +${dateTime.month} + ${dateTime.day} + ${dateTime.hour} + ${dateTime.minute}");
                                      DateTime dt = Jalali(
                                              dateTime.year!,
                                              dateTime.month!,
                                              dateTime.day!,
                                              dateTime.hour!,
                                              dateTime.minute!)
                                          .toDateTime();
                                      final dis = Jalali.now()
                                          .toDateTime()
                                          .difference(dt);
                                      String days = "";
                                      String hours = "";
                                      String minutes = "";
                                      if (dis.inDays >= 0 &&
                                          dis.inHours >= 0 &&
                                          dis.inMinutes >= 0) {
                                        if (dis.inDays > 0) {
                                          days = "${dis.inDays} روز ";
                                        }
                                        if (dis.inHours % 24 != 0) {
                                          hours = " ${dis.inHours % 24} ساعت ";
                                        }
                                        if (dis.inMinutes % 60 != 0) {
                                          minutes =
                                              "${dis.inMinutes % 60} دقیقه ";
                                        }
                                        if ((days + hours + minutes)
                                            .isNotEmpty) {
                                          dateTimeStr =
                                              "$days$hours$minutesقبل ";
                                        }
                                      } else {
                                        dateTimeStr =
                                            "تاریخ شروع نمی تواند از تاریخ امروز جلوتر باشد";
                                      }
                                      setModalState(() {});
                                      print(
                                          "day : ${dis.inDays} , hours : ${dis.inHours % 24} , minutes : ${dis.inMinutes % 60}");
                                    }
                                  } else {
                                    setModalState(() {
                                      dateTimeStr = "";
                                    });
                                  }
                                }),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  dateTimeStr,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                CupertinoDateTimePickerWidget(
                                  onChecked: (dateTime) {
                                    print(dateTime);
                                  },
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Image.asset(
                  "assets/images/map/history.png",
                  width: 50,
                )),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
              //   child: TextFormField(
              //     controller: searchController,
              //     onChanged: (text) {
              //       // controller.search(text);
              //       // if(text.isEmpty){
              //       //   controller.showClearIcon.value = false;
              //       // }
              //       // else{
              //       //   controller.showClearIcon.value = true;
              //       // }
              //     },
              //     onFieldSubmitted: (text) {
              //       search(text);
              //     },
              //     decoration: MyTextFormField(
              //             labelText: AppLocalizations.of(context)!.search,
              //             context: context,
              //             borderColor: Colors.transparent,
              //             suffixIcon: Container(
              //               padding: const EdgeInsets.only(left: 16.0),
              //               // color: Colors.blue,
              //               width: 100,
              //               child: Row(
              //                 children: [
              //                   Expanded(
              //                     child: showClearIcon
              //                         ? InkWell(
              //                             child: const Icon(
              //                               Icons.close,
              //                               color: Colors.red,
              //                             ),
              //                             onTap: () {
              //                               searchController.clear();
              //                               clearSearch();
              //                             },
              //                           )
              //                         : Container(),
              //                   ),
              //                   Expanded(
              //                     child: InkWell(
              //                       child: Icon(
              //                         Icons.search,
              //                         color: Theme.of(context)
              //                             .textTheme
              //                             .bodyLarge!
              //                             .color!,
              //                       ),
              //                       onTap: () {
              //                         search(searchController.text);
              //                         FocusScope.of(context).unfocus();
              //                       },
              //                     ),
              //                   ),
              //                   const SizedBox(
              //                     width: 8.0,
              //                   )
              //                 ],
              //               ),
              //             ),
              //             fillColor:
              //                 Theme.of(context).brightness == Brightness.light
              //                     ? Colors.white70
              //                     : Colors.black26,
              //             textColor:
              //                 Theme.of(context).textTheme.bodyLarge!.color!)
              //         .decoration(),
              //   ),
              // ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // FloatingActionButton(
                        //   heroTag: 'tag2',
                        //   onPressed: () {
                        //     mapBloc.goToLocation();
                        //     // controller.goToLocation();
                        //     // controller.goToLocation(GeoPoint(latitude: controller.location.value.latitude!, longitude: controller.location.value.longitude!));
                        //   },
                        //   mini: true,
                        //   backgroundColor: Colors.white70,
                        //   child: const Icon(
                        //     Icons.gps_fixed,
                        //     size: 20,
                        //     color: Colors.black54,
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            if (carBloc.myCars.length > 1) {
                              showMyCarsBottomSheet(
                                  context: context,
                                  carBloc: carBloc,
                                  selectedCar: selectedCar,
                                  onItemTap: (car) {
                                    setState(() {
                                      selectedCar = car;
                                    });
                                    carBloc.add(SaveDefaultCarEvent(
                                        CarModel.fromCarEntity(selectedCar)));
                                  });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.only(top: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white70
                                  : Colors.black26,
                            ),
                            child: BlocListener<CarBloc, CarState>(
                              listener: (context, state) {
                                if (state is DefaultCarSavedSuccess) {
                                  selectedCar = state.carEntity;
                                  if (selectedCar.serialNumber != null) {
                                    setSelectedCar();
                                  }
                                } else if (state is CarUpdated) {
                                  if(selectedCar.id == null){
                                    selectedCar = state.cars.first;
                                    if (selectedCar.serialNumber != null) {
                                      setSelectedCar();
                                    }
                                  }else if(selectedCar.id != state.cars.first.id ){
                                    selectedCar = state.cars.first;
                                    if (selectedCar.serialNumber != null) {
                                      setSelectedCar();
                                    }
                                  }

                                }
                              },
                              child: Text(
                                selectedCar.nickname ?? '',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<MapBloc, MapState>(
                      buildWhen: (previous, current) {
                    return current is SearchInProgress ||
                        current is SearchSucceed;
                  }, builder: (context, state) {
                    if (state is SearchInProgress) {
                      return Container(
                        height: 2.0,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const LinearProgressIndicator(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                      );
                    } else if (state is SearchSucceed) {
                      final searchResults = state.items;
                      if (state.items.isNotEmpty) {
                        return AnimatedContainer(
                          height: isExpanded
                              ? MediaQuery.of(context).size.height / 3
                              : 0,
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black26
                                    : Colors.white70,
                          ),
                          child: ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                final item = searchResults[index];
                                return ListTile(
                                  onTap: () {
                                    final location =
                                        searchResults[index].location;
                                    mapBloc.onSearchListTileTap(
                                        latitude: location.latitude,
                                        longitude: location.longitude);
                                    isExpanded = false;
                                    setState(() {});
                                  },
                                  title: Text(
                                    item.title,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!,
                                  ),
                                  subtitle: Text(
                                    item.address,
                                    style:
                                        Theme.of(context).textTheme.bodySmall!,
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.black12
                                      : Colors.grey.shade300,
                                  thickness: 1.0,
                                );
                              },
                              itemCount: searchResults.length),
                        );
                      } else {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.5, vertical: 1),
                          height: 30,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white70
                                  : Colors.black26,
                          // color: Colors.red,
                          child: Center(
                              child: Text(
                                  AppLocalizations.of(context)!.noItemFound,
                                  style:
                                      Theme.of(context).textTheme.bodyLarge)),
                        );
                      }
                    }
                    return Container();
                  }, listener: (context, state) {
                    if (state is SearchSucceed) {
                      if (state.items.isNotEmpty) {
                        isExpanded = true;
                        setState(() {});
                      }
                    }
                  })
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is GetLocationLoading) {
              return Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            } else if (state is LocationNotSet) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Text(
                      AppLocalizations.of(context)!
                          .noLocationHasBeenRegisteredForThisCar,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              );
            }
            return Container();
          },
        )
      ],
    );
  }
  setSelectedCar(){
    mapBloc.serialNumber =
    selectedCar.serialNumber!;
    mapBloc.pauseTimer();
    mapBloc.resumeTimer();
    mapBloc.reset = true;
    setState(() {});
  }
}
