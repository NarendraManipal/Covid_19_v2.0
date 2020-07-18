import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DialHelpCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.4,
              top: 20.0,
              right: 50.0,
            ),
            height: 130.0,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green[400],
                  Colors.green[700],
                ],
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Dial 1075 for Medical Help!',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                ),
                Text(
                  'If any symptoms appear',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.white.withOpacity(.7),
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SvgPicture.asset('assets/icons/nurse.svg'),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset(
              'assets/icons/virus.svg',
            ),
          ),
        ],
      ),
    );
  }
}
