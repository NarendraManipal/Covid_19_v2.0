import 'package:Covid_19_Project_2/constants.dart';
import 'package:Covid_19_Project_2/widgets/country_widget.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final List countryInfo;

  DataSearch(this.countryInfo);

  @override
  String get searchFieldLabel => 'Search country';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        color: kPrimaryColor,
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      color: kPrimaryColor,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List countryData = [];

    for (int i = 0; i < countryInfo.length; i++) {
      if ((countryInfo[i]['country'].toUpperCase())
          .startsWith(query.toUpperCase())) {
        countryData.add(countryInfo[i]);
      }
    }

    countryData = countryData.isEmpty ? countryInfo : countryData;

    return CountryWidget(countryData: countryData);
  }
}
