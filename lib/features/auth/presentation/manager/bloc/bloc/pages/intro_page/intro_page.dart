import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rahnegar/common/widgets/back_ground.dart';
import 'package:rahnegar/features/auth/presentation/manager/bloc/bloc/widgets/intro_page_view_widget.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return BackGroundWidget(
      widget:
      Align(
        alignment: Alignment.center,
          child: SizedBox(
            height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              child: const IntroPageViewWidget())),
    );
  }
}
