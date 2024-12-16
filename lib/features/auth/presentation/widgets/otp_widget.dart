import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../../../../../../../common/widgets/my_text_form_field.dart';
import '../../../../common/widgets/my_button.dart';


class OtpWidget extends StatefulWidget {
  OtpWidget({super.key,required this.onChangePhoneNumber,required this.otpVerification,required this.onShow});

  Function onChangePhoneNumber;
  Function otpVerification;
  bool onShow;
  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget>{

  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  int startAnimateTime = 1000;
  int timeOffset = 300;
  @override
  void dispose() {
    controller.stopListen();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _initInteractor();
    controller = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) {
        widget.otpVerification(code);
      },
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
          (code) {
            print(code);
        final exp = RegExp(r'(\d{6})');
        return exp.stringMatch(code ?? '') ?? '';
      },
    );
  }
  Future<void> _initInteractor() async {
    _otpInteractor = OTPInteractor();

    // You can receive your app signature by using this method.
    final appSignature = await _otpInteractor.getAppSignature();

    print('Your app signature: $appSignature');
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
          padding: const EdgeInsets.all(16.0),
          child:Column(
            children: [
              const SizedBox(height: 8.0,),
              Row(
                children: [
                  widget.onShow?TypeWriter.text(AppLocalizations.of(context)!.enterVerificationCode, duration: Duration(milliseconds: 20),style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),):Container()
                ],
              ),
              const SizedBox(
                height: 32.0,
              ),
              widget.onShow?Animate(
                delay: Duration(milliseconds: startAnimateTime),
                effects: const [FadeEffect()],
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: controller,
                    maxLength: 6,
                    showCursor: false,
                    decoration: MyTextFormField(
                        fillColor: Colors.white,
                        borderColor: Colors.grey.shade300,
                        context: context,
                        suffixIcon:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/images/otp/otp.png",width: 5,height: 5,),
                        )
                    ).decoration()

                ),
              ):Container(),
              const SizedBox(
                height: 32.0,
              ),
              widget.onShow?Animate(
                delay: Duration(milliseconds: startAnimateTime+timeOffset),
                effects: [ScaleEffect()],
                child: widget.onShow?MyButton(
                    color: const Color(0xffF39200),
                    text: AppLocalizations.of(context)!.submit,
                    onTap: () {
                      // _requestPermissions();
                      widget.otpVerification(controller.text);
                    }):Container(),
              ):Container(),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.onShow?Animate(
                    delay: Duration(milliseconds: startAnimateTime+timeOffset*2),
                    effects: [ScaleEffect()],
                    child: InkWell(
                      onTap: (){
                        widget.onChangePhoneNumber();
                        controller.clear();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 8.0),
                        child: Text(AppLocalizations.of(context)!.changePhoneNumber,style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ),
                  ):Container(),
                ],
              ),

            ],
          )
      );
  }
}
