import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomSwitch({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: 70.0,
        height: 30.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: widget.value ? Colors.green : Colors.red,
        ),
        child: Stack(
          children: [
            Align(
              alignment:widget.value ? Alignment.centerLeft:Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(widget.value?AppLocalizations.of(context)!.yes:AppLocalizations.of(context)!.no,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)),
                )),
            AnimatedAlign(
              alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Container(
                width: 25.0,
                height: 25.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
