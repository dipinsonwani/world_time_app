import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location; //location name for the UI
  String time;  //the time in that location
  String flag;  //url to flag icon
  String url;   //location url to api
  bool isDaytime;
  WorldTime({this.location,this.flag,this.url});
  Future<void> getTime() async {
    try {
      //to use await its mandatory to use async
      //await makes the computer wait to finish it first
      Response response = await get('http://worldtimeapi.org/api/timezone/$url'); //we get this response object from package
      Map data = jsonDecode(response.body);  //converting the json into map (which iterates)
      String datetime = data['datetime'];
      String offsethrs = data['utc_offset'].substring(1,3);
      String offsetmin = data['utc_offset'].substring(4,6);
      print(datetime);
      //print(offset);

      DateTime now = DateTime.parse(datetime);
      now= now.add(Duration(hours: int.parse(offsethrs),minutes: int.parse(offsetmin)));
      isDaytime= now.hour > 6 && now.hour < 20 ? true: false;

      time = DateFormat.jm().format(now); //intl package to set the time format
      print(time);

    }
    catch(e){
      print('caught error: $e');
      time = 'could not get time data';

    }



  }

}