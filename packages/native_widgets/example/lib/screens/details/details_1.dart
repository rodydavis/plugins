import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: NativeAppBar(
//        title: Text("Details"),
//        ios: CupertinoNavigationBarData(
//          heroTag: "Details",
//          previousPageTitle: "List View",
//          transitionBetweenRoutes: false,
//        ),
//      ),
//      body: Container(),
      body: CupertinoPageScaffold(
        child: CustomScrollView(
          semanticChildCount: 2,
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
//            trailing: trailingButtons,
//            middle: Text("Presidents"),
              largeTitle: Text("Details"),
//              previousPageTitle: "",
            ),
            SliverToBoxAdapter(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
