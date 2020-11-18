import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  // Properties
  String location;
  String time;
  String flag; // url to asset flag icon
  String url; // location used in the api call

  // Constructor
  WorldTime({this.location, this.flag, this.url});

  // Methods
  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');

      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      print(now);

      time = now.toString();
    } catch (e) {
      print("caught error: $e");
      time = "Could not retrieve time data";
    }
  }
}
