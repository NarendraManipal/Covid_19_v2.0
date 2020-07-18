import 'package:Covid_19_Project_2/Extra/data_source.dart';
import 'package:Covid_19_Project_2/constants.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDetailsAppBar(context),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              DataSource.questionAnswers[index]['question'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Text(
                  DataSource.questionAnswers[index]['answer'],
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: DataSource.questionAnswers.length,
      ),
    );
  }

  AppBar buildDetailsAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: kBackgroundColor,
      title: Text(
        'FAQs',
        style: TextStyle(
          color: kPrimaryColor,
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold
        ),
      ),
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
