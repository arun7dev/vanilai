import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../services/weather.dart';
import 'location_screen.dart';


class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if(snapshot !=null&&snapshot.hasData&& snapshot.data != ConnectivityResult.none){
              getLocationData();

              return LoadingAnimationWidget.staggeredDotsWave(color: Colors.white, size: 200);
            }
            else{

              return Icon(
                Icons.wifi_off,
                size: MediaQuery.of(context).size.width,

              );
            }

          }
        )
      ),
    );
  }
}
