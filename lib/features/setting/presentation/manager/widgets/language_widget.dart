import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key , required this.isPersian, required this.isPersianLocale});
  final Function(bool) isPersian;
  final bool isPersianLocale;

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  bool isPersian = true;

  bool isDisabled = false;

  MSHCheckboxStyle style = MSHCheckboxStyle.stroke;


  @override
  void initState() {
    super.initState();
    isPersian = widget.isPersianLocale;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: (){
            if(!isPersian){
              setState(() {
                isPersian = !isPersian;
              });
              widget.isPersian(isPersian);
            }
          },
          child: SizedBox(
            height: 80.0,
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.persian,style: Theme.of(context).textTheme.bodyMedium,),
                const SizedBox(width: 8.0,),
                MSHCheckbox(
                    size: 20,
                    style: style,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(checkedColor: Colors.green),
                    value: isPersian, onChanged: (value){
                 print(value);
                 if(value) {
                   setState(() {
                    isPersian = value;
                  });
                   widget.isPersian(isPersian);
                 }
                }),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: (){
            if(isPersian){
              setState(() {
                isPersian = !isPersian;
              });
              widget.isPersian(isPersian);
            }
          },
          child: SizedBox(
            height: 80.0,
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.english,style: Theme.of(context).textTheme.bodyMedium,),
                const SizedBox(width: 8.0,),
                MSHCheckbox(
                  size: 20,
                    style: style,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(checkedColor: Colors.green),
                    value: !isPersian, onChanged: (value){
                  print(value);
                  if(value){
                    setState(() {
                      isPersian = !value;
                    });
                    widget.isPersian(isPersian);
                  }
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
