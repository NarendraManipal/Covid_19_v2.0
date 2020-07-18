import 'package:Covid_19_Project_2/constants.dart';
import 'package:Covid_19_Project_2/widgets/country_widget.dart';
import 'package:Covid_19_Project_2/widgets/data_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountriesData extends StatefulWidget {
  @override
  _CountriesDataState createState() => _CountriesDataState();
}

class _CountriesDataState extends State<CountriesData> {
  Map countryInfo;
  List countryData;

  @override
  Widget build(BuildContext context) {
    countryInfo = ModalRoute.of(context).settings.arguments;
    countryData = countryInfo['countryData'];

    return Scaffold(
      appBar: buildDetailsAppBar(context),
      body: CountryWidget(countryData: countryData),
    );
  }

  AppBar buildDetailsAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: kBackgroundColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: kPrimaryColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset('assets/icons/search.svg'),
          onPressed: () {
            showSearch(context: context, delegate: DataSearch(countryData));
          },
          color: kPrimaryColor,
        ),
      ],
    );
  }
}
