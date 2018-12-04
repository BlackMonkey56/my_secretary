import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_secretary/Model/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter/services.dart';

Future<WeatherModel> getWeather(String lat, String lang) async{
  final response = await http.get('https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lang}&appid=c9edd2391e6003880ee605b01c874b45&units=metric');

  if(response.statusCode == 200) {
    var result = json.decode(response.body);
    var model = WeatherModel.fromJson(result);

    return model;
  }else{
    throw Exception('Failed to load Weather Information...');
  }
}

class WeatherInfoBoard extends StatefulWidget {
  @override
  _WeatherInfoBoardState createState() => new _WeatherInfoBoardState();
}

class _WeatherInfoBoardState extends State<WeatherInfoBoard> {
  Map<String, double> currentLocation = new Map();
  StreamSubscription<Map<String, double>> locationSubscription;

  Location location = new Location();
  String error;


  @override
  void initState() {
    super.initState();
    //Default value
    currentLocation['latitude'] = 0.0;
    currentLocation['logitude'] = 0.0;

    initPlatformState();

    locationSubscription = location.onLocationChanged().listen((Map<String, double> result){
      setState(() {
        currentLocation = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: FutureBuilder<WeatherModel>(
        future: getWeather(currentLocation['latitude'].toString(), currentLocation['longitude'].toString()),
        builder: (context, snapshot){
          if(snapshot.hasData){
            WeatherModel model = snapshot.data;

            //Format date
            var fm = new DateFormat('yyyy MM/dd EEE HH:mm ');
            var fm_hour = new DateFormat.Hm();

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Weather in ${model.name}', style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network('https://openweathermap.org/img/w/${model.weather[0].icon}.png'),
                    Text('${model.main.temp.toInt()}°C',
                      style: TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),),
                  ],//<Widget>[]
                ),

                Text('업데이트 시간',
                  style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),),

                Text('${fm.format(new DateTime.fromMillisecondsSinceEpoch((model.dt*1000), isUtc: false))}',
                  style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),

              ],//<Widget>[]
            );//Column
          }
          else if(snapshot.hasError){
            return Text('${snapshot.error}', style: TextStyle(fontSize: 30.0, color: Colors.red),);
          }

          return CircularProgressIndicator(); //Default show loading
        },
      ),//FutureBuilder<WeatherModel>
    );//Container
  }

  void initPlatformState() async {
    Map<String, double> my_location;
    try{
      my_location = await location.getLocation();
      error = '';
    }on PlatformException catch(e){
      if(e.code == 'PERMISSION_DENIED'){
        error = 'Permission Denied';
      }else if(e.code == 'PERMISSION_DENIED_NEVER_ASK'){
        error = 'Permission Denied - Please ask the user to enable it from app settings';
      }
      my_location = null;
    }

    setState(() {
      currentLocation = my_location;
    });
  }
}
