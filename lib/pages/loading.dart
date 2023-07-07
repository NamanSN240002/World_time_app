import 'package:flutter/material.dart';
import 'package:weather_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/services/time_zones.dart';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async {
    WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    await instance.getTime();
    TimeZone instancetimeZone = TimeZone();
    await instancetimeZone.populate_map();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location':instance.location,
      'flag':instance.flag,
      'time':instance.time,
      'isDaytime':instance.isDatytime,
      'TimeZones':instancetimeZone.timeZone,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupWorldTime();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: const Center(
        child: SpinKitSpinningLines(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
