import 'package:rahnegar/common/client/failures.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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