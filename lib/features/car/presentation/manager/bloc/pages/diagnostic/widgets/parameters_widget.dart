import 'package:flutter/material.dart';

class ParametersWidget extends StatefulWidget {
  ParametersWidget({super.key,required int selectedIndex}){
    if(selectedIndex == 0) {
      print("parameter");
    }
  }

  @override
  State<ParametersWidget> createState() => _ParametersWidgetState();
}

class _ParametersWidgetState extends State<ParametersWidget> {
  List<Item> items=[
    Item(title: "title1", value: 1),
    Item(title: "title2", value: 2),
    Item(title: "title3", value: 3),
    Item(title: "title4", value: 4),
    Item(title: "title5", value: 5),
    Item(title: "title6", value: 6),
    Item(title: "title7", value: 7),
    Item(title: "title8", value: 8),
    Item(title: "title9", value: 9),
    Item(title: "title10", value: 10),
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
