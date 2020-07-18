import 'package:Covid_19_Project_2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreventionCard extends StatelessWidget {
  final String svgUrl;
  final String title;

  const PreventionCard({Key key, this.svgUrl, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List temp = title.split(' ');
    return Column(
      children: <Widget>[
        SvgPicture.asset(svgUrl),
        SizedBox(height: 10.0,),
        Text(
          temp[0],
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
        ),
        Text(
          temp[1],
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
        )
      ],
    );
  }
}
