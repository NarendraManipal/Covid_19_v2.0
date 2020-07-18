import 'package:Covid_19_Project_2/constants.dart';
import 'package:Covid_19_Project_2/widgets/dial_help_card.dart';
import 'package:Covid_19_Project_2/widgets/effected_country.dart';
import 'package:Covid_19_Project_2/widgets/info_card.dart';
import 'package:Covid_19_Project_2/widgets/prevention_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Map worldData = {};
  bool isCollapsed = true;
  final Duration duration = const Duration(milliseconds: 500);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.7).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 1, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    worldData = worldData.isNotEmpty
        ? worldData
        : ModalRoute.of(context).settings.arguments;
    // print(worldData);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: <Widget>[
          buildMenu(context),
          buildSingleChildScrollView(context, width, height),
        ],
      ),
    );
  }

  Widget buildMenu(BuildContext context) {
    return SafeArea(
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _menuScaleAnimation,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: 0.6 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[900],
                    offset: Offset(1.0, 0.0),
                    blurRadius: 200.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 2.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        margin:
                            EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/icons/user_primary.svg',
                              height: 80.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Welcome, Guest',
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0, top: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildSidebarTile(
                          context,
                          'Home',
                          'assets/icons/home.svg',
                          '/homepage',
                          worldData,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        buildSidebarTile(
                          context,
                          'Countries',
                          'assets/icons/country.svg',
                          '/countries',
                          worldData['countryData'],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        buildSidebarTile(
                          context,
                          'FAQs',
                          'assets/icons/about.svg',
                          '/faqpage',
                          null,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        buildSidebarTile(
                          context,
                          'Donate',
                          'assets/icons/donate.svg',
                          'https://covid19responsefund.org/en/',
                          null,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        buildSidebarTile(
                          context,
                          'Developer',
                          'assets/icons/dev.svg',
                          '/developerpage',
                          null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector buildSidebarTile(
      BuildContext context, label, svgImg, routeUrl, args) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          if (isCollapsed)
            _controller.forward();
          else
            _controller.reverse();
          isCollapsed = !isCollapsed;
        });
        if (routeUrl == 'https://covid19responsefund.org/en/') {
          if (await canLaunch(routeUrl)) {
            await launch(routeUrl);
          }
        } else {
          routeUrl == '/homepage'
              ? Navigator.pushNamed(context, routeUrl, arguments: args)
              : Navigator.pushNamed(context, routeUrl, arguments: {
                  'countryData': args,
                });
        }
      },
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            svgImg,
            height: 20.0,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            label,
            style: TextStyle(
              color: kTextMediumColor,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSingleChildScrollView(
      BuildContext context, double width, double height) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.5 * width,
      right: isCollapsed ? 0 : -0.5 * width,
      child: SafeArea(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Material(
            elevation: 8,
            borderRadius: isCollapsed
                ? BorderRadius.all(Radius.circular(0.0))
                : BorderRadius.all(Radius.circular(15.0)),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/menu.svg'),
                      onPressed: () {
                        setState(() {
                          if (isCollapsed)
                            _controller.forward();
                          else
                            _controller.reverse();
                          isCollapsed = !isCollapsed;
                        });
                      },
                    ),
                    Text(
                      "Covid '19".toUpperCase(),
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/settings.svg'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/settingspage');
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: GridView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                            ),
                            children: <Widget>[
                              InfoCard(
                                title: "Confirmed Cases",
                                count: worldData['cases'],
                                newCount: worldData['todayCases'],
                                logoColor: Color(0xFFFF8C00),
                                spots: worldData['confirmedSpots'],
                                cardPress: () {
                                  Navigator.pushNamed(context, '/detailspage',
                                      arguments: {
                                        'title': 'Confirmed Cases',
                                        'count': worldData['cases'],
                                        'newCount': worldData['todayCases'],
                                        'spots': worldData['confirmedSpots'],
                                        'lastWeekPerc':
                                            worldData['lastWeekPercConf'],
                                        'recRate': worldData['lastWeekPercRec'],
                                      });
                                },
                              ),
                              InfoCard(
                                title: "Total Deaths",
                                count: worldData['deaths'],
                                newCount: worldData['todayDeaths'],
                                logoColor: Color(0xFFFF2D55),
                                spots: worldData['deathSpots'],
                                cardPress: () {
                                  Navigator.pushNamed(context, '/detailspage',
                                      arguments: {
                                        'title': "Total Deaths",
                                        'count': worldData['deaths'],
                                        'newCount': worldData['todayDeaths'],
                                        'spots': worldData['deathSpots'],
                                        'lastWeekPerc':
                                            worldData['lastWeekPercDeath'],
                                        'recRate': worldData['lastWeekPercRec'],
                                      });
                                },
                              ),
                              InfoCard(
                                title: "Total Recovered",
                                count: worldData['recovered'],
                                newCount: worldData['todayRecovered'],
                                logoColor: Color(0xFF50E3C2),
                                spots: worldData['recoveredSpots'],
                                cardPress: () {
                                  Navigator.pushNamed(context, '/detailspage',
                                      arguments: {
                                        'title': "Total Recovered",
                                        'count': worldData['recovered'],
                                        'newCount': worldData['todayRecovered'],
                                        'spots': worldData['recoveredSpots'],
                                        'lastWeekPerc':
                                            worldData['lastWeekPercRec'],
                                        'recRate': worldData['lastWeekPercRec'],
                                      });
                                },
                              ),
                              InfoCard(
                                title: "Active Cases",
                                count: worldData['active'],
                                newCount: worldData['critical'],
                                logoColor: Color(0xFF5856D6),
                                spots: worldData['activeSpots'],
                                cardPress: () {
                                  Navigator.pushNamed(context, '/detailspage',
                                      arguments: {
                                        'title': "Active Cases",
                                        'count': worldData['active'],
                                        'newCount': worldData['critical'],
                                        'spots': worldData['activeSpots'],
                                        'lastWeekPerc':
                                            worldData['lastWeekPercAct'],
                                        'recRate': worldData['lastWeekPercRec'],
                                      });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        EffectedCountries(
                          countryData: worldData['countryData'],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: width,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Preventions',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      PreventionCard(
                                        svgUrl: 'assets/icons/hand_wash.svg',
                                        title: 'Wash Hands',
                                      ),
                                      PreventionCard(
                                        svgUrl: 'assets/icons/use_mask.svg',
                                        title: 'Use Mask',
                                      ),
                                      PreventionCard(
                                        svgUrl:
                                            'assets/icons/Clean_Disinfect.svg',
                                        title: 'Clean Disinfect',
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  DialHelpCard(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
