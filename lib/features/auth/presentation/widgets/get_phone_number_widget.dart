import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../../../../../common/widgets/my_button.dart';
import '../../../../../../common/widgets/my_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetPhoneNumberWidget extends StatefulWidget {
  const GetPhoneNumberWidget({super.key,required this.onValidateDone,this.isLoading=false});
  final Function(String) onValidateDone;
  final bool isLoading;

  @override
  State<GetPhoneNumberWidget> createState() => _GetPhoneNumberWidgetState();
}

class _GetPhoneNumberWidgetState extends State<GetPhoneNumberWidget> {
  final TextEditingController controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final int startAnimateTime = 1000;

  final int timeOffset = 300;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 8.0,),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.enterMobileNumber,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black)),

              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            TextFormField(
              showCursor: false,
              maxLength: 11,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
              controller: controller,
              validator: (value){
                if(value!.isEmpty){
                  return AppLocalizations.of(context)!.enterMobileNumber;
                }
                const pattern = r'^(?:[+0]9)?[0-9]{11}$';
                final regExp = RegExp(pattern);
                if (!regExp.hasMatch(value)) {
                  return AppLocalizations.of(context)!.phoneNumberIsNotValid;
                }
                return null;
                // return null;
              },
              onFieldSubmitted: (_){
                print(_);
                if( _formKey.currentState!.validate()){
                  widget.onValidateDone(controller.text);
                  // setState((){
                  //   showVerifyOtpWidget = true;
                  // });
                }
              },
              keyboardType: TextInputType.phone,
              decoration: MyTextFormField(
                  fillColor: Colors.white,
                  borderColor: Colors.grey.shade300,
                  context: context,
                  suffixIcon:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/otp/mobile.png",width: 5,height: 5,),
                  )
                // Image.asset(
                //   "assets/images/login/pen.png",
                //   width: 16.0,
                //   height: 16.0,
                //   color: Colors.grey,
                // ),
              )
                  .decoration(),
            ),
            const SizedBox(
              height: 32.0,
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xffF39200)
                // Text color
              ), onPressed: () {
              if(_formKey.currentState!.validate()){
                widget.onValidateDone(controller.text);
              }
            },
              child: SizedBox(
                width: double.infinity,
                child: Center(child: widget.isLoading?const SpinKitThreeBounce(color: Colors.white,size: 20,):Text(AppLocalizations.of(context)!.submit)),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
