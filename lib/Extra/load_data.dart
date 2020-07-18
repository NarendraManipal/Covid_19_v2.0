import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart';
import 'dart:convert';

class LoadData {
  String cases;
  String todayCases;
  String deaths;
  String todayDeaths;
  String recovered;
  String todayRecovered;
  String active;
  String critical;
  List<FlSpot> graphConfirmedSpots;
  List<FlSpot> graphDeathSpots;
  List<FlSpot> graphRecoveredSpots;
  List<FlSpot> graphActiveSpots;
  String lastWeekPercConf;
  String lastWeekPercDeath;
  String lastWeekPercRec;
  String lastWeekPercAct;
  List countryData;

  LoadData({
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.todayRecovered,
    this.active,
    this.critical,
    this.graphConfirmedSpots,
    this.graphDeathSpots,
    this.graphRecoveredSpots,
    this.graphActiveSpots,
    this.lastWeekPercConf,
    this.lastWeekPercDeath,
    this.lastWeekPercRec,
    this.lastWeekPercAct,
    this.countryData,
  });

  Future<void> getWorldData() async {
    Map worldData;
    try {
      Response response = await get('https://corona.lmao.ninja/v2/all');
      worldData = json.decode(response.body);

      cases = worldData['cases'].toString();
      todayCases = worldData['todayCases'].toString();
      deaths = worldData['deaths'].toString();
      todayDeaths = worldData['todayDeaths'].toString();
      recovered = worldData['recovered'].toString();
      todayRecovered = worldData['todayRecovered'].toString();
      active = worldData['active'].toString();
      critical = worldData['critical'].toString();

      // print(worldData);
    } catch (e) {
      print("Error: " + e.toString());

      cases = null;
      todayCases = null;
      deaths = null;
      todayDeaths = null;
      recovered = null;
      todayRecovered = null;
      active = null;
      critical = null;
    }
  }

  Future<void> getGraphData(String countryName) async {
    graphConfirmedSpots = [];
    graphDeathSpots = [];
    graphRecoveredSpots = [];
    graphActiveSpots = [];

    try {
      Response response =
          await get('https://api.covid19api.com/total/dayone/country/${countryName}');
      List graphData = json.decode(response.body);

      graphData.sort((a, b) {
        return a['Date'].compareTo(b['Date']);
      });

      for (int i = 0; i < graphData.length; i += 7) {
        graphConfirmedSpots
            .add(FlSpot(i.toDouble(), (graphData[i]['Confirmed']).toDouble()));
        graphDeathSpots
            .add(FlSpot(i.toDouble(), (graphData[i]['Deaths']).toDouble()));
        graphRecoveredSpots
            .add(FlSpot(i.toDouble(), (graphData[i]['Recovered']).toDouble()));
        graphActiveSpots
            .add(FlSpot(i.toDouble(), (graphData[i]['Active']).toDouble()));
      }

      // percentage difference from last week of Confirmed cases
      int confirmedDiff = graphData[graphData.length - 1]['Confirmed'] -
          graphData[graphData.length - 7]['Confirmed'];
      lastWeekPercConf =
          (confirmedDiff / graphData[graphData.length - 1]['Confirmed'] * 100.0)
              .toString();

      // percentage difference from last week of Deaths
      int deathDiff = graphData[graphData.length - 1]['Deaths'] -
          graphData[graphData.length - 7]['Deaths'];
      lastWeekPercDeath =
          (deathDiff / graphData[graphData.length - 1]['Deaths'] * 100.0)
              .toString();

      // percentage difference from last week of Recovered cases
      int recoveredDiff = graphData[graphData.length - 1]['Recovered'] -
          graphData[graphData.length - 7]['Recovered'];
      lastWeekPercRec =
          (recoveredDiff / graphData[graphData.length - 1]['Recovered'] * 100.0)
              .toString();

      // percentage difference from last week of Active cases
      int activeDiff = graphData[graphData.length - 1]['Active'] -
          graphData[graphData.length - 7]['Active'];
      lastWeekPercAct =
          (activeDiff / graphData[graphData.length - 1]['Active'] * 100.0)
              .toString();

      // print(graphSpots);
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  Future<void> getCountryData() async {
    try {
      Response response = await get('https://corona.lmao.ninja/v2/countries');
      countryData = json.decode(response.body);

      countryData.sort((b, a) {
        return a['cases'].compareTo(b['cases']);
      });

      // print(countryData);
    } catch (e) {}
  }
}
