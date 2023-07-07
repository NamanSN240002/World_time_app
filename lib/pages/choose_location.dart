import 'package:flutter/material.dart';
import 'package:weather_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  Map data = {};
  List<WorldTime> locations=[];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();
  //  navigate to homescreen
    Navigator.pop(context,{
      'location':instance.location,
      'flag':instance.flag,
      'time':instance.time,
      'isDaytime':instance.isDatytime,
      'TimeZones':data['TimeZones'],
    });
  }

  @override
  Widget build(BuildContext context) {

    data =  ModalRoute.of(context)!.settings.arguments as Map;
    var list = data['TimeZones'];
    list.forEach((element) {
      WorldTime instance = WorldTime(location: element['location'], flag: 'uk.png', url: element['url']);
      locations.add(instance);
    });

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Choose a location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: Icon(
                  Icons.flag,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
