import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myfitnessapp/screens/exercise.dart';
import 'package:myfitnessapp/tab_navigator.dart';

import 'screens/calendar.dart';
import 'screens/explore.dart';
import 'screens/profil.dart';
import 'screens/workout.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  String _currentPage = "Exercises";
  List<String> pageKeys = [
    "Exercises",
    "Workout",
    "Explore",
    "Calendar",
    "Profil"
  ];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Exercises": GlobalKey<NavigatorState>(),
    "Workout": GlobalKey<NavigatorState>(),
    "Explore": GlobalKey<NavigatorState>(),
    "Calendar": GlobalKey<NavigatorState>(),
    "Profil": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Exercises") {
            _selectTab("Exercises", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("Exercises"),
          _buildOffstageNavigator("Workout"),
          _buildOffstageNavigator("Explore"),
          _buildOffstageNavigator("Calendar"),
          _buildOffstageNavigator("Profil"),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blueAccent,
          backgroundColor: Color(0xff2b2c3c),
          unselectedItemColor: Colors.white.withOpacity(0.8),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Ionicons.barbell_outline), title: Text('Exercises')),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.document_text_outline),
                title: Text('Workout')),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.globe_outline), title: Text('Explore')),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.calendar_outline), title: Text('Calendar')),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.person_outline), title: Text('Profil'))
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  /*
  int _index = 0;

  void _switchItem(int index) {
    setState(() {
      _index = index;
    });
  }

  void _switchSite(int index) {
    this.pageController.animateToPage(index,
        duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);
  }

  //late => wird später initialisiert
  late PageController pageController;

  List<Widget> tabPages = [
    ExerciseScreen(),
    WorkoutScreen(),
    ExploreScreen(),
    CalendarScreen(),
    ProfilScreen(),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff2b2c3c),
          currentIndex: _index,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.8),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: _switchSite,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Ionicons.barbell_outline), title: Text('Übung')),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.document_text_outline),
                title: Text('Workout')),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.globe_outline), title: Text('Erkunden')),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.calendar_outline), title: Text('Kalender')),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.person_outline), title: Text('Profil'))
          ],
        ),
        body: PageView(
            children: tabPages,
            onPageChanged: _switchItem,
            controller: pageController,
            physics: NeverScrollableScrollPhysics())
        //physics: ClampingScrollPhysics()
        );
  }*/

}
