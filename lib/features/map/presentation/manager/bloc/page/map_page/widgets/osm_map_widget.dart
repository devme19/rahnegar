import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rahnegar/common/widgets/show_my_cars_bottom_sheet.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/blocs/car/car_bloc.dart';
import 'package:rahnegar/features/map/presentation/manager/bloc/blocs/map/map_bloc.dart';
import 'package:rahnegar/features/map/presentation/manager/bloc/page/map_page/widgets/cupertino_date_time_picker_widget.dart';
import 'package:rahnegar/locator.dart';
import 'package:rahnegar/theme/app_themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shamsi_date/shamsi_date.dart';

class OsmMapWidget extends StatefulWidget {
  OsmMapWidget({super.key, required int selectedIndex}) {
    if (selectedIndex != 0) {
      locator<MapBloc>().pauseTimer();
    } else {
      locator<MapBloc>().resumeTimer();
    }
    // locator<MapBloc>().pauseTimer();
  }

  @override
  State<OsmMapWidget> createState() => _OsmMapWidgetState();
}

class _OsmMapWidgetState extends State<OsmMapWidget> {
  late CarBloc carBloc;
  late MapBloc mapBloc;
  CarEntity selectedCar = CarEntity();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carBloc = BlocProvider.of<CarBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);
    carBloc.add(LoadMyCarsEvent(isBottomSheet: true));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        OSMFlutter(
          onLocationChanged: (GeoPoint position) {
            print(
                'Location changed: ${position.latitude}, ${position.longitude}');
          },
          controller: mapBloc.mapController,
          // mapIsLoading: const Center(child: CircularProgressIndicator()),
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
            roadConfiguration:
                RoadOption(roadColor: Colors.purple, roadWidth: 10),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () async {
                  String dateTimeStr = "";
                  DateTime? startDateTime;
                  bool isValidToSubmit=false;
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return SizedBox(
                            height: 400,
                            child:
                            Column(
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

                                          startDateTime = Jalali(
                                              dateTime.year!,
                                              dateTime.month!,
                                              dateTime.day!,
                                              dateTime.hour!,
                                              dateTime.minute!)
                                              .toDateTime();
                                          final dis = Jalali.now()
                                              .toDateTime()
                                              .difference(startDateTime!);
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
                                Row(
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(onPressed: (){
                                        if(startDateTime!=null){
                                          final now = DateTime.now();
                                          Map<String,dynamic> queryParameters={
                                            'device_sn':mapBloc.serialNumber,
                                            'start':startDateTime.toString(),
                                            'end':now.toString(),
                                            'type':"gregorian"
                                          };
                                          print(queryParameters);
                                          mapBloc.add(GetRoutesEvent(queryParameters: queryParameters));
                                          Navigator.of(context).pop();
                                        }
                                      }, child: Text(AppLocalizations.of(context)!.submit,style: const TextStyle(color: Colors.white))),
                                    )),
                                  ],
                                )
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
              color: Theme.of(context).brightness == Brightness.light
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
                  if (selectedCar.id == null) {
                    selectedCar = state.cars.first;
                    if (selectedCar.serialNumber != null) {
                      setSelectedCar();
                    }
                  } else if (selectedCar.id != state.cars.first.id) {
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
        BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if(state is GetLocationLoading){
              return
                Align(
                  alignment: Alignment.center,
                    child: SpinKitRipple(color: lightPrimaryColor,));
            }
            else if (state is LocationNotSet) {
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
            }else if (state is GetLocationFailed) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Text(
                      AppLocalizations.of(context)!
                          .error,
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

  setSelectedCar() {
    mapBloc.serialNumber = selectedCar.serialNumber!;
    mapBloc.mapController.clearAllRoads();
    if(mapBloc.latestLocation!=null){
      if(mapBloc.latestLocation!.latitude!=null && mapBloc.latestLocation!.longitude!=null){
        mapBloc.mapController.removeMarker(GeoPoint(latitude: mapBloc.latestLocation!.latitude!, longitude: mapBloc.latestLocation!.longitude!));
      }
    }

    mapBloc.pauseTimer();
    mapBloc.resumeTimer();
    mapBloc.reset = true;
    setState(() {});
  }
}
