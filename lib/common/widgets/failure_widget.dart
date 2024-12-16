import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rahnegar/common/widgets/refresh_widget.dart';
import '../client/failures.dart';

class FailureWidget extends StatelessWidget {

  const FailureWidget({super.key,required this.failure});
  final Failure failure;

  @override
  Widget build(BuildContext context) {
    String description = getFailureDescription(failure,context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(AppLocalizations.of(context)!.error,textAlign: TextAlign.center),
            Text(description,textAlign: TextAlign.center,),
            SizedBox(height: 16.0,),
            Icon(Icons.refresh)
          ],
        ),
      ],
    );
  }

  String getFailureDescription(Failure failure,context){
    String description =AppLocalizations.of(context)!.communicationError;
    if(failure is ServerFailure) {
      if (failure.errorMessage != null) {
        if(failure.errorMessage!.isNotEmpty){
          description = failure.errorMessage!;
        }
      }
    }
    return description;
  }

}
