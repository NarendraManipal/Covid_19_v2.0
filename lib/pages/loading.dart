import 'package:Covid_19_Project_2/Extra/load_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupData() async {
    LoadData worldDataInstance = LoadData();
    await worldDataInstance.getWorldData();
    await worldDataInstance.getGraphData('india');
    await worldDataInstance.getCountryData();

    Navigator.pushReplacementNamed(context, '/homepage', arguments: {
      'cases': worldDataInstance.cases,
      'todayCases': worldDataInstance.todayCases,
      'deaths': worldDataInstance.deaths,
      'todayDeaths': worldDataInstance.todayDeaths,
      'recovered': worldDataInstance.recovered,
      'todayRecovered': worldDataInstance.todayRecovered,
      'active': worldDataInstance.active,
      'critical': worldDataInstance.critical,
      'confirmedSpots': worldDataInstance.graphConfirmedSpots,
      'deathSpots': worldDataInstance.graphDeathSpots,
      'recoveredSpots': worldDataInstance.graphRecoveredSpots,
      'activeSpots': worldDataInstance.graphActiveSpots,
      'lastWeekPercConf': worldDataInstance.lastWeekPercConf,
      'lastWeekPercDeath': worldDataInstance.lastWeekPercDeath,
      'lastWeekPercRec': worldDataInstance.lastWeekPercRec,
      'lastWeekPercAct': worldDataInstance.lastWeekPercAct,
      'countryData': worldDataInstance.countryData,
    });
  }

  @override
  void initState() {
    setupData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
