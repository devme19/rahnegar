import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rahnegar/features/setting/presentation/manager/bloc/blocs/locale_cubit.dart';
import 'package:rahnegar/features/setting/presentation/manager/widgets/change_theme_widget.dart';
import 'package:rahnegar/features/setting/presentation/manager/widgets/language_widget.dart';
import 'package:rahnegar/routes/route_names.dart';
import 'package:rahnegar/theme/bloc/theme_cubit.dart';

class SettingPage extends StatefulWidget {
  SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<String> menu = [];
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    menu = [
      AppLocalizations.of(context)!.myProfile,
      AppLocalizations.of(context)!.myCars,
      AppLocalizations.of(context)!.historyOfRoutes,
      AppLocalizations.of(context)!.language,
      AppLocalizations.of(context)!.theme,
      AppLocalizations.of(context)!.aboutUs,
      AppLocalizations.of(context)!.contactUs,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, index) => Divider(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black12
            : Colors.grey.shade100,
        height: 0.5,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          tileColor: Theme.of(context).listTileTheme.tileColor,
          onTap: () {
            switch (index) {
              case 0:
                Navigator.of(context).pushNamed(RouteNames.userInfoPage,
                    arguments: {"isSetting": true});
              case 1:
                Navigator.of(context).pushNamed(RouteNames.addCarPage,
                    arguments: {"isSetting": true});
              case 2:
              // Get.toNamed(RouteNames.routeHistoryPage);
            }
          },
          subtitle: subTitle(index),
          title: Text(menu[index]),
        );
      },
      itemCount: menu.length,
    );
  }

  Widget subTitle(int index) {
    switch (index) {
      case 3:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, localeState) {
              return LanguageWidget(
                isPersianLocale: localeState.locale ==
                    const Locale('fa', 'IR'),
                isPersian: (isPersian) {
                  if (isPersian) {
                    BlocProvider.of<LocaleCubit>(context).changeLocale(languageCode: "fa", countryCode: "IR");
                  } else {
                    BlocProvider.of<LocaleCubit>(context).changeLocale(languageCode: "en", countryCode: "US");
                  }
                },
              );
            },
          ),
        );
      case 4:
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: ThemeWidget(
                themeMode: themeState.themeMode,
                mode: (mode) {
                  BlocProvider.of<ThemeCubit>(context).changeTheme(mode: mode,languageCode: Localizations.localeOf(context).languageCode);
                },
              ),
            );
          },
        );
      default:
        return Container();
    }
  }
}