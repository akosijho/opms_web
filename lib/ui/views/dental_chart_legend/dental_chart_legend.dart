import 'package:flutter/material.dart';

class DentalChartLegend extends StatelessWidget {
  const DentalChartLegend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dental Chart Label Info'),
      ),
      body: ListView(
        children: [
          Image.asset('assets/images/pediatric.png'),
          Image.asset('assets/images/universal_chart.jpg'),
        ],
      ),
    );
  }
}
