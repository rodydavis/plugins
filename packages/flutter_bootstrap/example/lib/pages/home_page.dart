
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import '../material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(width: 300),
              CardTile(
                iconBgColor: Colors.orange,
                cardTitle: "Booking",
              ),
              SizedBox(width: 30),
              CardTile(
                iconBgColor: Colors.pinkAccent,
              ),
              SizedBox(width: 30),
              CardTile(
                iconBgColor: Colors.green,
              ),
              SizedBox(width: 30),
              CardTile(
                iconBgColor: Colors.lightBlueAccent,
              ),
              SizedBox(width: 30),
            ],
          )
        ],
      ),
    );
  }
}
