import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/model/production_year_model.dart';
import '../../../../theme/app_themes.dart';


class ProductionYearBottomSheet extends StatefulWidget {
  ProductionYearBottomSheet({super.key, required this.onSelect}) {

  }
  Function(ProductionYearModel) onSelect;

  @override
  State<ProductionYearBottomSheet> createState() => _ProductionYearBottomSheetState();
}

class _ProductionYearBottomSheetState extends State<ProductionYearBottomSheet> {
  TextEditingController productionYearController = TextEditingController();

  List<ProductionYearModel> yearsList = [];

  List<ProductionYearModel> items = [];


  // @override
  // void initState() {
  //   super.initState();
  //   initYears(context);
  // }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    initYears(context);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        color: Theme.of(context).brightness == Brightness.light? Colors.white:appBarDarkColor,
        child: Column(
          children: [
            TextFormField(
              controller: productionYearController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ))),
              onChanged: (search) {
                items = yearsList
                    .where((year) =>
                        year.jalaliYear.startsWith(search) ||
                        year.georgianYear.startsWith(search))
                    .toList();
                setState(() {});
              },
            ),
            Expanded(
                child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (BuildContext context, int index) => Divider(height: 0.01,color: Theme.of(context).brightness == Brightness.light?Colors.grey.shade100: darkGrey!,),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            '${items[index].jalaliYear} - ${items[index].georgianYear}'),
                        onTap: () {
                          Navigator.of(context).pop();
                          widget.onSelect(items[index]);
                        },
                      );
                    }))
          ],
        ),
      );
    });
  }

  initYears(context) {
    int currentYear = DateTime.now().year;
    int georgianSpecificYear = 1987;
    int jalaliSpecificYear = 1366;
    int differenceInYears = currentYear - georgianSpecificYear;
    yearsList.add(ProductionYearModel(
        jalaliYear: '${AppLocalizations.of(context)!.before} $jalaliSpecificYear',
        georgianYear: '${AppLocalizations.of(context)!.before} $georgianSpecificYear'));
    for (int i = 0; i < differenceInYears + 1; i++) {
      yearsList.add(ProductionYearModel(
          jalaliYear: (jalaliSpecificYear + i).toString(),
          georgianYear: (georgianSpecificYear + i).toString()));
    }
    yearsList = yearsList.reversed.toList();
    items = yearsList;
  }
}


