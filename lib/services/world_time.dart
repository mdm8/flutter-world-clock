import 'dart:ffi';

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  // Properties
  String location;
  String time;
  String flag; // url to asset flag icon
  String url; // location used in the api call
  bool isDayTime;

  // Constructor
  WorldTime({this.location, this.flag, this.url});

  // Methods
  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');

      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String hourOffset = data['utc_offset'].substring(0, 3);
      String minuteOffSet = data['utc_offset'].replaceRange(1, 4, "");

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(
          hours: int.parse(hourOffset), minutes: int.parse(minuteOffSet)));
      print(now);

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("caught error: $e");
      time = "N/A";
    }
  }
}
