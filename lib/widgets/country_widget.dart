import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class CountryWidget extends StatelessWidget {
  final List countryData;

  const CountryWidget({Key key, this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final display = createDisplay(length: 16);

    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(countryData.length, (index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/countryInfo', arguments: {
              'countrySpec': countryData[index],
              'countryData': countryData,
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 0.05),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 0.2),
                              ),
                              child: Image.network(
                                countryData[index]['countryInfo']['flag'],
                                height: 30.0,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              countryData[index]['country'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Confirmed: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Deaths: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Recovered: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Active: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[900],
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  display(countryData[index]['cases'])
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  display(countryData[index]['deaths'])
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 15.0,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  display(countryData[index]['recovered'])
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  display(countryData[index]['active'])
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[900],
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
