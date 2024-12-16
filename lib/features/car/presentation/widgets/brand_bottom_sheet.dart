import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahnegar/common/utils/failure_action.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/blocs/get_brands_cubit/get_brands_cubit.dart';
import 'package:rahnegar/locator.dart';

import '../../../../common/client/failures.dart';
import '../../../../common/model/state.dart';
import '../../domain/entity/brand_data_entity.dart';

class BrandBottomSheet extends StatelessWidget {
  BrandBottomSheet({super.key, required this.onSelect,required this.state,this.list=const[],required this.onFailure}){
    items = list;
  }
  TextEditingController brandController = TextEditingController();
  Function(BrandDataEntity) onSelect;
  List<BrandDataEntity> list;
  List<BrandDataEntity> items=[];
  MyState state;
  Function(Failure) onFailure;
  @override
  Widget build(BuildContext context) {
    return body(context);
  }
  Widget body(context){
    if(state.isLoading){
      return const LinearProgressIndicator();
    }
    else if(state.isSuccess){
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 500,
              color: Colors.white,
              child: Column(
                children: [
                  TextFormField(
                    controller: brandController,
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
                      items = list
                          .where((brand) =>
                      brand.nameFa!.startsWith(search) ||
                          brand.nameEng!.toLowerCase().startsWith(search))
                          .toList();
                      setState(() {});
                    },
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(items[index].nameFa!),
                              onTap: () {
                                Navigator.of(context).pop();
                                onSelect(items[index]);
                              },
                            );
                          }))
                ],
              ),
            );
          });
    }
    else if(state.isFailure){
      onFailure(state.failure!);
    }
    return Container();
  }
}

