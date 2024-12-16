import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CupertinoDateTimePickerWidget extends StatefulWidget {
  Jalali? persianSelectedDate;
  DateTime? georgianSelectedDate;
  int? selectedHour;
  int? selectedMinute;
  bool? isChecked;
  final Function(DateTimeModel) onChecked;

  CupertinoDateTimePickerWidget({
    super.key,
    Jalali? persianSelectedDate,
    DateTime? georgianSelectedDate,
    int? selectedHour,
    int? selectedMinute,
    bool? isChecked,
    required this.onChecked
  })  : persianSelectedDate = persianSelectedDate ?? Jalali.now(),
        georgianSelectedDate = georgianSelectedDate ?? DateTime.now(),
        selectedHour = selectedHour ?? 0,
        selectedMinute = selectedMinute ?? 0,
        isChecked = isChecked ?? false;

  @override
  State<CupertinoDateTimePickerWidget> createState() =>
      _CupertinoDateTimePickerWidgetState();
}

class _CupertinoDateTimePickerWidgetState
    extends State<CupertinoDateTimePickerWidget> {
  Jalali? persianTempDate;
  DateTime? georgianTempDate;
  int? tempHour;
  int? tempMinute;
  bool isChecked = false;

  // Get the current locale
  late Locale currentLocale;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    currentLocale = Localizations.localeOf(context);
    if (currentLocale.languageCode == 'fa') {
      persianTempDate = widget.persianSelectedDate;
      persianTempDate = persianTempDate!.copy(hour: widget.selectedHour,minute: widget.selectedMinute);
    } else {
      georgianTempDate = widget.georgianSelectedDate;
      georgianTempDate = georgianTempDate!.copyWith(hour:widget.selectedHour,minute: widget.selectedMinute);
    }
    tempHour = widget.selectedHour;
    tempMinute = widget.selectedMinute;
    isChecked = widget.isChecked!;

  }

  String _georgianMonthNames(int index) {
    const List<String> georgianMonths = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return georgianMonths[index];
  }

  int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            // Minute Picker
            Expanded(
              child: CupertinoPicker(
                scrollController:
                    FixedExtentScrollController(initialItem: tempMinute!),
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    tempMinute = index;
                    if (currentLocale.languageCode == "fa") {
                      persianTempDate =
                          persianTempDate!.copy(minute: tempMinute);
                    } else {
                      georgianTempDate =
                          georgianTempDate!.copyWith(minute: tempMinute);
                    }
                  });
                  if(isChecked){
                    onDateChange();
                  }
                },
                children: List.generate(
                  60,
                  (index) => Center(
                    child: Text(
                      index.toString().padLeft(2, '0'),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            ),
            // Hour Picker
            Expanded(
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: tempHour!),
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    tempHour = index;
                  });
                  if (currentLocale.languageCode == "fa") {
                    persianTempDate =
                        persianTempDate!.copy(hour: tempHour);
                  } else {
                    georgianTempDate =
                        georgianTempDate!.copyWith(hour: tempHour);
                  }
                  if(isChecked){
                    onDateChange();
                  }
                },
                children: List.generate(
                  24,
                  (index) => Center(
                    child: Text(
                      index.toString().padLeft(2, '0'),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0,),
            // Day Picker
            Expanded(
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                    initialItem: currentLocale.languageCode == "fa"
                        ? persianTempDate!.day-1
                        : georgianTempDate!.day - 1),
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    if (currentLocale.languageCode == "fa") {
                      persianTempDate =
                          persianTempDate!.copy(day: index + 1);
                    } else {
                      georgianTempDate =
                          georgianTempDate!.copyWith(day: index + 1);
                    }
                  });
                  if(isChecked){
                    onDateChange();
                  }
                },
                children: List.generate(
                  currentLocale.languageCode == "fa"
                      ? persianTempDate!.monthLength
                      : getDaysInMonth(georgianTempDate!.year,
                          georgianTempDate!.month),
                  (index) => Center(
                    child: Text(
                      (index + 1).toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            ),
            // Month Picker
            Expanded(
              flex: 2,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                    initialItem: currentLocale.languageCode == "fa"
                        ? persianTempDate!.month - 1
                        : georgianTempDate!.month - 1),
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    if (currentLocale.languageCode == "fa") {
                      // Update Persian temp date
                      Jalali date = persianTempDate!;
                      date = date.copy(day: 1, month: index + 1);
                      if (persianTempDate!.day > date.monthLength) {
                        persianTempDate = persianTempDate!.copy(
                            day: date.monthLength, month: index + 1);
                      } else {
                        persianTempDate =
                            persianTempDate!.copy(month: index + 1);
                      }
                    } else {
                      // Update Georgian temp date
                      georgianTempDate =
                          georgianTempDate!.copyWith(month: index + 1);

                      // Ensure the selected day is valid for the new month
                      int daysInMonth = getDaysInMonth(
                          georgianTempDate!.year,
                          georgianTempDate!.month);
                      if (georgianTempDate!.day > daysInMonth) {
                        georgianTempDate =
                            georgianTempDate!.copyWith(day: daysInMonth);
                      }
                    }
                  });
                  if(isChecked){
                    onDateChange();
                  }
                },
                children: List.generate(
                  12,
                  (index) => Center(
                    child: Text(
                      currentLocale.languageCode == 'fa'
                          ? Jalali(1400, index + 1, 1)
                              .formatter
                              .mN // Persian month name
                          : _georgianMonthNames(
                              index), // Georgian month name
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            ),
            // Year Picker
            Expanded(
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                    initialItem: currentLocale.languageCode == 'fa'
                        ? persianTempDate!.year - 1403
                        : georgianTempDate!.year - 2024),
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    if (currentLocale.languageCode == 'fa') {
                      Jalali date = persianTempDate!;
                      date = date.copy(day: 1, year: index + 1403);
                      if (persianTempDate!.day > date.monthLength) {
                        persianTempDate = persianTempDate!.copy(
                            year: index + 1403, day: date.monthLength);
                      } else {
                        persianTempDate =
                            persianTempDate!.copy(year: index + 1403);
                      }
                    } else {
                      georgianTempDate =
                          georgianTempDate!.copyWith(year: index + 2024);

                      // Update the day if necessary
                      int daysInMonth = getDaysInMonth(
                          georgianTempDate!.year,
                          georgianTempDate!.month);
                      if (georgianTempDate!.day > daysInMonth) {
                        georgianTempDate =
                            georgianTempDate!.copyWith(day: daysInMonth);
                      }
                    }
                  });
                  if(isChecked){
                    onDateChange();
                  }
                },
                children: List.generate(
                  50, // For years 1300 to 1450 (for Jalali)
                  (index) => Center(
                    child: Text(
                      currentLocale.languageCode == 'fa'
                          ? (index + 1403).toString()
                          : (index + 2024).toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  isChecked=!isChecked;
                });
                if(isChecked){
                  onDateChange();
                }else{
                  widget.onChecked(DateTimeModel(
                    year: 0,
                  ));
                }
              },
              child: Animate(
                  effects: const [FadeEffect()],
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                        child: Image.asset(
                      "assets/images/home/check.png",
                      width: 30,
                          color: isChecked?const Color(0xffF39200):Colors.white,
                    )),
                  )),
            )
          ],
        ),
      ),
    );
  }
  onDateChange(){
    if(currentLocale.languageCode == 'fa')
    {
      widget.onChecked(DateTimeModel(
        year: persianTempDate!.year,
        month: persianTempDate!.month,
        day: persianTempDate!.day,
        hour: persianTempDate!.hour,
        minute: persianTempDate!.minute,
      ));
    }else{
      widget.onChecked(DateTimeModel(
        year: georgianTempDate!.year,
        month: georgianTempDate!.month,
        day: georgianTempDate!.day,
        hour: georgianTempDate!.hour,
        minute: georgianTempDate!.minute,
      ));
    }
  }
}
class DateTimeModel{
  int? year;
  int? month;
  int? day;
  int? hour;
  int? minute;

  DateTimeModel({this.year, this.month, this.day, this.hour, this.minute});
}
