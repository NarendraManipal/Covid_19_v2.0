import 'package:Covid_19_Project_2/constants.dart';
import 'package:Covid_19_Project_2/pages/faq_page.dart';
import 'package:Covid_19_Project_2/pages/countries_data.dart';
import 'package:Covid_19_Project_2/pages/country_info.dart';
import 'package:Covid_19_Project_2/pages/detailspage.dart';
import 'package:Covid_19_Project_2/pages/developer_page.dart';
import 'package:Covid_19_Project_2/pages/homepage.dart';
import 'package:Covid_19_Project_2/pages/loading.dart';
import 'package:Covid_19_Project_2/pages/settings_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(
              displayColor: kTextColor,
            ),
      ),
      initialRoute: '/',
      routes: {
         '/': (context) => Loading(),
         '/homepage': (context) => HomePage(),
         '/detailspage': (context) => DetailsPage(),
         '/countries': (context) => CountriesData(),
         '/countryInfo': (context) => CountrySpecificInfo(),
         '/developerpage': (context) => DeveloperPage(),
         '/faqpage': (context) => FAQPage(),
         '/settingspage': (context) => SettingsPage(),
      },
    );
  }
}

