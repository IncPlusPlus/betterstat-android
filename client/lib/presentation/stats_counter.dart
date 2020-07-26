//import 'package:betterstatmobile_business_logic/generated/l10n.dart';
//import 'package:betterstatmobile_business_logic/util/keys.dart';
//import 'package:betterstatmobile_client_components/containers/app_loading.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//
//class StatsCounter extends StatelessWidget {
//  final int numActive;
//  final int numCompleted;
//
//  StatsCounter({
//    @required this.numActive,
//    @required this.numCompleted,
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    return AppLoading(builder: (context, loading) {
//      return loading
//          ? Center(
//              key: BetterstatKeys.statsLoading,
//              child: CircularProgressIndicator(
//                key: BetterstatKeys.statsLoading,
//              ))
//          : Center(
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: [
//                  Padding(
//                    padding: EdgeInsets.only(bottom: 8.0),
//                    child: Text(
//                      S.of(context).completedSchedules,
//                      style: Theme.of(context).textTheme.headline6,
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(bottom: 24.0),
//                    child: Text(
//                      '$numCompleted',
//                      key: BetterstatKeys.statsNumCompleted,
//                      style: Theme.of(context).textTheme.subtitle1,
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(bottom: 8.0),
//                    child: Text(
//                      S.of(context).activeSchedules,
//                      style: Theme.of(context).textTheme.headline6,
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(bottom: 24.0),
//                    child: Text(
//                      '$numActive',
//                      key: BetterstatKeys.statsNumActive,
//                      style: Theme.of(context).textTheme.subtitle1,
//                    ),
//                  )
//                ],
//              ),
//            );
//    });
//  }
//}
