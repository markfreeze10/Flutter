import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myfitnessapp/screens/exercise.dart';

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
    ProfilScreen()
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
                icon: Icon(Ionicons.navigate_circle_outline),
                title: Text('Erkunden')),
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
  }
}
