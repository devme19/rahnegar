import 'package:flutter/material.dart';


class CustomBottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final List<CustomBottomNavItem> items;

  const CustomBottomNavigationBarWidget({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: 0
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          int index = entry.key;
          CustomBottomNavItem item = entry.value;
          bool isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onItemTapped(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: isSelected?const Color(0xffF39200):Colors.transparent
                    ),
                    child: Image.asset(item.iconPath,height: 30.0,width: 30.0,)),
                SizedBox(height: 4.0,),
                Text(
                  item.label,
                  style: TextStyle(
                    color: isSelected ? Color(0xffF39200) : Colors.grey,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Model for Navigation Items
class CustomBottomNavItem {
  final String iconPath;
  final String label;

  const CustomBottomNavItem({required this.iconPath, required this.label});
}