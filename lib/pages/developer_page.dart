import 'package:Covid_19_Project_2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildDetailsAppBar(context),
      backgroundColor: kBackgroundColor,
      body: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 75.0),
                    child: Image.asset(
                      'assets/images/about_background.jpg',
                      width: width,
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: (width / 2) - 75,
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundColor: kBackgroundColor,
                      child: CircleAvatar(
                        radius: 75.0,
                        backgroundImage:
                            AssetImage('assets/images/Narendra.jpg'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Narendra V',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.grey[800],
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: Text(
                          'Final year Computer Science and Engineering Student at SMVITM Bantakal, Udupi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 15.0,
                            letterSpacing: 0.8,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            const url =
                                'https://www.instagram.com/narendra__v/';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'could not launch $url';
                            }
                          },
                          child: SvgPicture.asset(
                            'assets/icons/about_insta.svg',
                            height: 30.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            const url =
                                'https://www.facebook.com/narendra.vmanipal/';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'could not launch $url';
                            }
                          },
                          child: SvgPicture.asset(
                            'assets/icons/facebook.svg',
                            height: 30.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            const url =
                                'https://twitter.com/narendramanipa1';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'could not launch $url';
                            }
                          },
                          child: SvgPicture.asset(
                            'assets/icons/twitter.svg',
                            height: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }

  AppBar buildDetailsAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: kBackgroundColor.withOpacity(0.0),
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
