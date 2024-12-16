import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/pages/diagnostic/widgets/fault_widget.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/pages/diagnostic/widgets/parameters_widget.dart';

class DiagnosticPage extends StatefulWidget {
  const DiagnosticPage({super.key});

  @override
  State<DiagnosticPage> createState() => _DiagnosticPageState();
}

class _DiagnosticPageState extends State<DiagnosticPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: _selectedIndex);

    // Listen for tab index changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedIndex = _tabController.index;
        });
        // Jump to the new page in PageView when tab changes
        _pageController.jumpToPage(_selectedIndex);
        print("Tab changed to index: $_selectedIndex");
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TabBar with custom TabController
        TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: [
            Tab(text: AppLocalizations.of(context)!.parameter),
            Tab(text: AppLocalizations.of(context)!.fault),
          ],
        ),
        // Expanded TabBarView that includes a PageView for swipe detection
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
                _tabController.index = _selectedIndex;  // Update TabController index on swipe
              });
              print("Page changed to index: $_selectedIndex");
            },
            children: [
              ParametersWidget(selectedIndex: _selectedIndex),
              FaultWidget(selectedIndex: _selectedIndex),
            ],
          ),
        ),
      ],
    );
  }
}
