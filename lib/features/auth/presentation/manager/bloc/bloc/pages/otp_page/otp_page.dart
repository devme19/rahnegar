import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/failure_action.dart';
import 'package:rahnegar/common/widgets/back_ground.dart';
import 'package:rahnegar/features/auth/presentation/manager/bloc/bloc/blocs/otp_bloc.dart';
import 'package:rahnegar/locator.dart';
import 'package:rahnegar/routes/route_names.dart';

import '../../../../../widgets/get_phone_number_widget.dart';
import '../../../../../widgets/otp_widget.dart';

class OtpPage extends StatefulWidget {
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String phoneNumber = '';

  late OtpBloc otpBloc;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void dispose() {
    super.dispose();
    otpBloc.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    otpBloc = BlocProvider.of<OtpBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: const Color(0xffD9D9D9),
        // backgroundColor: const Color(0xffD9D9D9),
        body: BackGroundWidget(
            widget: Align(
          alignment: Alignment.center,
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlipCard(
                    key: cardKey,
                    flipOnTouch: false,
                    direction: FlipDirection.HORIZONTAL,
                    side: CardSide.FRONT,
                    front: BlocBuilder<OtpBloc, OtpState>(
                      builder: (context, state) {
                        return GetPhoneNumberWidget(
                          onValidateDone: onValidationDone,
                          isLoading: state is OtpLoading,
                        );
                      },
                    ),
                    // back: OtpWidget(onChangePhoneNumber: ,),)
                    back: BlocConsumer<OtpBloc, OtpState>(
                      listener: (context, state) {
                        if (state is FailureState) {
                          failureDialog(state.failure, context);
                        } else if (state is SuccessState) {
                          if (state.getOtpCode) {
                            cardKey.currentState!.toggleCard();
                          } else if (state.otpVerification) {
                            otpBloc.getUserInfo(registeredUSer: (response) {
                              if (response) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    RouteNames.introPage,
                                    (Route<dynamic> route) => false);
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    RouteNames.userInfoPage,
                                    (Route<dynamic> route) => false);
                              }
                            });
                          }
                        }
                      },
                      builder: (context, state) {
                        return OtpWidget(
                          onChangePhoneNumber: () {
                            cardKey.currentState!.toggleCard();
                          },
                          otpVerification: otpVerification,
                          onShow: true,
                        );
                      },
                    )),
              ),
            ],
          ),
        )));
  }

  onValidationDone(String phone) {
    print(phone);
    phoneNumber = phone.replaceAll(RegExp(r'\D'), '');
    otpBloc.add(GetOtpCodeEvent(phoneNumber: phoneNumber));
  }

  otpVerification(String otpCode) {
    otpBloc
        .add(OtpVerificationEvent(otpCode: otpCode, phoneNumber: phoneNumber));
    // controller.otpVerification(phoneNumber, otpCode);
  }
}
