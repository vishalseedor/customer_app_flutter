import 'dart:convert';

import 'package:food_app/map/config_map.dart';
import 'package:food_app/models/address/direction_details.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class RequestAssistents{
  static Future<dynamic> getRequest(String url)async{
    http.Response response = await http.get(Uri.parse(url));

    try{
      if(response.statusCode == 200){
        String jsonData = response.body;
        var decodeData =jsonDecode(jsonData);
        return decodeData;
      }else{
        return 'Failed';
      }
    }catch(exp) {
      return 'Failed';
    }
    }


  static Future<DirectionDetails> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalposition)async{
    String directionUrl = 'https://maps.googleapis.com/maps/api/directions/json?destination=${finalposition.latitude},${finalposition.longitude}&origin=${initialPosition.latitude},${initialPosition.longitude}&key=$mapKey';
    var res =await RequestAssistents.getRequest(directionUrl);
    if(res == 'failed'){
      return null;
    }
    DirectionDetails directionDetailes = DirectionDetails();
    directionDetailes.encodepoints =  res['routes'][0]['overview_polyline']['points'];
    directionDetailes.distanceText = res['routes'][0]['legs'][0]['distance']['text'];
    directionDetailes.distanceValue = res['routes'][0]['legs'][0]['distance']['value'];

    directionDetailes.durationText = res['routes'][0]['legs'][0]['duration']['text'];
    directionDetailes.durationValue = res['routes'][0]['legs'][0]['duration']['value'];

    return directionDetailes;
  }

  }

