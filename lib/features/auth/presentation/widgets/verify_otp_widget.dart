import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/my_button.dart';
import '../../../../../../common/widgets/my_text_form_field.dart';

 class VerifyOtpWidget extends StatefulWidget {
   VerifyOtpWidget({super.key,required this.onChangePhoneNumber});
   Function onChangePhoneNumber;

  @override
  State<VerifyOtpWidget> createState() => _VerifyOtpWidgetState();
}

class _VerifyOtpWidgetState extends State<VerifyOtpWidget> {

   final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
   final List<TextEditingController> _controller = List.generate(5, (_) => TextEditingController());
    int? currentFocusIndex;
   bool _onKey(KeyEvent event) {
     final key = event.logicalKey.keyLabel;
     currentFocusIndex = _focusNodes.indexWhere((node) => node.hasFocus);
     if (event is KeyDownEvent && key == 'Backspace') {
       if (currentFocusIndex! >= 0 && currentFocusIndex!<4) {
         _focusNodes[currentFocusIndex! + 1].requestFocus();
       }
     }

     return false;
   }

   @override
   void initState() {
     super.initState();

     ServicesBinding.instance.keyboard.addHandler(_onKey);
   }

   @override
   void dispose() {
     ServicesBinding.instance.keyboard.removeHandler(_onKey);
     for (FocusNode _ in _focusNodes) {
       _.dispose();
     }
     for (TextEditingController _ in _controller) {
       _.dispose();
     }
     super.dispose();
   }

   @override
   Widget build(BuildContext context) {
     return
       Card(
         color: Colors.white,
         child: Padding(
           padding: const EdgeInsets.all(16.0),
           child:Column(
             children: [
               const SizedBox(height: 8.0,),
               Row(
                 children: [
                   Text('enterVerificationCode'.tr),
                 ],
               ),
               const SizedBox(
                 height: 32.0,
               ),
               Row(
                 children: [
                   for (int i = 0; i < 5; i++)
                     Expanded(
                       child:
                       Padding(
                         padding: EdgeInsets.only(right: i==0?0:4.0),
                         child: TextFormField(
                           showCursor: false,
                           maxLength: 1,
                           onChanged: (value){
                             if(value.isNotEmpty && currentFocusIndex!>0){
                               _focusNodes[currentFocusIndex! - 1].requestFocus();
                             }
                           },
                           controller: _controller[i],
                           focusNode: _focusNodes[i],
                           textInputAction: i==0?TextInputAction.done:TextInputAction.next,
                           textAlign: TextAlign.center,
                           keyboardType: TextInputType.number,
                           decoration: MyTextFormField(
                             fillColor: Colors.white,
                             borderColor: Colors.grey.shade300,
                             context: context,
                           ).decoration(),
                         ),
                       ),
                     ),
                 ],
               ),
               const SizedBox(
                 height: 16.0,
               ),
               MyButton(
                   color: const Color(0xffF39200),
                   text: 'submit'.tr,
                   onTap: () {
                     // Get.offAndToNamed(AppRoutes.mainPage);
                     // if(_formKey.currentState!.validate()){
                     //   setState((){
                     //     showVerifyOtpWidget = true;
                     //   });
                     // }
                   }),
               const SizedBox(
                 height: 16.0,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   InkWell(
                     onTap: (){
                       Future.delayed(const Duration(milliseconds: 400)).then((value){
                         for (TextEditingController _ in _controller) {
                           _.clear();
                         }
                       });

                       widget.onChangePhoneNumber();
                     },
                     child: Padding(
                       padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 8.0),
                       child: Text('changePhoneNumber'.tr,style: Theme.of(context).textTheme.bodyMedium),
                     ),
                   ),
                 ],
               ),

             ],
           )
         ),
       );
   }
}
