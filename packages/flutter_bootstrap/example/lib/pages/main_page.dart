import 'package:example/model/index.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import '../material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Material(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SideBarMenu(menuItems: menuItems),
            Expanded(
              child: Scaffold(
                appBar: AppBar(
                  elevation: 4,
                  centerTitle: true,
                  title: Text(
                    "Flutter Bootstrap Example",
                  ),
                  backgroundColor: drawerBgColor,
                ),
                body: Container(
                  padding: EdgeInsets.all(20.0),
                  child: bpRow(
                    gutter: 20,
                    constraints: constraints,
                    runSpacing: 20,
                    children: [
                      bpCol(
                        w360: 6,
                        w720: 6,
                        w1200: 7,
                        w2000: 8,
                        w2500: 9,
                        constraints: constraints,
                        child: new _MainSection(),
                      ),
                      bpCol(
                        w360: 6,
                        w720: 6,
                        w1200: 5,
                        w2000: 4,
                        w2500: 3,
                        constraints: constraints,
                        child: Container(
                          child: QuickContact(media: _media),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
        if (constraints.maxWidth <= 800) {
          return Material(
            child: Center(
              child: Text("küçük"),
            ),
          );
        } else if (constraints.maxWidth <= 1280 &&
            constraints.maxWidth >= 800) {
          return Material(
            child: Center(
              child: Text("ddede"),
            ),
          );
        } else if (constraints.maxWidth >= 1280) {
          return Material(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ResponsiveWidget.isLargeScreen(context)
                    ? SideBarMenu(menuItems: menuItems)
                    : Container(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 55,
                        width: _media.width,
                        child: AppBar(
                          elevation: 4,
                          centerTitle: true,
                          title: Text(
                            "Flutter Bootstrap Example",
                          ),
                          backgroundColor: drawerBgColor,
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 20),
                          children: <Widget>[
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            CardTile(
                                              iconBgColor: Colors.orange,
                                              cardTitle: "Booking",
                                              icon: Icons.flight_takeoff,
                                              subText: "Todays",
                                              mainText: "230",
                                            ),
                                            SizedBox(width: 20),
                                            CardTile(
                                              iconBgColor: Colors.pinkAccent,
                                              cardTitle: "Website Visits",
                                              icon: Icons.show_chart,
                                              subText:
                                                  "Tracked from Google Analytics",
                                              mainText: "3.560",
                                            ),
                                            SizedBox(width: 20),
                                            CardTile(
                                              iconBgColor: Colors.green,
                                              cardTitle: "Revenue",
                                              icon: Icons.home,
                                              subText: "Last 24 Hours",
                                              mainText: "2500",
                                            ),
                                            SizedBox(width: 20),
                                            CardTile(
                                              iconBgColor:
                                                  Colors.lightBlueAccent,
                                              cardTitle: "Followors",
                                              icon: Icons.unfold_less,
                                              subText: "Last 24 Hours",
                                              mainText: "112",
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      IntrinsicHeight(
                                        child: Row(
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                ChartCardTile(
                                                  cardColor: Color(0xFF7560ED),
                                                  cardTitle: "Bandwidth usage",
                                                  subText: "March 2017",
                                                  icon: Icons.pie_chart,
                                                  typeText: "50 GB",
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ChartCardTile(
                                                  cardColor: Color(0xFF25C6DA),
                                                  cardTitle: "Download count",
                                                  subText: "March 2017",
                                                  icon: Icons.cloud_upload,
                                                  typeText: "35487",
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            ProjectWidget(
                                                media: _media,
                                                projectItems: projectItems),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  QuickContact(media: _media)
                                ],
                              ),
                            ),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  CommentWidget(
                                      media: _media, commentList: commentList),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ProfileWidget(
                                    media: _media,
                                    profileImage: AssetImage(
                                        'assets/images/profile-bg.jpg'),
                                    personImage:
                                        AssetImage('assets/images/4.jpg'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class _MainSection extends StatelessWidget {
  const _MainSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            Container(
              child: bpRow(
                gutter: 20,
                constraints: constraints,
                runSpacing: 20,
                children: [
                  _buildCardTile(
                    constraints,
                    CardTile(
                      iconBgColor: Colors.orange,
                      cardTitle: "Booking",
                      icon: Icons.flight_takeoff,
                      subText: "Todays",
                      mainText: "230",
                    ),
                  ),
                  _buildCardTile(
                    constraints,
                    CardTile(
                      iconBgColor: Colors.pinkAccent,
                      cardTitle: "Website Visits",
                      icon: Icons.show_chart,
                      subText: "Tracked from Google Analytics",
                      mainText: "3.560",
                    ),
                  ),
                  _buildCardTile(
                    constraints,
                    CardTile(
                      iconBgColor: Colors.green,
                      cardTitle: "Revenue",
                      icon: Icons.home,
                      subText: "Last 24 Hours",
                      mainText: "2500",
                    ),
                  ),
                  _buildCardTile(
                    constraints,
                    CardTile(
                      iconBgColor: Colors.lightBlueAccent,
                      cardTitle: "Followors",
                      icon: Icons.unfold_less,
                      subText: "Last 24 Hours",
                      mainText: "112",
                    ),
                  ),
                  _buildChartTile(
                    constraints,
                    ChartCardTile(
                      cardColor: Color(0xFF7560ED),
                      cardTitle: "Bandwidth usage",
                      subText: "March 2017",
                      icon: Icons.pie_chart,
                      typeText: "50 GB",
                    ),
                  ),
                  _buildChartTile(
                    constraints,
                    ChartCardTile(
                      cardColor: Color(0xFF25C6DA),
                      cardTitle: "Download count",
                      subText: "March 2017",
                      icon: Icons.cloud_upload,
                      typeText: "35487",
                    ),
                  ),
                  _buildProjectsTile(
                      constraints,
                      ProjectWidget(
                        media: _media,
                        projectItems: projectItems,
                      )),
                ],
              ),
            ));
  }

  bpCol _buildCardTile(BoxConstraints constraints, CardTile child) {
    return bpCol(
      w720: 6,
      w1200: 4,
      w2000: 3,
      w2500: 2,
      constraints: constraints,
      child: Container(
        height: 300,
        child: child,
      ),
    );
  }

  bpCol _buildChartTile(BoxConstraints constraints, Widget child) {
    print(constraints.maxWidth);
    return bpCol(
      w720: 12,
      w1200: 4,
      w2000: 4,
      w2500: 4,
      constraints: constraints,
      child: Container(
        child: child,
      ),
    );
  }

  bpCol _buildProjectsTile(BoxConstraints constraints, ProjectWidget child) {
    return bpCol(
      w720: 12,
      w1200: 12,
      w2000: 6,
      w2500: 6,
      constraints: constraints,
      child: Container(
        child: child,
      ),
    );
  }
}
