import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rahnegar/common/widgets/my_button.dart';
class DateTimePickerWidget extends StatefulWidget {
  DateTimePickerWidget({super.key,required this.onSubmit});
  Function(String startDate, String endDate) onSubmit;

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startDate = AppLocalizations.of(context)!.startDate;
    endDate = AppLocalizations.of(context)!.endDate;
  }

  String startDate = "";
  String endDate = "";
  bool isExpand = false;
  @override
  Widget build(BuildContext context) {
    return
      AnimatedContainer(
        color:Theme.of(context).brightness==Brightness.dark?Colors.black54:Colors.white.withOpacity(0.65),
        // padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        height: isExpand?200: 70,
        duration: const Duration(milliseconds: 150),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  isExpand = !isExpand;
                });
                if(isExpand){
                }
              },
              child:
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.selectATimeFrame,style: Theme.of(context).textTheme.bodyLarge,),
                    AnimatedSwitcher(
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      duration: const Duration(milliseconds: 500),
                      child: Icon(
                        !isExpand ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                        key: ValueKey<bool>(isExpand),
                        size: 25,
                        // color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: isExpand?true:false,
                child:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child:
                            MyButton(color: Colors.green, text: startDate, onTap: ()
                            async{
                              // Jalali? picked = await showPersianDatePicker(
                              //     context: context,
                              //     initialDate: Jalali.now(),
                              //     firstDate: Jalali(1385, 8),
                              //     lastDate: Jalali(1450, 9),
                              //     // initialEntryMode:
                              //     // PDatePickerEntryMode.calendarOnly,
                              //     // initialDatePickerMode: PDatePickerMode.year,
                              //
                              //     // builder: (context, child) {
                              //     //   return Theme(
                              //     //     data: ThemeData(
                              //     //       dialogTheme: const DialogTheme(
                              //     //         shape: RoundedRectangleBorder(
                              //     //           borderRadius: BorderRadius.all(
                              //     //               Radius.circular(0)),
                              //     //         ),
                              //     //       ),
                              //     //       fontFamily: 'iranYekan'
                              //     //     ),
                              //     //     child: child!,
                              //     //   );
                              //     // });
                              // if (picked != null ) {
                              //   // print(picked.toJalaliDateTime());
                              //   // setState(() {
                              //   //
                              //   //   final s = picked.formatCompactDate();
                              //   //   startDate = s.replaceAll('/', '-');
                              //   // });
                              //
                              //   final timePicked = await showPersianTimePicker(context: context, initialTime: TimeOfDay.now(),);
                              //   startDate = '${picked.formatCompactDate().replaceAll('/', '-')} ${timePicked!.hour}:${timePicked.minute}:00';
                              //   print(startDate);
                              //   setState(() {
                              //   });
                              // }
                            }
                            )),
                            const SizedBox(width: 16.0,),
                            Expanded(child:
                            MyButton(color: Colors.green, text: endDate, onTap: ()async{
                            })),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0,),
                      Expanded(
                        flex: 1,
                          child: MyButton(color: Colors.blue, text: AppLocalizations.of(context)!.submit, onTap: (){
                          widget.onSubmit(startDate,endDate);
                      })),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }


}