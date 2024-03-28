import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
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
      final weatherData = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=8a1a290ea157441567ed5194bb327ab9'));

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
                print('refreshing');
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
            return Text(snapshot.error.toString());
          }
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
                                '$temp K',
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Icon(Icons.cloud, size: 50),
                              SizedBox(height: 10),
                              Text(
                                'Rain',
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
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ForeCastItemWidget(
                        time: '3.00',
                        icon: Icons.cloud,
                        value: '301.17',
                      ),
                      ForeCastItemWidget(
                        time: '3.00',
                        icon: Icons.cloud,
                        value: '301.17',
                      ),
                      ForeCastItemWidget(
                        time: '3.00',
                        icon: Icons.cloud,
                        value: '301.17',
                      ),
                      ForeCastItemWidget(
                        time: '3.00',
                        icon: Icons.cloud,
                        value: '301.17',
                      ),
                      ForeCastItemWidget(
                        time: '3.00',
                        icon: Icons.cloud,
                        value: '301.17',
                      ),
                    ],
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInformationWidget(
                        icon: Icons.water_drop, label: 'Humidty', value: '94'),
                    AdditionalInformationWidget(
                        icon: Icons.air, label: 'Wind Speed', value: '7.67'),
                    AdditionalInformationWidget(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: '1006'),
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
