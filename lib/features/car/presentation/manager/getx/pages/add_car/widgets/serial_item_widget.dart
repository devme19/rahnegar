import 'package:flutter/material.dart';

class SerialItemWidget extends StatelessWidget {
  SerialItemWidget({super.key,required this.serialNumber,required this.onDeleteTap,required this.color});
  String serialNumber;
  Function(String) onDeleteTap;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Expanded(child: Text(serialNumber,maxLines: 1,overflow: TextOverflow.ellipsis,)),
        InkWell(
          child: Icon(Icons.delete,color: Colors.red,),
          onTap: ()=>onDeleteTap(serialNumber),
        )
      ],),
    );
  }
}
