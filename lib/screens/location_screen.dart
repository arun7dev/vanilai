import 'package:animated_background/animated_background.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

import '../services/weather.dart';
import '../utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>  with TickerProviderStateMixin {
  var iscelcius=true;
  WeatherModel weather = WeatherModel();
  late int temperature;
  late var daily;
  late var hourly;

  late String weatherIcon;
  late String cityName;
  late String weatherMessage;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['current']['temp'];
      temperature = temp.toInt();
      daily=weatherData['daily'];

      hourly = weatherData['hourly'];

      // var condition = weatherData['weather'][0]['id'];
      // weatherIcon = weather.getWeatherIcon(condition);
      // weatherMessage = weather.getMessage(temperature);
      // cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101820),

      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const  ParticleOptions(

            baseColor: Color(0xffFEE715),
            spawnOpacity: 0.0,
            opacityChangeRate: 0.25,
            minOpacity: 0.1,
            maxOpacity: 0.4,
            spawnMinSpeed: 30.0,
            spawnMaxSpeed: 70.0,
            spawnMinRadius: 7.0,
            spawnMaxRadius: 15.0,
            particleCount: 40,
          ),
        ),
        vsync: this,
        child: Container(
                // decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       begin: Alignment.centerRight,
                //       end: Alignment.bottomLeft,
                //       stops: [
                //         0.1,
                //         0.3,
                //         0.5,
                //         0.7,
                //         0.9,
                //       ],
                //       colors: [
                //         Colors.yellow,
                //         Colors.red,
                //         Colors.indigo,
                //         Colors.teal,
                //
                //         Colors.pink,
                //       ],
                //     )
                // ),
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage("assets/b.jpg"),
                //     fit: BoxFit.cover,
                //   ),
                // ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     TextButton(
                      //       onPressed: () async {
                      //         var weatherData = await weather.getLocationWeather();
                      //         updateUI(weatherData);
                      //       },
                      //       child: Icon(
                      //         Icons.near_me,
                      //         size: 50.0,
                      //       ),
                      //     ),
                      //     TextButton(
                      //       onPressed: () async {
                      //         var typedName = await Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) {
                      //               return CityScreen();
                      //             },
                      //           ),
                      //         );
                      //         if (typedName != null) {
                      //           var weatherData =
                      //               await weather.getCityWeather(typedName);
                      //           updateUI(weatherData);
                      //         }
                      //       },
                      //       child: Icon(
                      //         Icons.location_city,
                      //         size: 50.0,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Now",
                                style: GoogleFonts.getFont('Quicksand'),)),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // decoration: BoxDecoration(
                              //   border: Border.all(
                              //     color: Colors.white ,
                              //     width: 2.0 ,
                              //   ),
                              //   borderRadius: BorderRadius.circular(20),
                              // ),
                              child: BlurryContainer(
                                blur: 5,
                                elevation: 0,
                                color: Colors.transparent,
                                padding: const EdgeInsets.all(8),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20)),
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        flex: 15,
                                        child:
                                        Row(mainAxisAlignment: MainAxisAlignment
                                            .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text('$temperature',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 2)),),
                                            Text("°", style: TextStyle(
                                                fontSize: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 5),),
                                            //Image.network(icon_url),
                                          ],
                                        ),


                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: TextButton(onPressed: () {
                                          setState(() {
                                            if (iscelcius) {
                                              temperature = ((temperature * 9 /
                                                  5) + 32).toInt();
                                              iscelcius = false;
                                            }
                                            else {
                                              temperature = ((temperature -
                                                  32) * 5 / 9).toInt();
                                              iscelcius = true;
                                            }
                                          });
                                        },
                                          child: Text(iscelcius ? "C" : "F",
                                            style: TextStyle(
                                                color: Colors.white),),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Next 24 hours",
                                style: GoogleFonts.getFont('Quicksand'),)),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            // height: 150,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 23,
                                itemBuilder: (context, index) {
                                  return NextContainer(DateFormat.j().format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          hourly[index + 1]["dt"] * 1000,
                                          isUtc: false)).toString(),
                                      hourly[index + 1]["temp"], hourly[index +
                                          1]["weather"][0]["description"]);
                                }),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Next 7 Days",
                                style: GoogleFonts.getFont('Quicksand'),)),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            //height: 150,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: daily.length - 1,
                                itemBuilder: (context, index) {
                                  return NextContainer(
                                      DateFormat('dd/MM/yyyy').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              daily[index + 1]["dt"] * 1000,
                                              isUtc: false)).toString(),
                                      daily[index + 1]["temp"]["day"],
                                      daily[index +
                                          1]["weather"][0]["description"]);
                                  return NextContainer(
                                      DateFormat('dd/MM/yyyy').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              daily[index + 1]["dt"] * 1000,
                                              isUtc: false)).toString(),
                                      daily[index + 1]["temp"]["day"],
                                      daily[index +
                                          1]["weather"][0]["description"]);
                                }),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),

      ),
    );
  }

  Widget NextContainer(one,two,three) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white ,
            width: 1.0 ,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
                          //height: 50,
                          width: 100,
                          child: BlurryContainer(
                            blur: 5,
                            elevation: 0,
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(8),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Column(
                                children: [
                                  Expanded(child: Center(child: Text( one,style:  GoogleFonts.getFont('Quicksand',),))) ,
                                  Divider(color: Colors.white,thickness: 1,),
                                  Expanded(child: Center(child: Text( "${two.toInt().toString()}°",style:  GoogleFonts.getFont('Fjalla One',fontWeight: FontWeight.bold),))),
                                  Divider(color: Colors.white,thickness: 1,),
                                  Expanded(child: Center(child: Text( three.toString(),maxLines: 2,textAlign: TextAlign.center,style:  GoogleFonts.getFont('Quicksand',),))),
                                ],
                              ),
                            ),
                          ),
                        ),
    );
  }
}
