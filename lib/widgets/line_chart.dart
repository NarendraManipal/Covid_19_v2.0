import 'package:Covid_19_Project_2/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class LineReportChartHome extends StatelessWidget {
  final List<FlSpot> spots;

  const LineReportChartHome({Key key, this.spots}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
                colors: [kPrimaryColor],
                barWidth: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LineReportChartDetails extends StatelessWidget {
  final List<FlSpot> spots;
  final String count;

  const LineReportChartDetails({Key key, this.spots, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final display = createDisplay(length: 4);

    return AspectRatio(
      aspectRatio: 2.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: SideTitles(
                showTitles: false,
                reservedSize: 20.0,
                getTitles: (value) {
                  return display(value.toInt());
                },
              ),
              bottomTitles: SideTitles(
                showTitles: false,
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
                colors: [kPrimaryColor],
                isStrokeCapRound: true,
                barWidth: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LineReportChartCountry extends StatelessWidget {
  final List<FlSpot> spots;
  final String count;

  const LineReportChartCountry({Key key, this.spots, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final display = createDisplay(length: 4);

    return AspectRatio(
      aspectRatio: 2.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: SideTitles(
                showTitles: true,
                reservedSize: 20.0,
                getTitles: (value) {
                  if ((value.toInt() - 1.0) % 100000 == 0.0) {
                    return display(value.toInt()).toString();
                  } else {
                    print(value);
                    return '';
                  }
                },
              ),
              bottomTitles: SideTitles(
                showTitles: false,
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
                colors: [kPrimaryColor],
                isStrokeCapRound: true,
                barWidth: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
