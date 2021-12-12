import 'package:flutter/material.dart';
import 'package:myfitnessapp/data/exercises.dart';
import 'package:myfitnessapp/userdata/exercise_data.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    //...
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WorkoutBuildScreen()));
                },
                icon: Icon(Icons.add_circle_outline, color: Colors.black))
          ],
        ),
        body: Align(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.05, 12, 12, 0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Workout',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff31a6dc))))),
                ])));
  }
}

class WorkoutBuildScreen extends StatefulWidget {
  const WorkoutBuildScreen({Key? key}) : super(key: key);

  @override
  _WorkoutBuildScreenState createState() => _WorkoutBuildScreenState();
}

class _WorkoutBuildScreenState extends State<WorkoutBuildScreen> {
  List<ExerciseData> tempList = Exercises;
  List<ExerciseData> selectedItems = [];

  Map<int, bool> selectionMap = {};

  fillMap() {
    for (var i = 0; i < tempList.length; i++) {
      selectionMap[i] = false;
    }
  }

  /*
  @override
  Widget build(BuildContext context) {
    fillMap();
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0),
            body: Container(
                child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.05, 12, 12, 0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Workout hinzufügen',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff31a6dc))))),
                Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: tempList.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(selectionMap.entries);
                          return Card(
                              child: Container(
                            color: (selectionMap[index] = true)
                                ? Colors.blue.withOpacity(0.5)
                                : Colors.transparent,
                            child: ListTile(
                                title: Text('${tempList[index].name}'),
                                onTap: () {
                                  print('ööö' + selectionMap[index].toString());
                                  setState(() {
                                    if (selectionMap[index] = false) {
                                      selectionMap[index] = true;
                                    } else {
                                      selectionMap[index] = false;
                                    }
                                  });
                                }),

                            /*
                          child: Card(
                              child: Row(children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          child: Image.asset(tempList[index].imageName),
                        ),
                        Container(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('${tempList[index].name}',
                              maxLines: 3,
                              style: TextStyle(
                                  color: Color(0xff2b2c3c),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ))
                      ]))*/
                          ));
                        }))
              ],
            ))));
  }
  */
  List<int> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Select List Items'),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              color: (_selectedItems.contains(index))
                  ? Colors.blue.withOpacity(0.5)
                  : Colors.transparent,
              child: ListTile(
                onTap: () {
                  if (_selectedItems.contains(index)) {
                    setState(() {
                      _selectedItems.removeWhere((val) => val == index);
                    });
                  }
                },
                onLongPress: () {
                  if (!_selectedItems.contains(index)) {
                    setState(() {
                      _selectedItems.add(index);
                    });
                  }
                },
                title: Text('$index'),
              ),
            );
          },
        ),
      ),
    );
  }
}
