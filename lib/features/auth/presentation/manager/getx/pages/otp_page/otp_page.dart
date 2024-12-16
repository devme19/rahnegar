import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rahnegar/features/auth/presentation/manager/getx/pages/otp_page/controller/otp_page_controller.dart';

import '../../../../widgets/get_phone_number_widget.dart';
import '../../../../widgets/otp_widget.dart';


class OtpPage extends StatefulWidget {
  OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  OtpPageController controller = Get.find();

  String phoneNumber='';
  bool onShow = false;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  void initState() {
    super.initState();
    controller.getOtpCodeStatus.listen((status){
      if(status.isSuccess){
        cardKey.currentState!.toggleCard();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffD9D9D9),
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlipCard(
                        key: cardKey,
                        flipOnTouch: false,
                        direction: FlipDirection.HORIZONTAL,
                        side: CardSide.FRONT,
                        front: GetPhoneNumberWidget(onValidateDone: onValidationDone),
                        // back: OtpWidget(onChangePhoneNumber: ,),)
                        back:Obx(()=>OtpWidget(onChangePhoneNumber: ()=>cardKey.currentState!.toggleCard(),otpVerification: otpVerification,onShow: controller.getOtpCodeStatus.value.isSuccess,)))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
  onValidationDone(String phone){
    print(phone);
    phoneNumber = phone;
    controller.getOtpCode(phoneNumber);
  }

  otpVerification(String otpCode){
    controller.otpVerification(phoneNumber, otpCode);
  }
}