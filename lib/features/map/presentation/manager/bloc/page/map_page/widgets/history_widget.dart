import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rahnegar/common/widgets/custom_button.dart';
import 'package:rahnegar/common/widgets/my_button.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isExpand = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black54
          : Colors.white,
      width: double.infinity,
      height: isExpand ? 320 : 70,
      duration: const Duration(milliseconds: 150),
      child: Column(
        children: [
          SizedBox(
            height: 70,
            child:
            GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy < 0) {
                    setState(() {
                      isExpand = true;
                    });
                  } else if (details.delta.dy > 0) {
                    setState(() {
                      isExpand = false;
                    });
                  }
                },
              onTap: (){
                setState(() {
                  isExpand = !isExpand;
                });
              },
              child:
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.historyOfRoutes,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      // AnimatedSwitcher(
                      //   transitionBuilder:
                      //       (Widget child, Animation<double> animation) {
                      //     return ScaleTransition(scale: animation, child: child);
                      //   },
                      //   duration: const Duration(milliseconds: 500),
                      //   child: InkWell(
                      //     onTap: ()=> setState(() {
                      //       isExpand = !isExpand;
                      //     }),
                      //     child: Container(
                      //       color: Colors.red,
                      //       child: Icon(
                      //         isExpand
                      //             ? Icons.keyboard_arrow_down
                      //             : Icons.keyboard_arrow_up,
                      //         key: ValueKey<bool>(isExpand),
                      //         size: 25,
                      //         // color: Colors.grey,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isExpand)
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  setState(() {
                    isExpand = false;
                  });
                }
              },
              child:
              Column(children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            print("Custom TextButton pressed");
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black, // Text color
                            backgroundColor: Colors.white70,
                            side: BorderSide(color: Colors.grey.shade300, width: 1),
                            padding: const EdgeInsets.all(20.0),
                          ),
                          child: Text(AppLocalizations.of(context)!.minutesAgo,style: Theme.of(context).textTheme.bodySmall,),
                        ),
                        TextButton(
                          onPressed: () {
                            print("Custom TextButton pressed");
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black, // Text color
                            backgroundColor: Colors.white70,
                            side: BorderSide(color: Colors.grey.shade300, width: 1),
                            padding: const EdgeInsets.all(20.0),
                          ),
                          child: Text(AppLocalizations.of(context)!.hoursAgo,style: Theme.of(context).textTheme.bodySmall,),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            print("Custom TextButton pressed");
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black, // Text color
                            backgroundColor: Colors.white70,
                            side: BorderSide(color: Colors.grey.shade300, width: 1),
                            padding: const EdgeInsets.all(20.0),
                          ),
                          child: Text(AppLocalizations.of(context)!.startDate,style: Theme.of(context).textTheme.bodySmall,),
                        ),
                        TextButton(
                          onPressed: () {
                            print("Custom TextButton pressed");
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black, // Text color
                            backgroundColor: Colors.white70,
                            side: BorderSide(color: Colors.grey.shade300, width: 1),
                            padding: const EdgeInsets.all(20.0),
                          ),
                          child: Text(AppLocalizations.of(context)!.endDate,style: Theme.of(context).textTheme.bodySmall,),
                        ),
                      ],
                    ),
                  ),
                ),
              ],)
            ),
          )
        ],
      ),
    );
  }
}
