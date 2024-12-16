import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rahnegar/common/utils/get_failure_description.dart';
import '../../theme/app_themes.dart';

// failureAction(Failure failure){
//   if(failure is ServerFailure) {
//     if(failure.errorMessage != null) {
//       Get.snackbar("error".tr,failure.errorMessage!,backgroundColor: lightPrimaryColor.withOpacity(0.2),colorText: Colors.black);
//     }else{
//       Get.snackbar("error".tr, "communicationError".tr,backgroundColor: lightPrimaryColor.withOpacity(0.2),colorText: Colors.black);
//     }
//   }else if(failure is NetworkFailure){
//     Get.snackbar("error".tr, "communicationError".tr,backgroundColor: lightPrimaryColor.withOpacity(0.2),colorText: Colors.black);
//   }
// }
// void failureAction(Failure failure) {
//   String description ="communicationError".tr;
//   if(failure is ServerFailure) {
//     if (failure.errorMessage != null) {
//       if(failure.errorMessage!.isNotEmpty){
//         description = failure.errorMessage!;
//       }
//       // Get.snackbar("error".tr,failure.errorMessage!,backgroundColor: lightPrimaryColor.withOpacity(0.2),colorText: Colors.black);
//     }
//   }
//   Get.defaultDialog(
//     title: "error".tr, // Set an empty title to remove the title area
//     content: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(description)
//         ],
//       ),
//     ),
//     radius: 10.0,
//   );
// }
void failureDialog(Failure failure,context,[Function? retry]) {
  String description =getFailureDescription(failure, context);
  showDialog<void>(
    context: context,
    barrierDismissible: true, // User must tap a button to close the dialog
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.error,textAlign: TextAlign.center),
        content:Text(description,textAlign: TextAlign.center,),
        actions: [
          retry!=null?Center(child: IconButton(onPressed: ()=>retry(), icon: const Icon(Icons.refresh))):Container()
        ],
      );
    },
  );
}