# flutter_cupertino_settings

![Pub badge](https://img.shields.io/pub/v/flutter_cupertino_settings.svg)  ![](https://img.shields.io/github/license/matthinc/flutter_cupertino_settings.svg)

A Flutter widget to create an iOS settings-table (static TableView).

[Get from Pub](https://pub.dartlang.org/packages/flutter_cupertino_settings#-installing-tab-)

- [x] Basic items (CSHeader, CSWidget, CSControl, CSButton, CSLink)
- [x] Support for icons
- [x] Item selection
- [ ] Dynamic lists
- [ ] Themes



```dart

import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

CSWidgetStyle brightnessStyle = const CSWidgetStyle(
    icon: const Icon(Icons.brightness_medium, color: Colors.black54)
);

new CupertinoSettings(<Widget>[
    new CSHeader('Brightness'),
    new CSWidget(new CupertinoSlider(value: 0.5), style: brightnessStyle),
    new CSControl('Auto brightness', new CupertinoSwitch(value: true), style: brightnessStyle,),
    new CSHeader('Selection'),
    new CSSelection(['Day mode','Night mode'], (index) {print(index);}, currentSelection: 0),
    new CSHeader(),
    new CSControl('Loading...', new CupertinoActivityIndicator()),
    new CSButton(CSButtonType.DEFAULT, "Licenses", (){ print("It works!"); }),
    new CSHeader(),
    new CSButton(CSButtonType.DESTRUCTIVE, "Delete all data", (){})
]);
```

![](https://abload.de/img/screenshot2018-05-02a00u3w.png)
