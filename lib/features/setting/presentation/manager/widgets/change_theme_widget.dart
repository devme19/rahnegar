

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeWidget extends StatefulWidget {
  ThemeWidget({super.key , required this.mode,required this.themeMode});
  Function(String) mode;
  ThemeMode themeMode;

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {


  MSHCheckboxStyle style = MSHCheckboxStyle.stroke;



  @override
  void initState() {
    super.initState();
    // switch (widget.themeMode){
    //   case "light":
    //     isDark = false;
    //     break;
    //   case "dark":
    //     isDark = true;
    //     break;
    //   case "system":
    //     if(Get.theme.brightness == Brightness.dark)
    //       {
    //         isDark = true;
    //       }
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: (){
            widget.themeMode = ThemeMode.light;
           setState(() {
           });
            widget.mode("light");
          },
          child: SizedBox(
            height: 80.0,
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.light,style: Theme.of(context).textTheme.bodyMedium,),
                const SizedBox(width: 8.0,),
                MSHCheckbox(
                    size: 20,
                    style: style,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(checkedColor: Colors.green),
                    value: widget.themeMode == ThemeMode.light, onChanged: (value){
                  print(value);
                  widget.themeMode = ThemeMode.light;
                  setState(() {
                  });
                  widget.mode("light");
                }),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: (){
            widget.themeMode = ThemeMode.dark;
            setState(() {
            });
            widget.mode("dark");
          },
          child: SizedBox(
            height: 80.0,
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.dark,style: Theme.of(context).textTheme.bodyMedium,),
                const SizedBox(width: 8.0,),
                MSHCheckbox(
                    size: 20,
                    style: style,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(checkedColor: Colors.green),
                    value: widget.themeMode == ThemeMode.dark, onChanged: (value){
                  print(value);
                  widget.themeMode = ThemeMode.dark;
                  setState(() {
                  });
                  widget.mode("dark");
                }),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: (){
            widget.themeMode = ThemeMode.system;
            setState(() {
            });
            widget.mode("system");
          },
          child: SizedBox(
            height: 80.0,
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.system,style: Theme.of(context).textTheme.bodyMedium,),
                const SizedBox(width: 8.0,),
                MSHCheckbox(
                    size: 20,
                    style: style,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(checkedColor: Colors.green),
                    value: widget.themeMode == ThemeMode.system, onChanged: (value){
                  print(value);
                  widget.themeMode = ThemeMode.system;
                  setState(() {
                  });
                  widget.mode("system");
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
