import 'dart:convert';
import 'package:http/http.dart';

class TimeZone{
  late List<Map> timeZone;
  Future<void> populate_map() async{
    try{
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone'));
      var list = json.decode(response.body) as List;
      var timeZone = <Map>[];
      list.forEach((element) {
        final splitted = element.split('/');
        if(splitted.length>1) {
          Map mp = {
            'location': splitted[1],
            'url': element,
          };
          timeZone.add(mp);
        }
      });
      this.timeZone = timeZone;
    }
    catch(e) {
      print(e);
    }
  }

}

