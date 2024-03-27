import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/custom_widgets/additional_information_widget.dart';
import 'package:weather_app/custom_widgets/forecast_item_widget.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
      body: Padding(
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
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            '300K',
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
                  ForeCastItemWidget(time: '3.00', icon: Icons.cloud, value: '301.17',),
                  ForeCastItemWidget(time: '3.00', icon: Icons.cloud, value: '301.17',),
                  ForeCastItemWidget(time: '3.00', icon: Icons.cloud, value: '301.17',),
                  ForeCastItemWidget(time: '3.00', icon: Icons.cloud, value: '301.17',),
                  ForeCastItemWidget(time: '3.00', icon: Icons.cloud, value: '301.17',),
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
                    icon: Icons.beach_access, label: 'Pressure', value: '1006'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
