import 'package:Covid_19_Project_2/widgets/line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:number_display/number_display.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String count;
  final String newCount;
  final Color logoColor;
  final List<FlSpot> spots;
  final Function cardPress;

  const InfoCard({
    Key key,
    this.title,
    this.count,
    this.newCount,
    this.logoColor,
    this.spots,
    this.cardPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final display = createDisplay(length: 16);

    return GestureDetector(
      onTap: cardPress,
      child: Container(
        width: width / 2,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      color: logoColor.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/running.svg",
                      height: 12.0,
                      width: 12.0,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        count == null
                            ? "Unknown"
                            : display(int.parse(count)),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        newCount == null
                            ? "Unknown"
                            : "+" + display(int.parse(newCount)),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          height: 2.0,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: LineReportChartHome(spots: spots),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
