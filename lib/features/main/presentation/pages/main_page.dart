import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/blocs/car/car_bloc.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/pages/diagnostic/diagnostic_page.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/pages/home/home_page.dart';
import 'package:rahnegar/features/main/presentation/widgets/custom_bottom_navigation_bar_widget.dart';
import 'package:rahnegar/features/map/presentation/manager/bloc/blocs/map/map_bloc.dart';
import 'package:rahnegar/features/map/presentation/manager/bloc/page/map_page/widgets/neshan_map_widget.dart';
import 'package:rahnegar/features/map/presentation/manager/bloc/page/map_page/widgets/osm_map_widget.dart';
import 'package:rahnegar/features/setting/presentation/manager/bloc/pages/setting_page/setting_page.dart';
import 'package:rahnegar/locator.dart';
// import 'package:rahnegar/features/setting/presentation/manager/getx/pages/setting_page/setting_page.dart';
import '../../../../common/widgets/keep_alive_widget.dart';
import '../../../../theme/app_themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;
  PageController pageController = PageController(initialPage: 1);
  double borderWidth = 30.0;
  double width = 45.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration(seconds: 10)).then((onValue){
    //   setState(() {
    //     _selectedIndex=1;
    //   });
    // });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //       child: Scaffold(
  //           // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  //           bottomNavigationBar:
  //          CustomBottomNavigationBarWidget(
  //            selectedIndex: _selectedIndex,
  //            items: [
  //              CustomBottomNavItem(iconPath: "assets/images/main/location.png", label: "نقشه"),
  //              CustomBottomNavItem(iconPath: "assets/images/main/remote.png", label: "ریموت"),
  //              CustomBottomNavItem(iconPath: "assets/images/main/car1.png", label: "ماشین"),
  //
  //            ], onItemTapped: (int index) {
  //            setState(() {
  //              _selectedIndex = index;
  //            });
  //            pageController.jumpToPage(index);
  //            // pageController.animateToPage(
  //            //   index,
  //            //   duration: Duration(milliseconds: 500),
  //            //   curve: Curves.ease,
  //            // );
  //          },
  //          ),
  //           appBar: AppBar(
  //             automaticallyImplyLeading: false,
  //             // backgroundColor: Colors.white,
  //             title: Image.asset(
  //               'assets/images/home/rahnegar.png',
  //               width: 100.w,
  //               color: Theme.of(context).brightness == Brightness.light
  //                   ? Colors.white
  //                   : Colors.white54,
  //             ),
  //             centerTitle: true,
  //           ),
  //           body:
  //           PageView(
  //             controller: pageController,
  //             physics: const NeverScrollableScrollPhysics(),
  //             children: [
  //               KeepAliveWidget(
  //                 // child: Container(),
  //                 child: NeshanMapWidget(selectedIndex: _selectedIndex,),
  //               ),
  //               KeepAliveWidget(
  //                 child: HomePage(),
  //               ),
  //
  //               // DiagnosticPage(),
  //               KeepAliveWidget(child: SettingPage()),
  //
  //             ],
  //           )));
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        // drawer: Drawer(
        //   backgroundColor: Colors.red,
        //   child: ListView(
        //     children: [
        //       DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: Colors.blue,
        //         ),
        //         child: Text(
        //           'Menu',
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 24,
        //           ),
        //         ),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.home),
        //         title: Text('Home'),
        //         onTap: () {
        //           Navigator.pop(context); // Close the drawer
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.settings),
        //         title: Text('Settings'),
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.logout),
        //         title: Text('Logout'),
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: lightPrimaryColor,

          // leading: Builder(
          //     builder: (context) => IconButton(
          //           icon: Icon(Icons.menu,
          //               color: lightPrimaryColor), // Custom drawer icon color
          //           onPressed: () {
          //             Scaffold.of(context)
          //                 .openDrawer(); // Open the drawer manually
          //           },
          //         )),
          title: Image.asset(
            'assets/images/home/rahnegar.png',
            width: 100.w,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.white54,
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            // Main PageView content
            PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                KeepAliveWidget(
                  child: OsmMapWidget(selectedIndex: _selectedIndex,)
                  // NeshanMapWidget(selectedIndex: _selectedIndex),
                ),
                KeepAliveWidget(
                  child: HomePage(),
                ),
                KeepAliveWidget(
                  child: SettingPage(),
                ),
              ],
            ),

            // Custom Bottom Navigation Bar as a Positioned widget
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNavigationBarWidget(
                selectedIndex: _selectedIndex,
                items: [
                  CustomBottomNavItem(
                      iconPath: "assets/images/main/location.png",
                      label: AppLocalizations.of(context)!.map),
                  CustomBottomNavItem(
                      iconPath: "assets/images/main/remote.png",
                      label: AppLocalizations.of(context)!.remote),
                  CustomBottomNavItem(
                      iconPath: "assets/images/main/settings.png", label: AppLocalizations.of(context)!.settings),
                ],
                onItemTapped: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  pageController.jumpToPage(index);
                  // Uncomment this if you prefer animated navigation
                  // pageController.animateToPage(
                  //   index,
                  //   duration: Duration(milliseconds: 500),
                  //   curve: Curves.ease,
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
