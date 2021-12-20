import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
  List<WorkoutInfo> listee = [];

  final Stream<QuerySnapshot> workoutinfoStream =
      FirebaseFirestore.instance.collection('workoutinfo').snapshots();
  final CollectionReference workoutinfoCollection =
      FirebaseFirestore.instance.collection('workoutinfo');

  getFireBaseData() async {
    Map<String, dynamic> map;

    var collection = FirebaseFirestore.instance.collection('workoutinfo');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> dataa = queryDocumentSnapshot.data();
      var x = WorkoutInfo.fromJson(dataa);
      listee.add(x);
      print(queryDocumentSnapshot.data());
    }
    print(listee.length);
  }

  Future<void> likeButton(
      QuerySnapshot<Object?> data, int index, bool liked) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot freshSnap =
          await transaction.get(data.docs[index].reference);
      if (liked) {
        await transaction
            .update(freshSnap.reference, {'likes': freshSnap['likes'] - 1});
        await transaction.update(freshSnap.reference, {'liked': false});
      } else {
        await transaction
            .update(freshSnap.reference, {'likes': freshSnap['likes'] + 1});
        await transaction.update(freshSnap.reference, {'liked': true});
      }
    });
    // var collection = FirebaseFirestore.instance.collection('workoutinfo');
    // if (liked) {
    //   collection.doc(id).update({'likes': FieldValue.increment(-1)});
    //   collection.doc(id).update({'liked': false});
    // } else {
    //   collection.doc(id).update({'likes': FieldValue.increment(1)});
    //   collection.doc(id).update({'liked': true});
    // }
  }

  @override
  Widget build(BuildContext context) {
    //categoryListStringBuilder();
    return Scaffold(
      appBar: AppBar(actions: [
        Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 5),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    uploadDialog();
                  });
                },
                icon: Icon(Icons.cloud_upload_outlined,
                    size: 40.0, color: Colors.black)))
      ]),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('workoutinfo')
            .orderBy('likes', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('error');
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.requireData;
          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              final d = data.docs[index]['categoryList'];

              //print('i');
              //print(data.docs.length);
              bool liked = data.docs[index]['liked'];
              return Row(children: [
                Expanded(
                  child: ListTile(
                      title: Text('${data.docs[index]['name']}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text('level: ${data.docs[index]['level']}',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      isThreeLine: true,
                      onTap: () {
                        openExploreWorkout(data, index, data.docs);
                      }),
                ),
                Column(children: [
                  IconButton(
                      onPressed: () {
                        final id = data.docs[index].id;
                        //print(id);
                        bool liked = data.docs[index]['liked'];
                        likeButton(data, index, liked);
                        var x = data.docs.asMap();
                        //print(x);
                        //print('hallo');
                        setState(() {});
                      },
                      icon: (liked)
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border_outlined)),
                  Text('${data.docs[index]['likes']}')
                ])
              ]);
            },
          );
        },
      ),
    );
  }

  Future uploadDialog() {
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
                    child: ListView.builder(
                        itemCount: workoutInfoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(children: [
                            Expanded(
                                child: ListTile(
                              title: Text(workoutInfoList[index]
                                  .workoutName
                                  .toString()),
                            )),
                            IconButton(
                                onPressed: () {
                                  workoutinfoCollection
                                      .add(workoutInfoList[index].toJson());
                                  print('Success');
                                },
                                icon: Icon(Icons.upload))
                          ]);
                        }),
                  )));
        });
  }

  Future openExploreWorkout(QuerySnapshot<Object?> data, int index,
      List<QueryDocumentSnapshot<Object?>> docs) async {
    List<Widget> widgetList = [];
    String str = "";
    int counter = 0;
    var collection = FirebaseFirestore.instance.collection('workoutinfo');
    var querySnapshot = await collection.get();

    str = "";
    counter = 0;
    Map<String, dynamic> data = querySnapshot.docs[index].data();

    var catList = data['categoryList'];
    var nameMap = data['exerciseList'];

    catList.forEach((element) {
      if (counter == 0) {
        str = str + element.toString();
      } else {
        str = str + ', ' + element.toString();
      }
      counter++;
    });
    String name = "name";
    nameMap.forEach((element) {
      String str = element[name];

      widgetList.add(Expanded(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Column(children: [
                Text(str,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ))
              ]))));
    });

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
                      child: Column(children: [
                        Text('${docs[index]['name']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.width * 0.2,
                            margin: EdgeInsets.only(top: 40),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(children: [
                                  Expanded(
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              'Level: ${docs[index]['level']}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.bold)))),
                                  Expanded(
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Column(children: [
                                            Text('Kategorie: ' + str,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ])))
                                ]))),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.width * 0.6,
                            margin: EdgeInsets.only(top: 40),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(children: widgetList))),
                      ]))));
        });
  }
}
