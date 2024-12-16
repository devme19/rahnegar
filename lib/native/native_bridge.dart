import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:rahnegar/features/map/data/model/item.dart';

class NativeBridge {
  static  MethodChannel? platform;
  createChannel(int viewId){
    platform = MethodChannel('native_map_view_$viewId');
  }
  // Function to call a native method
  Future<String> invokeNativeMethod() async {
    try {
      final result = await platform!.invokeMethod('getNativeData');
      return result;
    } on PlatformException catch (e) {
      print('Failed to invoke method: ${e.message}');
    }
    return "";
  }
  Future<String> showMap() async {
    try {
      final result = await platform!.invokeMethod('showMap');
      return result;
    } on PlatformException catch (e) {
      print('Failed to invoke method: ${e.message}');
    }
    return "";
  }
  Future<String> sendLocation({required double latitude,required double longitude}) async {
    try {
      final result = await platform!.invokeMethod('sendLocation',{
        'latitude': latitude,
        'longitude': longitude,
      });
      print(result);
      return result;
    } on PlatformException catch (e) {
      print('Failed to invoke method: ${e.message}');
    }
    return "";
  }

  Future<String> goToLocation({required double latitude,required double longitude}) async {
    try {
      final result = await platform!.invokeMethod('goToLocation',{
        'latitude': latitude,
        'longitude': longitude,
      });
      print(result);
      return result;
    } on PlatformException catch (e) {
      print('Failed to invoke method: ${e.message}');
    }
    return "";
  }
  Future<String> addMarker({required double latitude,required double longitude}) async {
    try {
      final result = await platform!.invokeMethod('addMarker',{
        'latitude': latitude,
        'longitude': longitude,
      });
      print(result);
      return result;
    } on PlatformException catch (e) {
      print('Failed to invoke method: ${e.message}');
    }
    return "";
  }
  Future<String> removeSelectedLocationMarker() async {
    try {
      final result = await platform!.invokeMethod('removeSelectedLocationMarker');
      print(result);
      return result;
    } on PlatformException catch (e) {
      print('Failed to invoke method: ${e.message}');
    }
    return "";
  }
  Future<String> clearSearch() async {
    try {
      final result = await platform!.invokeMethod('clearSearch');
      print(result);
      return result;
    } on PlatformException catch (e) {
      print('Failed to invoke method: ${e.message}');
    }
    return "";
  }
  Future<String> sendLiveLocation({required double latitude,required double longitude}) async {
    try {
      final result = await platform!.invokeMethod('sendLiveLocation',{
        'latitude': latitude,
        'longitude': longitude,
      });
      print(result);
      return result;
    } on PlatformException catch (e) {
      print('Failed to invoke method: ${e.message}');
    }
    return "";
  }

  Future<List<Item>> search({required String term}) async {
    List<Item> items=[];
    try {

      String result = await platform!.invokeMethod('search',{
        'term': term,
      });
      if(result.contains("No items found")){
        return items;
      }else{
        List<dynamic> itemsJson = jsonDecode(result);
        List<Item> items = itemsJson.map((itemJson) => Item.fromJson(itemJson)).toList();
        return items;
      }

    } on PlatformException catch (e) {
      print('Failed to invoke method: ${e.message}');
      return items;
    }
    return items;
  }
  Future<String> changeLocationMarker({required LatLng previousLocation,required LatLng currentLocation})async{
    try {
      final result = await platform!.invokeMethod('changeLocationMarker',{
        'latitude1': previousLocation.latitude,
        'longitude1': previousLocation.longitude,
        'latitude2': currentLocation.latitude,
        'longitude2': currentLocation.longitude,
      });
      print(result);
      return result;
    } on PlatformException catch (e) {
      print('Failed to invoke method: ${e.message}');
    }
    return "";
  }
  Future<String> drawPolyLine()async{
    try {
      List<LatLng> points = [
        const LatLng(35.769368, 51.327650),
        const LatLng(35.756670, 51.323889),
        const LatLng(35.746670, 51.283889),
      ];
      List<Map<String, double>> latLngList = points
          .map((latLng) => {
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
      })
          .toList();
      final result = await platform!.invokeMethod('drawPolyLine',{'latLngList': latLngList});
      print(result);
      return result;
    } on PlatformException catch (e) {
      print('Failed to invoke method: ${e.message}');
    }
    return "";
  }

}