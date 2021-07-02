import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Umuahia&appid=255d41cd348d1c3291f388e6effc7af6'));

    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            color: Colors.purple,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 13.0),
                  child: Text(
                    "Now in Umuahia",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" "C" : "loading",
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 13.0),
                  child: Text(
                    currently != null ? currently.toString() : "loading",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(
                        temp != null ? temp.toString() + "\u00B0" : "loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(description != null
                        ? description.toString()
                        : "loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(
                        humidity != null ? humidity.toString() : "loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind speed"),
                    trailing: Text(
                        windSpeed != null ? windSpeed.toString() : "loading"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
