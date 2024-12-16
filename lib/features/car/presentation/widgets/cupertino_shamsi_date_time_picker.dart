import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CupertinoShamsiDateTimePicker extends StatefulWidget {
  const CupertinoShamsiDateTimePicker({super.key});

  @override
  State<CupertinoShamsiDateTimePicker> createState() => _CupertinoShamsiDateTimePickerState();
}

class _CupertinoShamsiDateTimePickerState extends State<CupertinoShamsiDateTimePicker> {
  Jalali selectedDate = Jalali.now();
  int selectedHour = 0;
  int selectedMinute = 0;

  void _showDateTimePicker() async {
    Jalali tempDate = selectedDate;
    int tempHour = selectedHour;
    int tempMinute = selectedMinute;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Year Picker
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                      initialItem: tempDate.year - 1300),
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      tempDate = tempDate.copy(year: index + 1300);
                    });
                  },
                  children: List.generate(
                    150, // For years 1300 to 1450
                        (index) => Center(
                      child: Text(
                        (index + 1300).toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),

              // Month Picker
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                      initialItem: tempDate.month - 1),
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      tempDate = tempDate.copy(month: index + 1);
                    });
                  },
                  children: List.generate(
                    12,
                        (index) => Center(
                      child: Text(
                        Jalali(1400, index + 1, 1)
                            .formatter
                            .mN, // Persian month name
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),

              // Day Picker
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                      initialItem: tempDate.day - 1),
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      tempDate = tempDate.copy(day: index + 1);
                    });
                  },
                  children: List.generate(
                    tempDate.monthLength,
                        (index) => Center(
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),

              // Hour Picker
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                      initialItem: tempHour),
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      tempHour = index;
                    });
                  },
                  children: List.generate(
                    24,
                        (index) => Center(
                      child: Text(
                        index.toString().padLeft(2, '0'),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),

              // Minute Picker
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                      initialItem: tempMinute),
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      tempMinute = index;
                    });
                  },
                  children: List.generate(
                    60,
                        (index) => Center(
                      child: Text(
                        index.toString().padLeft(2, '0'),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),

              // Confirm Button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedDate = tempDate;
                    selectedHour = tempHour;
                    selectedMinute = tempMinute;
                  });
                  Navigator.pop(context);
                },
                child: const Text("Confirm"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shamsi DateTime Picker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Selected: ${selectedDate.year}/${selectedDate.month}/${selectedDate.day} "
                  "${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showDateTimePicker,
              child: const Text("Pick Date-Time"),
            ),
          ],
        ),
      ),
    );
  }
}
