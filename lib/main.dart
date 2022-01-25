// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:weather_app1/model/weather_model.dart';
import 'package:weather_app1/services/weather_api_client.dart';
import 'package:weather_app1/views/additional_information.dart';
import 'package:weather_app1/views/current_weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
     home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Now lets test if everthing work
  // we will call the api in the init state function
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async{
    data = await client.getCurrentWeather("Vietnam");
  }

  @override
  Widget build(BuildContext context) {
    // the first thing that were going to do is to create the UI of the APP
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf9f9f9),
        elevation: 0.0,
        title: const Text("Weather App", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(onPressed: (){},
        icon: const Icon(Icons.menu),
        color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done) {
            // here we will display if we get data from the api
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Let's create custom widget gor the app
                currentWeather(Icons.wb_sunny_rounded, "${data!.temp}°", "${data!.cityName}"),
                const SizedBox(
                  height: 60.0,
                ),
                const Text("Additional Information", 
                  style: const TextStyle(
                    fontSize: 24.0, 
                    color: const Color(0xdd212121),
                    fontWeight: FontWeight.bold  
                  ),
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  indent: 10,
                  endIndent: 0,
                  color: Colors.black26,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // Now lets create the additional information widget
                additionalInformation("${data!.wind}", "${data!.humidity}", "${data!.pressure}", "${data!.feels_like}"),
                // Now that we have the UI ready
                // Let start intergrating the API
                //first lets start creating the model to store the data
              ],
            );
          }else if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: const CircularProgressIndicator(),
              );
          }
          return Container();
        },
      )
    );
  }
}
