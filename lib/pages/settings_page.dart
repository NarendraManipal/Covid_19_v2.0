import 'package:Covid_19_Project_2/constants.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildDetailsAppBar(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Coming soon!',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
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
    );
  }
}
