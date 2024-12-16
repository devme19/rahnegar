import 'package:flutter/material.dart';

class FaultWidget extends StatefulWidget {
  FaultWidget({super.key,required int selectedIndex}){
    if(selectedIndex == 1) {
      print("fault");
    }
  }

  @override
  State<FaultWidget> createState() => _FaultWidgetState();
}

class _FaultWidgetState extends State<FaultWidget> {
  List<Item> items=[
    Item(title: "fault 1", value: 1),
    Item(title: "fault 2", value: 2),
    Item(title: "fault 3", value: 3),
    Item(title: "fault 4", value: 4),
    Item(title: "fault 5", value: 5),
    Item(title: "fault 6", value: 6),
    Item(title: "fault 7", value: 7),
    Item(title: "fault 8", value: 8),
    Item(title: "fault 9", value: 9),
    Item(title: "fault 10", value: 10),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(items[index].title),
              subtitle: Text(items[index].value.toString()),
            );
          }),
    );
  }
}
class Item{
  String title;
  double value;

  Item({required this.title,required this.value});

}