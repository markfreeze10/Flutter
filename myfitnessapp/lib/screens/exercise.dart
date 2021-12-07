import 'package:flutter/material.dart';
import 'package:myfitnessapp/data/exercises.dart';
import 'package:myfitnessapp/userdata/exercise_data.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  BodyCategory bodyCategory = BodyCategory.all;

  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20),
    primary: Color(0xff31a6dc),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  double widthSizedbox = 0.9;
  double heigthSizedbox = 0.065;

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
                      padding: EdgeInsets.all(14),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Übungen',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff31a6dc))))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * widthSizedbox,
                      height:
                          MediaQuery.of(context).size.height * heigthSizedbox,
                      child: ElevatedButton(
                          style: style,
                          child: Text('Brust'),
                          onPressed: () {
                            _ExerciseScreenState()
                                .setCategory(BodyCategory.chest);
                            _navigateToNextScreen(context);
                          })),
                  SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * widthSizedbox,
                      height:
                          MediaQuery.of(context).size.height * heigthSizedbox,
                      child: ElevatedButton(
                          style: style,
                          child: Text('Rücken'),
                          onPressed: () {
                            setState(() {
                              setCategory(BodyCategory.back);
                            });
                            _navigateToNextScreen(context);
                          })),
                  SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * widthSizedbox,
                      height:
                          MediaQuery.of(context).size.height * heigthSizedbox,
                      child: ElevatedButton(
                          style: style,
                          child: Text('Arme'),
                          onPressed: () {
                            setState(() {
                              setCategory(BodyCategory.arms);
                            });
                            _navigateToNextScreen(context);
                          })),
                  SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * widthSizedbox,
                      height:
                          MediaQuery.of(context).size.height * heigthSizedbox,
                      child: ElevatedButton(
                          style: style,
                          child: Text('Schultern'),
                          onPressed: () {
                            setState(() {
                              setCategory(BodyCategory.shoulders);
                            });
                            _navigateToNextScreen(context);
                          })),
                  SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * widthSizedbox,
                      height:
                          MediaQuery.of(context).size.height * heigthSizedbox,
                      child: ElevatedButton(
                          style: style,
                          child: Text('Beine'),
                          onPressed: () {
                            setState(() {
                              setCategory(BodyCategory.legs);
                            });
                            _navigateToNextScreen(context);
                          })),
                  SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * widthSizedbox,
                      height:
                          MediaQuery.of(context).size.height * heigthSizedbox,
                      child: ElevatedButton(
                          style: style,
                          child: Text('Bauch'),
                          onPressed: () {
                            setState(() {
                              setCategory(BodyCategory.abs);
                            });
                            _navigateToNextScreen(context);
                          })),
                  SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * widthSizedbox,
                      height:
                          MediaQuery.of(context).size.height * heigthSizedbox,
                      child: ElevatedButton(
                          style: style,
                          child: Text('Mobility'),
                          onPressed: () {
                            setState(() {
                              setCategory(BodyCategory.mobility);
                            });
                            _navigateToNextScreen(context);
                          })),
                  SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * widthSizedbox,
                      height:
                          MediaQuery.of(context).size.height * heigthSizedbox,
                      child: ElevatedButton(
                          style: style,
                          child: Text('Alle Kategorien'),
                          onPressed: () {
                            setState() => bodyCategory = BodyCategory.all;
                            _navigateToNextScreen(context);
                          })),
                ])));
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const ExerciseListScreen(bodyCategory: BodyCategory.abs)));
  }

  void setCategory(BodyCategory bodyCategory) {
    this.bodyCategory = bodyCategory;
  }
}

class ExerciseListScreen extends StatefulWidget {
  const ExerciseListScreen(
      {Key? key, required: BodyCategory, required this.bodyCategory})
      : super(key: key);

  final BodyCategory bodyCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          //elevation
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: Exercises.length,
            itemBuilder: (BuildContext context, int index) {
              print('hallooo' + bodyCategory.toString());
              return Container(
                height: 50,
                margin: EdgeInsets.all(2),
                color: Colors.green,
                child: Center(
                    child: Text(
                  bodyCategory.toString(),
                  //_ExerciseScreenState.getCategory.toString(),
                  //'${Exercises[index].name}',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                )),
              );
            }));
  }
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  /*
  Widget build(BuildContext context) => SliverPadding(
        padding: const EdgeInsets.all(16),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 8),
              Text(
                'Exercise',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 8),
              SizedBox(height: 8),
              buildWorkouts(),
            ],
          ),
        ),
      );

      Container(
  height: 120,
  child: ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: map.length,
    itemBuilder: (context, index) => Column(
      children: [
        Text(_country.elementAt(index).name),
        Text(_country.elementAt(index).capital),
Text(_country.elementAt(index).language),
      ],
    ),
  )
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          //elevation
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: Exercises.length,
            itemBuilder: (BuildContext context, int index) {
              print('hallooo' + bodyCategory.toString());
              return Container(
                height: 50,
                margin: EdgeInsets.all(2),
                color: Colors.green,
                child: Center(
                    child: Text(
                  bodyCategory.toString(),
                  //_ExerciseScreenState.getCategory.toString(),
                  //'${Exercises[index].name}',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                )),
              );
            }));
  }

  Widget buildWorkouts() => Column(
        children: Exercises.map(
          (exerciseSet) => Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
        ).toList(),
      );
}
