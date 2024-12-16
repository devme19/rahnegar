import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:rahnegar/common/widgets/my_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rahnegar/features/map/domain/entity/all_marked_location_entity.dart';

import '../../../../../../../../common/widgets/my_text_form_field.dart';
import '../../../../../../../../theme/app_themes.dart';

class LocationToMarkWidget extends StatefulWidget {
  LocationToMarkWidget({super.key,this.point,required this.onSubmit,required this.onCancel});
  GeoPoint? point;
  Function(Data) onSubmit;
  Function onCancel;
  @override
  State<LocationToMarkWidget> createState() => _LocationToMarkWidgetState();
}

class _LocationToMarkWidgetState extends State<LocationToMarkWidget> {

  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:
      Center(
        child: Container(
          height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Theme.of(context).brightness == Brightness.light?Colors.white:Colors.black,
          ),
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),

          child: Column(

            children: [
              Text(AppLocalizations.of(context)!.addToMarkedList),
            SizedBox(height: 16.0,),
            TextFormField(
              controller: nameController,
              style: Theme.of(context).textTheme.bodyMedium,
              showCursor: false,
              textInputAction: TextInputAction.done,
              decoration: MyTextFormField(
                  labelText: AppLocalizations.of(context)!.name,
                  context: context,
                  borderColor: Colors.transparent,
                  fillColor: Theme.of(context).brightness == Brightness.light? Colors.grey.shade100:appBarDarkColor!,
                  textColor: Theme.of(context).brightness == Brightness.light?Colors.black:Colors.white70
              ).decoration(),
            ),
              SizedBox(height: 32.0,),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: MyButton(color: Colors.green, text: AppLocalizations.of(context)!.submit, onTap: (){
                    Data location = Data(name: nameController.text,longitude: widget.point!.longitude,latitude: widget.point!.latitude);
                    widget.onSubmit(location);
                    Get.back();
                  }),
                ),
                SizedBox(width: 16.0,),
                Expanded(
                  child: MyButton(color: Colors.red, text: AppLocalizations.of(context)!.cancel, onTap: (){
                    widget.onCancel;
                    Get.back();
                  }),
                )
              ],
            )
          ],),
        ),
      ),
    );
  }
}
