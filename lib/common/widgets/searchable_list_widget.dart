import 'package:flutter/material.dart';
import 'package:rahnegar/theme/app_themes.dart';


class SearchableListWidget<T> extends StatefulWidget {
  SearchableListWidget({
    super.key,
    required this.items,
    required this.onSelect,
    required this.itemToString,
  });
  final List<T> items;
  Function(T) onSelect;
  final String Function(T) itemToString;
  @override
  State<SearchableListWidget<T>> createState() => _SearchableListWidgetState<T>();
}

class _SearchableListWidgetState<T> extends State<SearchableListWidget<T>> {
  final TextEditingController _searchController = TextEditingController();
  late List<T> filteredList;

  @override
  void initState() {
    super.initState();
    filteredList= widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Theme.of(context).brightness == Brightness.light? Colors.white:appBarDarkColor,
      child: Column(
        children: [
          TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close,color: Colors.red,))
            ),
            onChanged: (search){

              filteredList = widget.items
                  .where((item) => widget.itemToString(item).toLowerCase().contains(search.toLowerCase()))
                  .toList();
              print(filteredList.length);
              // filteredList = items
              //     .where((item) => item!.name!.startsWith(search))
              //     .toList();
              setState(() {
              });
            },
          ),
          Expanded(child: ListView.separated(

              itemCount: filteredList.length,
              separatorBuilder: (BuildContext context, int index) => Divider(height: 0.01,color:Theme.of(context).brightness == Brightness.dark? darkGrey!:Colors.grey.shade100),
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(widget.itemToString(filteredList[index])),
                  onTap: (){
                    Navigator.of(context).pop();
                    widget.onSelect(filteredList[index]);
                  },
                );
              }))
        ],
      ),
    );
  }
}

