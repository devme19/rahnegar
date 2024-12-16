import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rahnegar/theme/app_themes.dart';

import '../../../../common/widgets/my_button.dart';
class RemoveCarBottomSheet extends StatelessWidget {
  RemoveCarBottomSheet({super.key,required this.onYesTap,required this.onNoTap});
  Function onYesTap;
  Function onNoTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(16.0),
      color:Theme.of(context).brightness == Brightness.light? Colors.white:appBarDarkColor,
      child: Column(
        children: [
          Row(
            children: [Text(AppLocalizations.of(context)!.removeTheCarAlert)],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: MyButton(
                        color: Colors.red,
                        text: AppLocalizations.of(context)!.yes,
                        onTap: () =>
                          onYesTap()
                        ),
                  ),
                  const SizedBox(
                    width: 100.0,
                  ),
                  Expanded(
                      child: MyButton(
                          color:Colors.green,
                          text: AppLocalizations.of(context)!.no,
                          onTap: () => onNoTap())),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
