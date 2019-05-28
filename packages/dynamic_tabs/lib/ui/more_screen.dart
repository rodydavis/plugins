import 'dart:io';

import 'package:cupertino_controllers/cupertino_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/classes/tab.dart';
import '../data/models/index.dart';
import 'edit_screen.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({
    this.adaptive = false,
    @required this.primaryColor,
    @required this.accentColor,
    @required this.navigator,
    @required this.tabState,
  })  : breakpoint = null,
        masterDetail = false;

  const MoreTab.fluid({
    this.adaptive = false,
    @required this.primaryColor,
    @required this.accentColor,
    @required this.navigator,
    @required this.tabState,
    this.breakpoint = 720,
  }) : masterDetail = true;

  final bool adaptive;
  final Color primaryColor;
  final Color accentColor;
  final NavigatorState navigator;
  final TabState tabState;
  final bool masterDetail;
  final double breakpoint;

  @override
  Widget build(BuildContext context) {
    var _landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return ListenableProvider<TabState>(
        builder: (_) => tabState,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Consumer<TabState>(
              builder: (context, model, child) {
                if (adaptive && Platform.isIOS) {
                  if (_landscape &&
                      masterDetail &&
                      constraints.maxWidth >= breakpoint) {
                    return Row(
                      children: <Widget>[
                        Container(
                          width: 350,
                          child: CupertinoPage(
                            primaryColor: primaryColor,
                            accentColor: accentColor,
                            masterDetail: masterDetail,
                            onEdit: () => _goToEditScreen(context, model),
                            onTap: (index) {
                              final _index =
                                  model.allTabs.indexOf(model.extraTabs[index]);
                              model.changeTab(_index);
                            },
                          ),
                        ),
                        Expanded(child: model.child),
                      ],
                    );
                  }
                  return CupertinoPage(
                    primaryColor: primaryColor,
                    accentColor: accentColor,
                    masterDetail: masterDetail,
                    onEdit: () => _goToEditScreen(context, model),
                    onTap: (index) async {
                      final _index =
                          model.allTabs.indexOf(model.extraTabs[index]);
                      model.changeTab(_index);
                      await navigator.push(
                        CupertinoPageRoute(
                          builder: (context) => model.child,
                        ),
                      );
                    },
                  );
                }

                if (_landscape &&
                    masterDetail &&
                    constraints.maxWidth >= breakpoint) {
                  return Row(
                    children: <Widget>[
                      Container(
                        width: 350,
                        child: new MaterialPage(
                          primaryColor: primaryColor,
                          accentColor: accentColor,
                          masterDetail: masterDetail,
                          onEdit: () => _goToEditScreen(context, model),
                          onTap: model.changeTab,
                        ),
                      ),
                      Expanded(child: model.child),
                    ],
                  );
                }
                return MaterialPage(
                  primaryColor: primaryColor,
                  accentColor: accentColor,
                  masterDetail: masterDetail,
                  onEdit: () => _goToEditScreen(context, model),
                  onTap: (index) async {
                    model.changeTab(index);
                    await navigator.push(
                      MaterialPageRoute(
                        builder: (context) => model.child,
                      ),
                    );
                  },
                );
              },
            );
          },
        ));
  }

  void _goToEditScreen(BuildContext context, TabState state) {
    Navigator.of(context, rootNavigator: true)
        .push<List<DynamicTab>>(MaterialPageRoute(
      builder: (context) => EditScreen(
            maxTabs: state.maxTabs,
            adaptive: adaptive,
            tabs: state.allTabs,
          ),
      fullscreenDialog: true,
    ))
        .then((newTabs) {
      if (newTabs != null) {
        final _list = newTabs.map((t) => t.tag).toList();
        state.changeTabOrder(_list);
      }
    });
  }
}

class MaterialPage extends StatelessWidget {
  const MaterialPage({
    Key key,
    @required this.primaryColor,
    @required this.accentColor,
    @required this.masterDetail,
    @required this.onEdit,
    @required this.onTap,
  }) : super(key: key);

  final bool masterDetail;
  final VoidCallback onEdit;
  final ValueChanged<int> onTap;
  final Color primaryColor;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<TabState>(
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("More"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: onEdit,
              ),
            ],
          ),
          body: SafeArea(
            child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: model.extraTabs.length,
              itemBuilder: (BuildContext context, int index) {
                final i = model.extraTabs[index];
                return ListTile(
                  leading: i.tab.icon,
                  title: i.tab.title,
                  selected: masterDetail ? index == model.subIndex : false,
                  trailing:
                      !masterDetail ? Icon(Icons.keyboard_arrow_right) : null,
                  onTap: () => onTap(index),
                );
              },
            ),
          )),
    );
  }
}

class CupertinoPage extends StatelessWidget {
  const CupertinoPage({
    Key key,
    @required this.primaryColor,
    @required this.accentColor,
    @required this.onTap,
    @required this.onEdit,
    @required this.masterDetail,
  }) : super(key: key);

  final Color primaryColor;
  final Color accentColor;
  final ValueChanged<int> onTap;
  final VoidCallback onEdit;
  final bool masterDetail;

  @override
  Widget build(BuildContext context) {
    return Consumer<TabState>(
      builder: (context, model, child) => CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  backgroundColor: primaryColor,
                  actionsForegroundColor: accentColor,
                  transitionBetweenRoutes: !masterDetail,
                  heroTag: Key('more-tab'),
                  largeTitle: Text("More"),
                  trailing: CupertinoButton(
                    child: Text("Edit"),
                    padding: EdgeInsets.all(0.0),
                    onPressed: onEdit,
                  ),
                ),
                SliverPadding(
                  padding: MediaQuery.of(context)
                      .removePadding(
                        removeTop: true,
                        removeLeft: true,
                        removeRight: true,
                      )
                      .padding,
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final i = model.extraTabs[index];
                        final Icon _icon = i.tab.icon;
                        final Text _text = i.tab.title;
                        return DefaultTextStyle(
                            style:
                                CupertinoTheme.of(context).textTheme.textStyle,
                            child: CupertinoListTile(
                              leading: _icon.icon,
                              title: _text,
                              selected: masterDetail
                                  ? index == model.subIndex
                                  : false,
                              lastItem: false,
                              ios: CupertinoListTileData(
                                style: CupertinoCellStyle.subtitle,
                                accessory: masterDetail
                                    ? CupertinoAccessory.none
                                    : CupertinoAccessory.disclosureIndicator,
                              ),
                              onTap: () => onTap(index),
                            ));
                      },
                      childCount: model.extraTabs.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
