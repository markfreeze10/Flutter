import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessapp/data/appData.dart';
import 'package:myfitnessapp/model/exercise_model.dart';
import 'package:myfitnessapp/model/workoutinfo_model.dart';
import 'package:myfitnessapp/model/workoutset_model.dart';
import 'package:myfitnessapp/screens/exercise.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  var kg = 0;
  var reps = 0;
  WorkoutSet wSet = WorkoutSet(reps: 10, kg: 5);
  WorkoutInfo wInfo = WorkoutInfo(
      workoutName: "Brust Trizeps",
      workoutDescription: "..",
      exerciseList: tempExercises,
      likes: 3,
      categoryList: bList,
      level: Level.rookie,
      liked: true);

  Map<String, dynamic> tMap = {};
  Map<String, dynamic> _workoutInfoToJson(WorkoutInfo instance) =>
      <String, dynamic>{
        'exerciseList': instance.exerciseList,
      };
  Widget w = Text('hh');
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> workoutinfo2 =
        FirebaseFirestore.instance.collection('workoutinfo').snapshots();
    /* var snapshot =  FirebaseFirestore.instance.collection('workoutinfo').get();
    return snapshot. */

    //CollectionReference exerciseData = FirebaseFirestore.instance.collection('exerciseData');
    /* CollectionReference workoutinfo =
        FirebaseFirestore.instance.collection('workoutinfo'); */
    return Center(
        child: Container(
            color: Colors.transparent,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('workoutinfo')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Container(
                        child: Center(
                            child: Text(document['exerciseList'].toString())),
                      );
                    }).toList(),
                  );
                  /*Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
         ElevatedButton(
            onPressed: () {
              var x = exer.toJson();
              var y = wInfo.toJson();
              
              //print(x);
              //print(y);
              //exerciseData.add(x);
              //workoutinfo.add(y);
              //print(x);

              /* StreamBuilder<QuerySnapshot>(
                  stream: workoutinfo,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    final data = snapshot.requireData;

                    setState(() {
                      w = Text('${data.docs[0]['name']}');
                    });
                    print('hhh');
                    print('${data.docs[0]['name']}');
                    return Text('${data.docs[0]['name']}');
                  }); */
              //workoutinfo.get()
              // FirebaseFirestore.instance
              //     .collection("workoutinfo")
              //     .doc("AEOzxt1IoY5jvoHTkoKB")
              //     .snapshots
              //print(tMap);
              //workoutinfo.add(x);
              //var y = jsonDecode(x);
              //print(x);
              //workoutInfoList[0].toJson();
              //workoutInfoList[0].fromJson();
              // print(workoutList);
              // print('asdasf');
            },
            child: Text('gude')), */
                })));
  }
}
