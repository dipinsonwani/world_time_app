import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String time;
  String flag;
  String url;

  WorldTime({this.location,this.flag,this.url});
  Future<void> getTime() async {
    try {
      //to use await its mandatory to use async
      //await makes the computer wait to finish it first
      Response response = await get('http://worldtimeapi.org/api/timezone/$url'); //we get this response object from package
      Map data = jsonDecode(response.body);  //converting the json into map (which iterates)
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(datetime);
      //print(offset);

      DateTime now = DateTime.parse(datetime);
      now= now.add(Duration(hours: int.parse(offset)));

      time = DateFormat.jm().format(now); //intl package to set the time format
      print(time);

    }
    catch(e){
      print('caught error: $e');
      time = 'could not get time data';

    }



  }

}