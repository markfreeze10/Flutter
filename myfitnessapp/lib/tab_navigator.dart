import 'package:flutter/material.dart';
import 'package:myfitnessapp/screens/calendar.dart';
import 'package:myfitnessapp/screens/exercise.dart';
import 'package:myfitnessapp/screens/explore.dart';
import 'package:myfitnessapp/screens/profil.dart';
import 'package:myfitnessapp/screens/workout.dart';
import 'package:myfitnessapp/base.dart';
import 'package:myfitnessapp/bottom_navigation.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child = ExerciseScreen();

    if (tabItem == "Exercises") {
      child = ExerciseScreen();
    } else if (tabItem == "Workout") {
      child = WorkoutScreen();
    } else if (tabItem == "Explore") {
      child = ExploreScreen();
    } else if (tabItem == "Calendar") {
      child = CalendarScreen();
    } else if (tabItem == "Profil") {
      child = ProfilScreen();
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
