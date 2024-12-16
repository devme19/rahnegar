import 'package:flutter/material.dart';
import 'package:rahnegar/routes/route_names.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Add this package in pubspec.yaml
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroPageViewWidget extends StatefulWidget {
  const IntroPageViewWidget({super.key});

  @override
  State<IntroPageViewWidget> createState() => _IntroPageViewWidgetState();
}

class _IntroPageViewWidgetState extends State<IntroPageViewWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late List<PageViewItem> items;

 @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    items=[
      PageViewItem(path: "assets/images/intro/1.png", title: AppLocalizations.of(context)!.yourInformationIsEncrypted),
      PageViewItem(path: "assets/images/intro/2.png", title: AppLocalizations.of(context)!.weAreAlwaysWithYou),
      PageViewItem(path: "assets/images/intro/3.png", title: AppLocalizations.of(context)!.periodicServices),
      PageViewItem(path: "assets/images/intro/4.png", title: AppLocalizations.of(context)!.checkLight),
      PageViewItem(path: "assets/images/intro/5.png", title: AppLocalizations.of(context)!.whereIsYourDeviceNow),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width/2,
            child: PageView(
              controller: _pageController,
              reverse: true,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildPage(title: items[0].title,path: items[0].path),
                _buildPage(title: items[1].title,path: items[1].path),
                _buildPage(title: items[2].title,path: items[2].path),
                _buildPage(title: items[3].title,path: items[3].path),
                _buildPage(title: items[4].title,path: items[4].path),
              ],
            ),
          ),
          // Page Indicator
          const SizedBox(height: 100),
          AnimatedSmoothIndicator(
            count: 5,
            effect: const ScaleEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: Color(0xffF39200),
              dotColor: Color(0xffF39200),
            ),
            activeIndex: 4 - _currentPage,
          ),
          const SizedBox(height: 50),
          // Next/Previous Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap:  () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                          if(_currentPage == 4){
                            Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.mainPage, (Route<dynamic> route) => false);
                          }
                        }
                      ,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.next,
                      style: const TextStyle(color: Color(0xff00B2FF)),
                    ),
                  ),
                ),
                _currentPage>0? InkWell(
                  onTap: _currentPage > 0
                      ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.previous),
                  ),
                ):Container(),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPage({required String path,required String title}) {
    return
      Column(
      children: [
        Expanded(child: Image.asset(path)),
        const SizedBox(height: 32.0,),
        Text(title,textAlign: TextAlign.center,style: const TextStyle(fontSize: 20,color: Colors.black),)
      ],
          );
  }
}
class PageViewItem{
  final String path;
  final String title;
  PageViewItem({required this.path,required this.title});
}
