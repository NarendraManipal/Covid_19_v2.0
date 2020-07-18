import 'package:Covid_19_Project_2/Extra/load_data.dart';
import 'package:Covid_19_Project_2/constants.dart';
import 'package:Covid_19_Project_2/widgets/line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:number_display/number_display.dart';

class CountrySpecificInfo extends StatefulWidget {
  @override
  _CountrySpecificInfoState createState() => _CountrySpecificInfoState();
}

class _CountrySpecificInfoState extends State<CountrySpecificInfo> {
  Map countrySpec, countrySpecData;
  List countryData;
  List<FlSpot> spots;
  
  Future<List<FlSpot>> setUp(countryName) async {
    LoadData worldDataInstance = LoadData();
    await worldDataInstance.getGraphData(countryName);

    spots = worldDataInstance.graphConfirmedSpots;
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    final display = createDisplay(length: 16);
    countrySpec = ModalRoute.of(context).settings.arguments;

    countrySpecData = countrySpec['countrySpec'];
    countryData = countrySpec['countryData'];

    setUp(countrySpecData['country']);

    return Scaffold(
      appBar: buildDetailsAppBar(context, countrySpecData['continent']),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
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
                    buildTitleWithMoreIcon(
                        imgurl: countrySpecData['countryInfo']['flag'],
                        title: countrySpecData['country']),
                    SizedBox(
                      height: 15.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'Cases',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              display(countrySpecData['cases']).toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(color: kPrimaryColor, height: 1.2),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '+' +
                                  display(countrySpecData['todayCases'])
                                      .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    color: Colors.red,
                                    height: 2.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
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
                    FutureBuilder(
                      future: setUp(countrySpecData['country']),
                      builder: (context, AsyncSnapshot<List<FlSpot>> snapshot) {
                        if (snapshot.hasData) {
                          return LineReportChartCountry(spots: spots);
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.green),
                            backgroundColor: Colors.white,
                          ));
                        }
                      },
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
                          buildColumnWithDetails(
                            title: 'Deaths',
                            count:
                                display(countrySpecData['deaths']).toString(),
                            todayCount: display(countrySpecData['todayDeaths'])
                                .toString(),
                          ),
                          buildColumnWithDetails(
                            title: 'Active',
                            count:
                                display(countrySpecData['active']).toString(),
                            todayCount:
                                display(countrySpecData['critical']).toString(),
                          ),
                          buildColumnWithDetails(
                            title: 'Recovered',
                            count: display(countrySpecData['recovered'])
                                .toString(),
                            todayCount:
                                display(countrySpecData['todayRecovered'])
                                    .toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Google Map',
                          style: TextStyle(
                            color: kTextMediumColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 18.0,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SvgPicture.asset('assets/icons/more.svg'),
                      ],
                    ),
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

  Column buildColumnWithDetails(
      {String title, String count, String todayCount}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            height: 1.5,
            color: kTextMediumColor,
          ),
        ),
        Text(
          count,
          style: TextStyle(
            fontSize: 18.0,
            color: kPrimaryColor,
          ),
        ),
        Text(
          '+' + todayCount,
          style: TextStyle(
              fontSize: 14.0, color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Row buildTitleWithMoreIcon({String imgurl, String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(
              imgurl,
              height: 30.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              title.toUpperCase(),
              style: TextStyle(
                color: kTextMediumColor,
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            SvgPicture.asset('assets/icons/more.svg'),
          ],
        ),
      ],
    );
  }

  AppBar buildDetailsAppBar(BuildContext context, String name) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: kBackgroundColor,
      title: Text(
        name.toUpperCase(),
        style: TextStyle(
          letterSpacing: .5,
          color: kTextMediumColor,
          fontSize: 18.0,
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
