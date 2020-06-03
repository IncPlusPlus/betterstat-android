import 'package:betterstatmobile/interop/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///A platform-agnostic AppBar. ([Nabbed from Swav Kulinski](https://gist.github.com/swavkulinski/d23e177ca80269f8b248e2e77d61252e))
class PlatformAppBar extends PlatformWidget<CupertinoNavigationBar, AppBar> {
  final Widget leading;
  final Widget title;

  PlatformAppBar(this.leading, this.title);

  @override
  AppBar createAndroidWidget(BuildContext context) => AppBar(
        leading: leading,
        title: title,
      );

  @override
  CupertinoNavigationBar createIosWidget(BuildContext context) =>
      CupertinoNavigationBar(
        leading: leading,
        middle: title,
      );
}
