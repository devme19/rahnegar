import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/blocs/car/car_bloc.dart';
import 'package:rahnegar/features/car/presentation/widgets/car_item_list_widget.dart';
import 'package:rahnegar/theme/app_themes.dart';

void showMyCarsBottomSheet(
    {required BuildContext context,
    required CarBloc carBloc,
    required Function(CarEntity) onItemTap,
    required CarEntity selectedCar}) {
  // Dispatch LoadMyCarsEvent to load cars
  carBloc.add(LoadMyCarsEvent(isBottomSheet: true));

  showModalBottomSheet(
    context: context,
    builder: (_) {
      return BlocProvider.value(
        value: carBloc,
        child: BlocConsumer<CarBloc, CarState>(
          buildWhen: (previous, current) {
            return current is CarUpdated && current.isBottomSheet || current is CarError || current is CarLoading;
          },
          builder: (context, state) {
            if (state is CarLoading) {
              return const LinearProgressIndicator();
            } else if (state is CarUpdated) {
              return Container(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : appBarDarkColor,
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    height: 0.5,
                    color: Colors.grey.shade100,
                  ),
                  itemBuilder: (context, index) {
                    final car = state.cars[index];
                    return Animate(
                      effects: const [FadeEffect()],
                      delay: Duration(milliseconds: 100 * index),
                      child: SizedBox(
                        height: 100,
                        child: CarItemListWidget(
                          car: car,
                          onTap: (carItem) {
                            onItemTap(carItem);

                            Navigator.of(context).pop();
                          },
                          selectedCar: selectedCar,
                        ),
                      ),
                    );
                  },
                  itemCount: state.cars.length,
                ),
              );
            } return const SizedBox.shrink();
          }, listener: (BuildContext context, CarState state) {
          // if(state is CarError){
          //   Future.delayed(Duration(seconds: 1)).then((onValue){
          //     Navigator.of(context).pop();
          //   });
          // }
        },
        ),
      );
    },
  );
}