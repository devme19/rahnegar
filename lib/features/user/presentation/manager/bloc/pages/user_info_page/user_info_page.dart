import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahnegar/common/widgets/background_widget.dart';
import 'package:rahnegar/features/user/data/models/province_model.dart';
import 'package:rahnegar/features/user/presentation/manager/bloc/blocs/user_bloc.dart';
import 'package:rahnegar/locator.dart';
import 'package:rahnegar/routes/route_names.dart';

import '../../../../../../../common/utils/failure_action.dart';
import '../../../../../../../common/widgets/my_button.dart';
import '../../../../../../../common/widgets/my_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../common/widgets/searchable_list_widget.dart';
import '../../../../../../../theme/app_themes.dart';
import '../../../../../../../common/widgets/spacer_with_message_widget.dart';



class UserInfoPage extends StatefulWidget {
  UserInfoPage({super.key,this.isSetting=true});
  bool isSetting;

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late List<ProvinceModel> provinces;
  late ProvinceModel selectedProvince;
  late Cities selectedCity;
  bool onValidate = false;
  double spaceBetween = 26.0;
  double cardHeight = 430;
  int startAnimateTime = 500;
  int timeOffset = 100;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadJsonFromAsset("assets/data/iran_province_city.json").then((values) {
      // provinces = values;
      provinces = values;
    });
    if(widget.isSetting){
      //getUserInfo
      locator<UserBloc>().add(GetUserInfoEvent());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedProvince = ProvinceModel(name: ' ');
    selectedCity = Cities(name: ' ');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is FailureState) {
            failureDialog(state.failure, context);
          } else if (state is SuccessState) {
            print("success");
            if(!widget.isSetting) {
              Navigator.of(context).pushNamed(RouteNames.addCarPage);
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!
                  .userInfoUpdatedSuccessfully)));
            }
          }
          else if(state is GetUserInfoSuccess){
            firstNameController.text = state.userEntity.data!.firstName!;
            lastNameController.text = state.userEntity.data!.lastName!;
            for(int i=0;i<provinces.length;i++){
              if(provinces[i].name == state.userEntity.data!.state!){
                selectedProvince = ProvinceModel(name: provinces[i].name);
                break;
              }
            }
            // final k = provinces.firstWhere((obj)=>obj.name == state.userEntity.data!.state!);
            selectedCity.name = state.userEntity.data!.city!;
            setState(() {
            });
          }else if(state is FailureState){
            failureDialog(state.failure, context);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: lightPrimaryColor,
            title: Text(AppLocalizations.of(context)!.myProfile,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),),
          ),
          body:
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color:Colors.grey.shade300,width: 0.5)
                        ),
                        child:
                        Animate(
                          delay: Duration(milliseconds: startAnimateTime+timeOffset),
                          effects: const [FadeEffect(),],
                          child: SizedBox(
                            height: cardHeight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 32.0, right: 32.0, top: 32.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(AppLocalizations.of(context)!.detailsOfTheCarOwner,style: Theme.of(context).textTheme.headlineMedium,)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 32.0,
                                  ),
                                  Animate(
                                    delay: Duration(milliseconds: startAnimateTime+timeOffset*2),
                                    effects: const [FadeEffect(),],
                                    child: TextFormField(
                                      controller: firstNameController,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:  Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white),
                                      showCursor: false,
                                      onChanged: (value){
                                        setState(() {

                                        });
                                      },
                                      // validator: (value){
                                      //   if (value == null || value.isEmpty) {
                                      //     return AppLocalizations.of(context)!.enterName;
                                      //   }
                                      //   return null;
                                      // },
                                      textInputAction: TextInputAction.next,
                                      decoration: MyTextFormField(
                                          labelText: AppLocalizations.of(context)!.name,
                                          context: context,
                                          borderColor: Colors.transparent,
                                          fillColor: Theme.of(context).brightness == Brightness.light? Colors.grey.shade100:appBarDarkColor!,
                                          textColor: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white
                                      ).decoration(),
                                    ),
                                  ),
                                  SpacerWithMessageWidget(
                                      fontSize: 12.sp,
                                      height: spaceBetween, showMessage:
                                  onValidate&&(firstNameController.text.isEmpty),
                                      message: AppLocalizations.of(context)!.enterName),
                                  Animate(
                                    delay: Duration(milliseconds: startAnimateTime+timeOffset*3),
                                    effects: const [FadeEffect()],
                                    child: TextFormField(
                                      controller: lastNameController,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:  Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white),
                                      showCursor: false,
                                      onChanged: (value){
                                        setState(() {
                                        });
                                      },
                                      // validator: (value){
                                      //   if (value == null || value.isEmpty) {
                                      //     return AppLocalizations.of(context)!.enterLName;
                                      //   }
                                      //   return null;
                                      // },
                                      textInputAction: TextInputAction.done,
                                      decoration: MyTextFormField(
                                          labelText: AppLocalizations.of(context)!.lastName,
                                          context: context,
                                          borderColor: Colors.transparent,
                                          fillColor:Theme.of(context).brightness == Brightness.light? Colors.grey.shade100:appBarDarkColor!,
                                          textColor:  Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white
                                      ).decoration(),
                                    ),
                                  ),
                                  SpacerWithMessageWidget(
                                      fontSize: 12.sp,
                                      height: spaceBetween, showMessage:
                                  onValidate&&(lastNameController.text.isEmpty),
                                      message: AppLocalizations.of(context)!.enterLName),
                                  Animate(
                                    delay: Duration(milliseconds: startAnimateTime+timeOffset*4),
                                    effects: const [FadeEffect(),],
                                    child: MyButton(
                                      color: Theme.of(context).brightness == Brightness.light? Colors.grey.shade300:appBarDarkColor! ,
                                      text: AppLocalizations.of(context)!.state,
                                      text2: selectedProvince.name!,
                                      textColor2: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white,
                                      onTap: () {
                                        showModalBottomSheet(context: context, builder: (context){
                                          return  SearchableListWidget<ProvinceModel>(
                                            items: provinces,
                                            itemToString: (item) => item.name!,
                                            onSelect: (selectedItem) {
                                              selectedProvince = selectedItem;
                                              selectedCity = Cities(name: ' ');
                                              setState(() {});
                                            },
                                          );
                                        });

                                      },
                                      textColor: Colors.black,
                                    ),
                                  ),
                                  SpacerWithMessageWidget(
                                      fontSize: 12.sp,
                                      height: spaceBetween, showMessage:
                                  onValidate&&(!validateProvince()),
                                      message: AppLocalizations.of(context)!.selectState),
                                  Animate(
                                    delay: Duration(milliseconds: startAnimateTime+timeOffset*5),
                                    effects: const [FadeEffect(),],
                                    child: MyButton(
                                      color: Theme.of(context).brightness == Brightness.light? Colors.grey.shade300:appBarDarkColor! ,
                                      text: AppLocalizations.of(context)!.city,
                                      text2: selectedCity.name!,
                                      textColor2: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white,
                                      onTap: () {
                                        if(selectedProvince.name!.isEmpty || selectedProvince.name! == ' '){
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!
                                              .selectState)));

                                        }else {
                                          showModalBottomSheet(context: context, builder: (builder){
                                            return  SearchableListWidget<Cities>(
                                              items: selectedProvince.cities!,
                                              itemToString: (item) => item.name!,
                                              onSelect: (selectedItem) {
                                                selectedCity = selectedItem;
                                                setState(() {});
                                              },
                                            );
                                          });
                                        }
                                      },
                                      textColor: Colors.black,
                                    ),
                                  ),
                                  SpacerWithMessageWidget(
                                      fontSize: 12.sp,
                                      height: spaceBetween, showMessage:
                                  onValidate&&(!validateCity()),
                                      message: AppLocalizations.of(context)!.selectCity),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child:
                    Row(
                      children: [
                        widget.isSetting?
                        Expanded(
                          child: Animate(
                            delay: Duration(milliseconds: startAnimateTime+timeOffset*6),
                            effects: const [ScaleEffect()],
                            child: TextButton.icon(
                              onPressed: (){
                                onValidate = true;
                                setState(() {
                                });
                                if( _formKey.currentState!.validate()){
                                  if((validateCity())&&(validateProvince())) {
                                    Map<String,dynamic> body={
                                      'first_name':firstNameController.text,
                                      'last_name': lastNameController.text,
                                      'state': selectedProvince.name,
                                      'city': selectedCity.name,
                                    };
                                    locator<UserBloc>().add(UpdateUserInfoEvent(body: body));
                                  }
                                }
                              }, label: Text(AppLocalizations.of(context)!.submit),),
                          ),
                        ):Animate(
                          delay: Duration(milliseconds: startAnimateTime+timeOffset*6),
                          effects: const [ScaleEffect()],
                          child: TextButton.icon(
                            onPressed: (){
                              onValidate = true;
                              setState(() {
                              });
                              if( _formKey.currentState!.validate()){
                                if((validateCity())&&(validateProvince())) {
                                  Map<String,dynamic> body={
                                    'first_name':firstNameController.text,
                                    'last_name': lastNameController.text,
                                    'state': selectedProvince.name,
                                    'city': selectedCity.name,
                                  };
                                  locator<UserBloc>().add(UpdateUserInfoEvent(body: body));
                                }
                              }
                            }, label: Text(AppLocalizations.of(context)!.next),icon: const Icon(Icons.arrow_back_ios_new_outlined,size: 16.0,),),
                        ),
                      ],
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validateProvince() {
    if (selectedProvince.name != null) {
      if (selectedProvince.name!.isNotEmpty && selectedProvince.name != ' ') {
        return true;
      }
    }
    return false;
  }

  bool validateCity() {
    if (selectedCity.name != null) {
      if (selectedCity.name!.isNotEmpty && selectedCity.name != ' ') {
        return true;
      }
    }
    return false;
  }

  Future<List<ProvinceModel>> loadJsonFromAsset(String assetPath) async {
    String jsonString = await rootBundle.loadString(assetPath);
    List<dynamic> jsonData = jsonDecode(jsonString);
    List<ProvinceModel> provinces =
        jsonData.map((json) => ProvinceModel.fromJson(json)).toList();
    return provinces;
  }
}
