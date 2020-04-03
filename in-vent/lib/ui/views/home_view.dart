import 'package:flutter/material.dart';
import '../../scoped_models/home_view_model.dart';
import '../../ui/views/base_view.dart';

import '../../enums/view_state.dart';

import '../shared/app_colors.dart';
import '../shared/ui_reducers.dart';

import '../views/feedback_view.dart';
import '../widgets/indicator_button.dart';
import '../widgets/stats_counter.dart';
import '../widgets/watcher_toolbar.dart';

class HomeView extends StatelessWidget {
  static const BoxDecoration topLineBorderDecoration = BoxDecoration(
      border: Border(
          top: BorderSide(
              color: lightGrey, style: BorderStyle.solid, width: 5.0)));

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        builder: (context, child, model) => Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: _getBody(model, context)));
  }

  Widget _getBody(HomeViewModel model, BuildContext context) {
    switch (model.state) {
      case ViewState.Busy:
      case ViewState.Idle:
        return Center(child: CircularProgressIndicator());
      default:
        return _getStatsUi(model, context);
    }
  }

  // This takes the model and context and returns a widget

  // We use a column for the root widget to stack the layout
  // Each child will have a fixed width
  // The stats counter and the feedback button will be in a fixed width container with the itesm centered
  Widget _getStatsUi(HomeViewModel model, BuildContext context) {
    return Column(children: [
       
       //The first container will take half of the size of the screen (after the toolbar height is deducted)
       WatcherToolbar(title: 'Data'),
        _getHeightContainer(
          context: context,
          height: screenHeight(context, dividedBy: 2, decreasedBy: toolbarHeight),
          child: StatsCounter(
            size: screenHeight(context, dividedBy: 2, decreasedBy: toolbarHeight) - 60, // 60 margins
            count: model.appStats.errorCount,
            title: 'Errors',
            titleColor: Colors.red,
          ),
        ),
        // The second one will take a third
         _getHeightContainer(
          context: context,
          height:screenHeight(context, dividedBy: 3, decreasedBy: toolbarHeight),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              StatsCounter(
                size: screenHeight(context, dividedBy: 4, decreasedBy: toolbarHeight) - 60,
                count: model.appStats.userCount,
                title: 'Users',
              ),
              StatsCounter(
                size: screenHeight(context,dividedBy: 4, decreasedBy: toolbarHeight) - 60,
                count: model.appStats.appCount,
                title: 'Apps Created',
              )
          ])
         ),

         //The third will take 1/6th
         _getHeightContainer(
          height:screenHeight(context, dividedBy: 6, decreasedBy: toolbarHeight),
          child: IndicatorButton(
            title: 'FEEDBACK',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedbackView()));
            }
          ))
    ]);
  }

  Widget _getHeightContainer(
      {double height,
      BuildContext context,
      Widget child,
      bool hasTopStroke = false}) {
    return Container(
        height: height,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        // Stroke not added in favor of a dashed line not solid
        decoration: hasTopStroke? topLineBorderDecoration : null,
        child: child);
  }
}