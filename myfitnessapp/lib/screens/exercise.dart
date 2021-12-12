import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessapp/data/exercises.dart';
import 'package:myfitnessapp/userdata/exercise_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20),
    primary: Color(0xff31a6dc),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  BodyCategory bodyCategory = BodyCategory.abs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          child: Text('Übungen',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff31a6dc))))),
                  SizedBox(height: 20),
                  initializeButton('Brust', BodyCategory.chest),
                  SizedBox(height: 10),
                  initializeButton('Rücken', BodyCategory.back),
                  SizedBox(height: 10),
                  initializeButton('Arme', BodyCategory.arms),
                  SizedBox(height: 10),
                  initializeButton('Schultern', BodyCategory.shoulders),
                  SizedBox(height: 10),
                  initializeButton('Beine', BodyCategory.legs),
                  SizedBox(height: 10),
                  initializeButton('Bauch', BodyCategory.abs),
                  SizedBox(height: 10),
                  initializeButton('Mobility', BodyCategory.mobility),
                  SizedBox(height: 10),
                  initializeButton('Alle Übungen', BodyCategory.all)
                ])));
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ExerciseListScreen(),
            settings: RouteSettings(arguments: bodyCategory)));
  }

  Widget initializeButton(String buttonName, BodyCategory category) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.065,
        child: ElevatedButton(
            style: style,
            child: Text(buttonName),
            onPressed: () {
              setState(() {
                bodyCategory = category;
              });
              _navigateToNextScreen(context);
            }));
  }
}
// -----------------------------------------------------------------------

class ExerciseListScreen extends StatefulWidget {
  const ExerciseListScreen({Key? key}) : super(key: key);

  @override
  _ExerciseListScreen createState() => _ExerciseListScreen();
}

class _ExerciseListScreen extends State<ExerciseListScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController exerciseController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<ExerciseData> searchList = [];
  List<ExerciseData> addedExercises = [];

  List<BodyCategory> allCategories = [
    BodyCategory.chest,
    BodyCategory.back,
    BodyCategory.arms,
    BodyCategory.shoulders,
    BodyCategory.legs,
    BodyCategory.abs,
    BodyCategory.mobility
  ];

  BodyCategory dropDownCategory = BodyCategory.back;

  static const String defaultImg = 'assets/strong.png';

  final exercise = ExerciseData(
      name: 'hallo',
      description: 'hallo',
      category: BodyCategory.abs,
      imageName: 'defaultImg',
      editable: false);

  final exercise2 = ExerciseData(
      name: 'hallooo',
      description: 'hallooo',
      category: BodyCategory.abs,
      imageName: 'defaultImg',
      editable: false);

  Future<void> saveExerciseToSP(List<ExerciseData> exerciseList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var encodedExercises = json.encode(exerciseList);
    prefs.setString(exerciseList.toString(), encodedExercises);
    print('hey ' + exerciseList.toString());
  }

  Future<void> getExerciseFromSP(ExerciseData exerciseData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

/*
  Future<void> saveUserInfo() async {
    Map<String, dynamic> exerciseMap;

    String exercisesJson = jsonEncode(Exercises);
    final json = Exercises.toJson();
    print('Json: ${exercise.toJson()}');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setStringList('Exercises', jsonEncode(Exercises));
    bool result2 = await prefs.setString('exercise2', jsonEncode(exercise2));

    print('gude ' + result.toString());
  }

  Future<ExerciseData?> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? exerciseStr = prefs.getString('exercise');
    final String? exerciseStr2 = prefs.getString('exercise2');

    Map<String, dynamic> exerciseMap = jsonDecode(prefs.getString('exercise')!);

    if (exerciseMap != null) {
      final ExerciseData exer = ExerciseData.fromJson(exerciseMap);
      print(exer);
      print('tach');
      return exer;
    }
    return null;
  }
  */

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as BodyCategory;
    String categoryName = getCategoryName(category);
    saveExerciseToSP(Exercises);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          title: Text(categoryName,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    //addedExercises.add(exerciseData);
                    addExercisePopUp(category);
                  });
                },
                icon: Icon(Icons.add_circle_outline, color: Colors.black))
          ],
        ),
        body: Container(
            //Container für die Suchfunktion über den Übungen
            child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                onChanged: (value) {
                  onSearchChanged(value, category);
                },
                controller: searchController,
                decoration: InputDecoration(
                    labelText: "Search",
                    //hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)))),
              )),
          searchList.isNotEmpty || searchController.text.isNotEmpty
              ? expandList(searchList, category)
              : expandList(Exercises, category),
        ])));
  }

  Future addExercisePopUp(BodyCategory category) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Übung hinzufügen'),
              content: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(4),
                        child: Text('Name der Übung: ')),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: exerciseController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)))),
                        )),
                    Padding(
                        padding: EdgeInsets.all(4),
                        child: Text('Beschreibung:')),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)))),
                        )),
                    checkCategoryAddExercise(category)
                  ])),
              actions: [
                TextButton(onPressed: saveExercise, child: Text('Speichern'))
              ],
            );
          });
        });
  }

  checkCategoryAddExercise(BodyCategory category) {
    if (category == BodyCategory.all) {
      return Column(children: [
        Padding(padding: EdgeInsets.all(4), child: Text('Kategorie: ')),
        Padding(
            padding: EdgeInsets.all(1),
            child: DropdownButton<BodyCategory>(
              value: dropDownCategory,
              underline: Container(
                height: 2,
                color: Color(0xff31a6dc),
              ),
              items: allCategories.map((BodyCategory bodyCategory) {
                return new DropdownMenuItem<BodyCategory>(
                  value: bodyCategory,
                  child: new Text(getCategoryName(bodyCategory)),
                );
              }).toList(),
              onChanged: (BodyCategory? newCategory) {
                setState(() {
                  dropDownCategory = newCategory!;
                });
              },
            ))
      ]);
    } else {
      dropDownCategory = category;
      return SizedBox();
    }
  }

  saveExercise() {
    setState(() {
      ExerciseData newExercise = new ExerciseData(
          name: exerciseController.text,
          description: descriptionController.text,
          category: dropDownCategory,
          imageName: defaultImg,
          editable: true);
      Exercises.add(newExercise);
    });

    Navigator.of(context).pop();
    exerciseController.clear();
    descriptionController.clear();
  }

  createPopUp(context, String name, String description, String imageName,
      BodyCategory bodyCategory) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      padding: EdgeInsets.all(15),
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: <Widget>[
                          Text('Ausführung',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Container(
                              width: 300,
                              height: 300,
                              child: Image.asset(imageName)),
                          SizedBox(height: 10),
                          Container(child: Text(description))
                        ],
                      ))));
        });
  }

  onSearchChanged(String value, BodyCategory category) async {
    setState(() {
      searchList = Exercises.where((ExerciseData) =>
          ExerciseData.name.toLowerCase().contains(value.toLowerCase()) &&
          (ExerciseData.category == category ||
              category == BodyCategory.all)).toList();
    });
  }

  Widget gestureDetectBuilder(
      List<ExerciseData> list, int index, BodyCategory category) {
    return GestureDetector(
        onTap: () {
          createPopUp(context, list[index].name, list[index].description,
              list[index].imageName, category);
        },
        child: Card(
            child: Row(children: <Widget>[
          Container(
            width: 100,
            height: 100,
            child: Image.asset(list[index].imageName),
          ),
          Container(
              child: Padding(
            padding: EdgeInsets.all(8),
            child: Text('${list[index].name}',
                maxLines: 3,
                style: TextStyle(
                    color: Color(0xff2b2c3c),
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ))
        ])));
  }

  //checken, ob Übung neu angelegt wurde
  //nur neu angelegte Übungen dürften gelöscht werden
  Widget checkDismissed(
      List<ExerciseData> list, int index, BodyCategory category) {
    if (list[index].editable) {
      return Dismissible(
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.redAccent,
        ),
        key: UniqueKey(),
        child: gestureDetectBuilder(list, index, category),
        onDismissed: (direction) {
          setState(() {
            list.removeAt(index);
          });
        },
      );
    } else {
      return gestureDetectBuilder(list, index, category);
    }
  }

  //Liste mit Übungen
  Widget expandList(List<ExerciseData> list, BodyCategory category) {
    return Expanded(
      //Expanded mit Liste der Übungen
      child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            if (list[index].category == category) {
              return checkDismissed(list, index, category);
            } else if (category == BodyCategory.all) {
              return checkDismissed(list, index, category);
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
