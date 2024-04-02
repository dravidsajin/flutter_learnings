import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/custom_widgets/additional_information_widget.dart';
import 'package:weather_app/custom_widgets/forecast_item_widget.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future fetchWeatherData() async {
    try {
      String cityName = 'london';
      String apiToken = '';
      final weatherData = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$apiToken'));
      final decodedData = jsonDecode(weatherData.body);
      if (decodedData['cod'] != '200') {
        throw decodedData['message'];
      }
      return decodedData;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: fetchWeatherData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final forecastList = snapshot.data['list'];
          // Current weather section
          final weatherRes = forecastList[0];
          final currentWeather = weatherRes['main']['temp'];
          final currentSky = weatherRes['weather'][0]['main'];

          // Additional information section
          final humidity = weatherRes['main']['humidity'];
          final pressure = weatherRes['main']['pressure'];
          final windSpeed = weatherRes['wind']['speed'];

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Card
                SizedBox(
                  width: double.infinity,
                  // elevation: 7,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10.0,
                          sigmaY: 10.0,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentWeather K',
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Icon(
                                  currentSky == 'Clouds' || currentSky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 50),
                              SizedBox(height: 10),
                              Text(
                                currentSky,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Weather Forecast Card
                const Text(
                  'Weather Forecast',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final weatherRes = forecastList[index + 1];
                      final currentWeather = weatherRes['main']['temp'];
                      final currentSky = weatherRes['weather'][0]['main'];
                      final time = DateFormat.j()
                          .format(DateTime.parse(weatherRes['dt_txt']));
                      return ForeCastItemWidget(
                        time: time,
                        icon: currentSky == 'Clouds' || currentSky == 'Rain'
                            ? Icons.cloud
                            : Icons.sunny,
                        value: currentWeather.toString(),
                      );
                    },
                  ),
                ),
                // Additional Information Card
                const SizedBox(height: 20),
                const Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInformationWidget(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: humidity.toString()),
                    AdditionalInformationWidget(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: windSpeed.toString()),
                    AdditionalInformationWidget(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: pressure.toString()),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
