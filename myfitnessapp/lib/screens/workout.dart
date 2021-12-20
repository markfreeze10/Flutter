import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessapp/base.dart';
import 'package:myfitnessapp/data/appData.dart';
import 'package:myfitnessapp/model/exercise_model.dart';
import 'package:myfitnessapp/model/workout_model.dart';
import 'package:myfitnessapp/model/workoutinfo_model.dart';
import 'package:myfitnessapp/model/workoutset_model.dart';
import 'package:myfitnessapp/screens/calendar.dart';
import 'package:myfitnessapp/screens/exercise.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 5),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      //...
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WorkoutSelectScreen()));
                  },
                  icon: Icon(Icons.add_circle_outline,
                      size: 40.0, color: Colors.black)))
        ],
      ),
      body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05, 12, 12, 0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Workouts',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff31a6dc))))),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              //color: Colors.blue,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff31a6dc)),
              child: (!workoutInfoList.isEmpty)
                  ? ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: (workoutInfoList.isEmpty)
                          ? 1
                          : workoutInfoList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.redAccent,
                          ),
                          key: UniqueKey(),
                          child: Card(
                              child: ListTile(
                                  title:
                                      Text(workoutInfoList[index].workoutName),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const WorkoutStartScreen(),
                                            settings: RouteSettings(
                                                arguments: index)));
                                  })),
                          onDismissed: (direction) {
                            setState(() {
                              workoutInfoList.removeAt(index);
                            });
                          },
                        );
                      })
                  : Center(
                      child: Text('No Workouts created!',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))),
            )
          ]),
    );
  }

  List<String> extractNameOfWorkouts(List<WorkoutInfo> workoutInfoList) {
    setState(() {});
    List<String> stringList = [];
    workoutInfoList.forEach((element) {
      stringList.add(element.workoutName);
    });
    return stringList;
  }
}

//Class for starting the workout

class WorkoutStartScreen extends StatefulWidget {
  const WorkoutStartScreen({Key? key}) : super(key: key);

  @override
  _WorkoutStartScreenState createState() => _WorkoutStartScreenState();
}

class _WorkoutStartScreenState extends State<WorkoutStartScreen> {
  @override
  Widget build(BuildContext context) {
    final workoutIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: //Text(workoutInfoList[0].exerciseList[0].name)
          Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05, 12, 12, 0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Workout starten',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff31a6dc))))),
        Container(
            height: MediaQuery.of(context).size.height * 0.6,
            //color: Colors.blue,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff31a6dc)),
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: workoutInfoList[workoutIndex].exerciseList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
                          title: Text(workoutInfoList[workoutIndex]
                              .exerciseList[index]
                              .name),
                          onTap: () {}));
                })),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
                onPressed: () {
                  pageCounter = 0;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WorkoutEntryScreen(),
                          settings: RouteSettings(arguments: workoutIndex)));
                  //print(workoutTempList);
                },
                child: Text('Workout starten',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff2b2c3c),
                )))
      ]),
    );
  }
}

//Workout starten und Werte eintragen
class WorkoutEntryScreen extends StatefulWidget {
  const WorkoutEntryScreen({Key? key}) : super(key: key);

  @override
  _WorkoutEntryScreenState createState() => _WorkoutEntryScreenState();
}

class _WorkoutEntryScreenState extends State<WorkoutEntryScreen> {
  TextEditingController weightController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  List<Widget> widgetList = [];
  List<Widget> tempWidgetList = [];
  int setCounter = 1;

  DateTime dateX = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  List<WorkoutSet> setList = [];
  List<WorkoutSet> setTempList = [];
  List<Workout> workoutTempList = [];
  @override
  Widget build(BuildContext context) {
    final workoutIndex = ModalRoute.of(context)!.settings.arguments as int;

    WorkoutSet set;

    Widget entryText = Container(
        //margin: new EdgeInsets.all(8.0),
        child: new TextField(
            decoration: new InputDecoration(
                hintText: (weightController.text.length != 0)
                    ? '$setCounter' +
                        ': ' +
                        weightController.text +
                        ' kg x ' +
                        repsController.text +
                        ' wdh'
                    : '$setCounter' + ': ' + repsController.text + ' wdh')));
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {
                        setState(() {});

                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2010, 1, 1),
                            maxTime: DateTime(2025, 12, 31), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          dateX = date;
                        }, currentTime: DateTime.now(), locale: LocaleType.de);
                      },
                      icon: Icon(Icons.date_range_outlined,
                          size: 32, color: Colors.black)))
            ]),
        body: //Text(workoutInfoList[0].exerciseList[0].name)
            Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.05, 12, 12, 0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      workoutInfoList[workoutIndex]
                          .exerciseList[pageCounter]
                          .name,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff31a6dc))))),
          Container(
              height: 100,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 50,
                          width: 120,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            onChanged: (value) {
                              setState(() {});
                            },
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "kg",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4.0)))),
                          )),
                      SizedBox(
                          height: 50,
                          width: 120,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            onChanged: (value) {
                              setState(() {});
                            },
                            validator: (value) {
                              if (value!.length == 0) {
                                return 'Es müssen die Wiederholungen eingetragen werden';
                              } else {
                                return null;
                              }
                            },
                            controller: repsController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                                labelText: "wdh",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4.0)))),
                          )),
                      SizedBox(
                          height: 50,
                          width: 100,
                          child: ElevatedButton(
                              onPressed: () {
                                if (repsController.text.isEmpty) {
                                  return null;
                                } else {
                                  widgetList.add(entryText);
                                  setState(() {});
                                  setCounter++;
                                  if (workoutTempList.length == pageCounter ||
                                      workoutTempList.isEmpty) {
                                    print('amk');
                                    workoutTempList.add(new Workout(
                                        workoutInfo:
                                            workoutInfoList[workoutIndex],
                                        exerciseData:
                                            workoutInfoList[workoutIndex]
                                                .exerciseList[pageCounter],
                                        notes: noteController.text,
                                        dateTime: dateX,
                                        workoutSet: []));
                                  }
                                  workoutTempList[pageCounter].workoutSet.add(
                                      WorkoutSet(
                                          reps: int.parse(repsController.text),
                                          kg: (weightController.text.length !=
                                                  0)
                                              ? double.parse(
                                                  weightController.text)
                                              : 0));
                                  //workoutTempList[pageCounter - 1].workoutSet
                                }
                              },
                              child: Text('Add +',
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff2b2c3c),
                              ))),
                    ]),
              )),
          Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: SizedBox(
                            child: TextField(
                      textAlign: TextAlign.left,
                      onChanged: (value) {},
                      controller: noteController,
                      decoration: InputDecoration(
                          labelText: "Notizen...",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)))),
                    )))
                  ])),
          Expanded(
              child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: widgetList.length,
                      itemBuilder: (context, index) => widgetList[index],
                    ),
                  ))),
          Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    (pageCounter == 0)
                        ? SizedBox()
                        : ElevatedButton(
                            onPressed: () {
                              widgetList.clear();
                              //print(workoutTempList[pageCounter - 1].workoutSet);

                              //aktualisieren von Datetime und Notizen in der jeweiligen Workout-Datei
                              workoutTempList.forEach((element) {
                                if (element.exerciseData.name ==
                                    workoutInfoList[workoutIndex]
                                        .exerciseList[pageCounter]
                                        .name) {
                                  element.notes = noteController.text;
                                  element.dateTime = dateX;
                                }
                              });

                              if (pageCounter != 0) {
                                checkExistingEntry(
                                    workoutTempList,
                                    workoutInfoList,
                                    setList,
                                    widgetList,
                                    pageCounter,
                                    workoutIndex,
                                    0);

                                pageCounter = pageCounter - 1;
                                setState(() {});
                                setCounter = 1;
                                weightController.clear();
                                repsController.clear();
                                noteController.clear();
                                //widgetList.add(entryText);
                              }
                            },
                            child: Text(' Previous ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff2b2c3c),
                            )),
                    ElevatedButton(
                        onPressed: () {
                          widgetList.clear();

                          if (pageCounter <
                              workoutInfoList[workoutIndex]
                                      .exerciseList
                                      .length -
                                  1) {
                            checkExistingEntry(
                                workoutTempList,
                                workoutInfoList,
                                setList,
                                widgetList,
                                pageCounter,
                                workoutIndex,
                                1);
                            if (workoutTempList.length == pageCounter ||
                                workoutTempList.isEmpty) {
                              print('aml');
                              workoutTempList.add(new Workout(
                                  workoutInfo: workoutInfoList[workoutIndex],
                                  exerciseData: workoutInfoList[workoutIndex]
                                      .exerciseList[pageCounter],
                                  notes: noteController.text,
                                  dateTime: dateX,
                                  workoutSet: []));
                            } else {
                              workoutTempList.forEach((element) {
                                if (element.exerciseData.name ==
                                    workoutInfoList[workoutIndex]
                                        .exerciseList[pageCounter]
                                        .name) {
                                  element.notes = noteController.text;
                                  element.dateTime = dateX;
                                }
                              });
                            }
                            ;
                            pageCounter = pageCounter + 1;
                            setCounter = 1;
                            setState(() {});
                            weightController.clear();
                            repsController.clear();
                            noteController.clear();
                          } else {
                            if (workoutTempList.length == pageCounter ||
                                workoutTempList.isEmpty) {
                              workoutTempList.add(new Workout(
                                  workoutInfo: workoutInfoList[workoutIndex],
                                  exerciseData: workoutInfoList[workoutIndex]
                                      .exerciseList[pageCounter],
                                  notes: noteController.text,
                                  dateTime: dateX,
                                  workoutSet: []));
                            } else {
                              workoutTempList.forEach((element) {
                                if (element.exerciseData.name ==
                                    workoutInfoList[workoutIndex]
                                        .exerciseList[pageCounter]
                                        .name) {
                                  element.notes = noteController.text;
                                  element.dateTime = dateX;
                                }
                              });
                            }
                            setCounter = 1;
                            setState(() {});
                            weightController.clear();
                            repsController.clear();
                            noteController.clear();
                            workoutList.addAll(workoutTempList);
                            workoutList.forEach((element) {
                              dates.add(element.dateTime);
                            });
                            workoutTempList.clear();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WorkoutScreen()));
                          }
                        },
                        child: (pageCounter ==
                                workoutInfoList[workoutIndex]
                                        .exerciseList
                                        .length -
                                    1)
                            ? Text('   Finish   ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24))
                            : Text('   Next    ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff2b2c3c),
                        ))
                  ]))
        ]));
  }

  Widget createWidget(int index, double weight, int reps) {
    return Container(
        //margin: new EdgeInsets.all(8.0),
        child: new TextField(
            decoration: new InputDecoration(
                hintText: (weight != null)
                    ? '$index' +
                        ': ' +
                        weight.toString() +
                        ' kg x ' +
                        reps.toString() +
                        ' wdh'
                    : '$index' + ': ' + reps.toString() + ' wdh')));
  }

  checkExistingEntry(
      List<Workout> workoutTempList,
      List<WorkoutInfo> workoutInfo,
      List<WorkoutSet> workoutSetList,
      List<Widget> wList,
      int pageCounter,
      int workoutIndex,
      int Prev0Next1) {
    if (Prev0Next1 == 0) {
      workoutTempList.forEach((element) {
        if (element.exerciseData.name ==
            workoutInfo[workoutIndex].exerciseList[pageCounter - 1].name) {
          workoutSetList = element.workoutSet;
          print(workoutSetList.length);
          //print(element.exerciseData.name);
          return;
        }
      });
    } else if (Prev0Next1 == 1) {
      workoutTempList.forEach((element) {
        if (element.exerciseData.name ==
            workoutInfo[workoutIndex].exerciseList[pageCounter + 1].name) {
          workoutSetList = element.workoutSet;
          print(workoutSetList.length);
          //print(element.exerciseData.name);
          return;
        }
      });
    }

    int counter = 1;
    workoutSetList.forEach((element) {
      wList.add(createWidget(counter, element.kg!, element.reps));
      counter++;
    });
  }
}

//------------------------------------------------------
//Class for selecting the Exercises for the Workout
class WorkoutSelectScreen extends StatefulWidget {
  const WorkoutSelectScreen({Key? key}) : super(key: key);

  @override
  _WorkoutSelectScreenState createState() => _WorkoutSelectScreenState();
}

class _WorkoutSelectScreenState extends State<WorkoutSelectScreen> {
  List<ExerciseData> tempList = Exercises;
  List<ExerciseData> selectedItems = [];

  var selectionMap = {
    for (var i = 0; i < Exercises.length; i++) Exercises[i]: false
  };

  @override
  Widget build(BuildContext context) {
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Workout erstellen',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff31a6dc))))),
                  Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.all(8),
                          itemCount: tempList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                child: Container(
                              child: CheckboxListTile(
                                  title: Text('${Exercises[index].name}'),
                                  value: selectionMap[Exercises[index]],
                                  onChanged: (value) {
                                    setState(() {
                                      selectionMap[Exercises[index]] = value!;
                                    });
                                  }),
                            ));
                          })),
                  Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 50),
                      //child:
                      //Align(alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: () {
                            if (collectExercises(selectionMap)) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WorkoutBuildScreen(),
                                      settings: RouteSettings(
                                          arguments: selectionMap)));
                            } else {
                              null;
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: (collectExercises(selectionMap)
                                  ? Colors.blue
                                  : Colors.blue.withOpacity(0.5)),
                              fixedSize: Size(100, 50)),
                          child: Text('Übungen hinzufügen',
                              style: TextStyle(
                                  color: (collectExercises(selectionMap)
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.7)),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))))
                ]))));
  }

  bool collectExercises(Map<ExerciseData, bool> map) {
    bool checked = false;
    map.forEach((key, value) {
      if (value) {
        checked = true;
      }
    });
    return checked;
  }
}

//----------------------HIER GEHTS LOS---------------
class WorkoutBuildScreen extends StatefulWidget {
  const WorkoutBuildScreen({Key? key}) : super(key: key);

  @override
  _WorkoutBuildScreenState createState() => _WorkoutBuildScreenState();
}

class _WorkoutBuildScreenState extends State<WorkoutBuildScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  List<ExerciseData> exerList = [];
  //List<WorkoutInfo> workoutInfoList = [];

  List<BodyCategory> selectedCategories = [];
  BodyCategory? tempCategory;

  final String chipName = "";
  bool _isSelected = false;
  List<bool> isSelected = [true, false, false];
  Future<void> saveWorkoutToSP(List<WorkoutInfo> workoutInfoList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var encodedWorkout = json.encode(workoutInfoList);
    prefs.setString(workoutInfoList.toString(), encodedWorkout);
    //print('hey ' + workoutInfoList.toString());
  }

  Level lvl = Level.rookie;

  Future<void> getWorkoutFromSP(List<WorkoutInfo> workoutInfoList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var decodedWorkout = prefs.get(workoutInfoList.toString());
    print(decodedWorkout);
  }

  @override
  Widget build(BuildContext context) {
    final map =
        ModalRoute.of(context)!.settings.arguments as Map<ExerciseData, bool>;

    exerList = extractExerciseData(map);

    final maxLines = 15;
    //saveWorkoutToSP(workoutInfoList);
    //getWorkoutFromSP(workoutInfoList);
    //print(firstSetList.length);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 12, 8),
                    child: ElevatedButton(
                        onPressed: () {
                          if (nameController.text.isEmpty) {
                            return null;
                          } else {
                            saveWorkout();
                          }
                        },
                        child: Text('Speichern',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ))))
            //icon: Icon(Icons.save, color: Colors.black))
          ],
        ),
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 40),
              child: TextFormField(
                validator: (value) {
                  //print(value!.length);
                  if (value!.length == 0) {
                    return ("Das Textfeld ist leer");
                  }
                  return null;
                },
                onChanged: (value) {},
                controller: nameController,
                decoration: InputDecoration(
                    labelText: "Name des Workouts",
                    //hintText: "Search",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)))),
              )),
          Container(
              height: maxLines * 20,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                maxLines: maxLines,
                textAlign: TextAlign.left,
                onChanged: (value) {},
                controller: descController,
                decoration: InputDecoration(
                    labelText: "Notizen",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)))),
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(9, 20, 9, 0),
              child: Container(
                  child: Wrap(
                spacing: 8.0,
                runSpacing: 3.0,
                children: <Widget>[
                  filterChipWidget(cat: 'Brust'),
                  filterChipWidget(cat: 'Rücken'),
                  filterChipWidget(cat: 'Schultern'),
                  filterChipWidget(cat: 'Bauch'),
                  filterChipWidget(cat: 'Arme'),
                  filterChipWidget(cat: 'Beine'),
                  filterChipWidget(cat: 'Mobility'),
                ],
              ))),
          ToggleButtons(
            selectedBorderColor: Colors.lightBlue,
            borderRadius: BorderRadius.circular(50),
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Anfänger')),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Fortgeschritten')),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text('Profi')),
            ],
            onPressed: (int index) {
              setState(() {
                switch (index) {
                  case 0:
                    lvl = Level.rookie;
                    break;
                  case 1:
                    lvl = Level.mid;
                    break;

                  case 2:
                    lvl = Level.pro;
                    break;
                  default:
                    break;
                }
                for (int buttonIndex = 0;
                    buttonIndex < isSelected.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    isSelected[buttonIndex] = true;
                  } else {
                    isSelected[buttonIndex] = false;
                  }
                }
              });
            },
            isSelected: isSelected,
          ),
        ]));
    //FilterChip(label: label, onSelected: onSelected)
  }

  Widget createFilterChip(BodyCategory cat) {
    Widget w = FilterChip(
        label: Text(getCategoryName(cat)),
        labelStyle: TextStyle(
            color: Color(0xff6200ee),
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
        selected: _isSelected,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: Color(0xffededed),
        onSelected: (isSelected) {
          setState(() {
            _isSelected = isSelected;
          });
        });
    return w;
  }

  List<BodyCategory> buildCategoryListFromString(List<String> strList) {
    List<BodyCategory> catList = [];
    strList.forEach((element) {
      catList.add(getNameFromCategory(element));
    });
    return catList;
  }

  saveWorkout() {
    setState(() {
      WorkoutInfo newWorkout = new WorkoutInfo(
          workoutName: nameController.text,
          workoutDescription: descController.text,
          exerciseList: exerList,
          level: lvl,
          categoryList: buildCategoryListFromString(selectedList),
          likes: 0,
          liked: false);

      workoutInfoList.add(newWorkout);
      print(newWorkout);
    });
    selectedList.clear();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutScreen(),
            settings: RouteSettings(arguments: workoutInfoList)));
    //Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
    nameController.clear();
    descController.clear();
  }

  List<ExerciseData> extractExerciseData(Map<ExerciseData, bool> map) {
    List<ExerciseData> list = [];
    map.forEach((key, value) {
      if (value) {
        list.add(key);
      }
    });
    return list;
  }
}

class filterChipWidget extends StatefulWidget {
  final String cat;

  filterChipWidget({Key? key, required this.cat}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.cat),
      labelStyle: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        if (isSelected) {
          selectedList.add(widget.cat);
        } else {
          selectedList.remove(widget.cat);
        }
        print(selectedList);
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Colors.blue,
    );
  }
}
