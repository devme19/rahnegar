import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rahnegar/common/widgets/background_widget.dart';
import 'package:rahnegar/features/intro/presentation/manager/getx/pages/widgets/circle_button_widget.dart';
import 'package:rahnegar/routes/app_routes.dart';

import '../../../../../../../routes/route_names.dart';

class SelectVehiclePage extends StatelessWidget {
  const SelectVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BackGroundWidget(
          children:
         [ Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleButtonWidget(
                  color: const Color(0xffF39200),
                  onTap: (){
                    print("truck tapped");
                  },
                  child: Image.asset('assets/images/vehicle/truck.png'),
                ),
                CircleButtonWidget(
                  color: const Color(0xffF39200),
                  onTap: (){
                    Get.offAndToNamed(RouteNames.userInfoPage);
                  },
                  child: Image.asset('assets/images/vehicle/car1.png'),
                ),
                CircleButtonWidget(
                  color: const Color(0xffF39200),
                  onTap: (){
                    print("motorcycle tapped");
                  },
                  child: Image.asset('assets/images/vehicle/motorcycle.png',height: 50,width: 50,),
                ),

              ],
            ),
          )],
        ),
      ),
    );
  }
}
