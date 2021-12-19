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
  // final xy = FirebaseFirestore.instance
  //     .collection('workoutinfo')
  //     .withConverter<WorkoutInfo>(
  //       fromFirestore: (snapshots, _) =>
  //           WorkoutInfo.fromJson(snapshots.data()!),
  //       toFirestore: (workoutinfoo, _) => workoutinfoo.toJson(),
  //     );

  final Stream<QuerySnapshot> workoutinfoStream =
      FirebaseFirestore.instance.collection('workoutinfo').snapshots();

  // Future getUserData() async {
  //   var tempList = [];
  //   try {
  //     await workoutInformation.get().then((QuerySnapshot querySnapshot) {
  //       querySnapshot.docs.forEach((element) {
  //         tempList.add(element.data());
  //       });
  //     });
  //     return tempList;
  //   } catch (e) {
  //     return null;
  //   }
  // }

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

  Future<void> likeButton(String id, bool liked) async {
    var collection = FirebaseFirestore.instance.collection('workoutinfo');
    if (liked) {
      collection.doc(id).update({'likes': FieldValue.increment(-1)});
      collection.doc(id).update({'liked': false});
    } else {
      collection.doc(id).update({'likes': FieldValue.increment(1)});
      collection.doc(id).update({'liked': true});
    }
  }

  @override
  Widget build(BuildContext context) {
    //getFireBaseData();
    return Scaffold(
      appBar: AppBar(),
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
              final d = data.docs[index].data();
              bool liked = data.docs[index]['liked'];
              return Row(children: [
                Text('likes: ${data.docs[index]['likes']}'),
                IconButton(
                    onPressed: () {
                      final id = data.docs[index].id;
                      bool liked = data.docs[index]['liked'];
                      print(id);
                      likeButton(id, liked);
                      FirebaseFirestore.instance
                          .collection('workoutinfo')
                          .orderBy('likes', descending: true);
                      setState(() {});
                    },
                    icon: (liked)
                        ? Icon(Icons.star)
                        : Icon(Icons.star_border_outlined))
              ]);
            },
          );
        },
      ),
    );
  }
}
