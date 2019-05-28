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
    this.breakpoint = 400,
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
    return ListenableProvider<TabState>(
      builder: (_) => tabState,
      child: Consumer<TabState>(
        builder: (context, model, child) {
          if (adaptive && Platform.isIOS) {
            if (masterDetail) {
              return Row(
                children: <Widget>[
                  Container(
                    width: 400,
                    child: CupertinoPage(
                      primaryColor: primaryColor,
                      accentColor: accentColor,
                      masterDetail: masterDetail,
                      tabs: model.extraTabs,
                      navigator: navigator,
                      onEdit: () => _goToEditScreen(context, model),
                      onTap: model.changeTab,
                    ),
                  ),
                  Expanded(child: model.child),
                ],
              );
            }
            return CupertinoPage(
              primaryColor: primaryColor,
              accentColor: accentColor,
              tabs: model.extraTabs,
              masterDetail: masterDetail,
              navigator: navigator,
              onEdit: () => _goToEditScreen(context, model),
              onTap: (index) async {
                model.changeTab(index);
                await navigator.push(
                  CupertinoPageRoute(
                    builder: (context) => model.child,
                  ),
                );
              },
            );
          }
          return Scaffold(
              appBar: AppBar(
                title: Text("More"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _goToEditScreen(context, model),
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
                      trailing: !masterDetail && adaptive
                          ? Icon(Icons.keyboard_arrow_right)
                          : null,
                      onTap: () async {
                        model.changeTab(index);
                        await navigator.push(
                          MaterialPageRoute(
                            builder: (context) => i.child,
                          ),
                        );
                      },
                    );
                  },
                ),
              ));
        },
      ),
    );
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

class CupertinoPage extends StatelessWidget {
  const CupertinoPage({
    Key key,
    @required this.primaryColor,
    @required this.accentColor,
    @required this.navigator,
    @required this.onTap,
    @required this.onEdit,
    @required this.tabs,
    @required this.masterDetail,
  }) : super(key: key);

  final Color primaryColor;
  final Color accentColor;
  final NavigatorState navigator;
  final ValueChanged<int> onTap;
  final VoidCallback onEdit;
  final List<DynamicTab> tabs;
  final bool masterDetail;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
                  final i = tabs[index];
                  final Icon _icon = i.tab.icon;
                  final Text _text = i.tab.title;
                  return DefaultTextStyle(
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                      child: CupertinoListTile(
                        leading: _icon.icon,
                        title: _text,
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
                childCount: tabs.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
