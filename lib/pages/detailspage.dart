import 'package:Covid_19_Project_2/constants.dart';
import 'package:Covid_19_Project_2/widgets/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:number_display/number_display.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Map pageData = {};
  final display = createDisplay(length: 16);

  @override
  Widget build(BuildContext context) {
    pageData = pageData.isNotEmpty
        ? pageData
        : ModalRoute.of(context).settings.arguments;

    var increase = int.parse(pageData['newCount']);
    var percIncrease = increase / int.parse(pageData['count']) * 100.0;

    return Scaffold(
      appBar: buildDetailsAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 20),
                      blurRadius: 50,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildTitleWithMoreIcon(title: pageData['title']),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          display(int.parse(pageData['count'])).toString() +
                              '  ',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(color: kPrimaryColor, height: 1.2),
                        ),
                        Text(
                          percIncrease.toStringAsFixed(1).toString() + '% ',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: kPrimaryColor, height: 1.2),
                        ),
                        SvgPicture.asset('assets/icons/increase.svg'),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'From Health Center',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: kTextMediumColor,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    LineReportChartDetails(
                      spots: pageData['spots'],
                      count: pageData['count'],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          buildColumnWithPercentageText(
                            title: 'From Last Week',
                            percentage: (double.parse(pageData['lastWeekPerc'])
                                        .toStringAsFixed(2))
                                    .toString() +
                                '% ',
                          ),
                          buildColumnWithPercentageText(
                            title: 'Recovery Rate',
                            percentage: (double.parse(pageData['recRate'])
                                        .toStringAsFixed(2))
                                    .toString() +
                                '% ',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 21),
                      blurRadius: 54,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    buildTitleWithMoreIcon(title: 'Google Map'),
                    SizedBox(height: 10.0),
                    SvgPicture.asset('assets/icons/map.svg'),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }

  Column buildColumnWithPercentageText({String title, String percentage}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          percentage,
          style: TextStyle(
            fontSize: 20.0,
            color: kPrimaryColor,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            height: 1.5,
            color: kTextMediumColor,
          ),
        ),
      ],
    );
  }

  Row buildTitleWithMoreIcon({String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: kTextMediumColor,
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
            letterSpacing: 0.5,
          ),
        ),
        SvgPicture.asset('assets/icons/more.svg'),
      ],
    );
  }

  AppBar buildDetailsAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: kBackgroundColor,
      title: Text(
        'World Wide',
        style: TextStyle(
          color: kTextMediumColor,
          letterSpacing: 0.8,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: kPrimaryColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
