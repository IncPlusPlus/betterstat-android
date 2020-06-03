import 'dart:io' show Platform;

import 'package:flutter/material.dart';

///A factory to create a platform-specific widget.
///Shamelessly copied from [Swav Kulinski's article](https://medium.com/flutter/do-flutter-apps-dream-of-platform-aware-widgets-7d7ed7b4624d).
///For just the source code, see [the gist](https://gist.github.com/swavkulinski/8f0981a6760f33da76a779da5c8a3c9d#file-platform_widget-dart).
abstract class PlatformWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return createAndroidWidget(context);
    } else if (Platform.isIOS) {
      return createIosWidget(context);
    }
    // platform not supported returns an empty widget
    return Container();
  }

  A createAndroidWidget(BuildContext context);

  I createIosWidget(BuildContext context);
}
