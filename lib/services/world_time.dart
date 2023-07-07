import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime{
  late String location;//Location to be displayed
  late String time;//Time to be displayed
  late String flag;//Url to asset
  late String url;//location url
  late bool isDatytime;//true or false for is day
  WorldTime({required this.location,required this.flag,required this.url});

  Future<void> getTime() async {
    try{
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //  get properties
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(offset);
      //  create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDatytime = now.hour>6 && now.hour<20 ?true:false;

      //Set the time property
      time = DateFormat.jm().format(now);

    }
    catch(e) {
      print('Caught error:$e');
      time = 'could not get time data';
    }
  }

}

