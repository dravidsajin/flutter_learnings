import 'dart:ui';
import 'package:flutter/material.dart';

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
                            '300 ° F',
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
                  ForeCastItem(),
                  ForeCastItem(),
                  ForeCastItem(),
                  ForeCastItem(),
                  ForeCastItem(),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Icon(Icons.water_drop, size: 32,),
                        SizedBox(height: 8),
                        Text('Humidity', style: TextStyle(fontSize: 14)),
                        SizedBox(height: 8),
                        Text('94', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      ],
                    ),
                  )
                ),

                SizedBox(
                  width: 100,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Icon(Icons.air, size: 32,),
                        SizedBox(height: 8),
                        Text('Wind Speed', style: TextStyle(fontSize: 14)),
                        SizedBox(height: 8),
                        Text('7.67', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      ],
                    ),
                  )
                ),

                SizedBox(
                  width: 100,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Icon(Icons.beach_access, size: 32,),
                        SizedBox(height: 8),
                        Text('Pressure', style: TextStyle(fontSize: 14),),
                        SizedBox(height: 8),
                        Text('1006', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      ],
                    ),
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ForeCastItem extends StatelessWidget {
  const ForeCastItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(children: [
            Text(
              '03:00',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Icon(Icons.cloud),
            SizedBox(height: 8),
            Text(
              '101.12',
              // style: TextStyle(fontSize: 14),
            )
          ]),
        ),
      ),
    );
  }
}
