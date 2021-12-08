import 'package:flutter/material.dart';
import 'package:myfitnessapp/data/exercises.dart';
import 'package:myfitnessapp/userdata/exercise_data.dart';

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

  double widthSizedbox = 0.9;
  double heigthSizedbox = 0.065;
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
                  SizedBox(
                      width: MediaQuery.of(context).size.width * widthSizedbox,
                      height:
                          MediaQuery.of(context).size.height * heigthSizedbox,
                      child: ElevatedButton(
                          style: style,
                          child: Text('Brust'),
                          onPressed: () {
                            setState(() {
                              bodyCategory = BodyCategory.chest;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ExerciseListScreen(),
                                    settings: RouteSettings(
                                        arguments: bodyCategory)));
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
                              bodyCategory = BodyCategory.back;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ExerciseListScreen(),
                                    settings: RouteSettings(
                                        arguments: bodyCategory)));
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
                              bodyCategory = BodyCategory.arms;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ExerciseListScreen(),
                                    settings: RouteSettings(
                                        arguments: bodyCategory)));
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
                              bodyCategory = BodyCategory.shoulders;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ExerciseListScreen(),
                                    settings: RouteSettings(
                                        arguments: bodyCategory)));
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
                              bodyCategory = BodyCategory.legs;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ExerciseListScreen(),
                                    settings: RouteSettings(
                                        arguments: bodyCategory)));
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
                              bodyCategory = BodyCategory.abs;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ExerciseListScreen(),
                                    settings: RouteSettings(
                                        arguments: bodyCategory)));
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
                              bodyCategory = BodyCategory.mobility;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ExerciseListScreen(),
                                    settings: RouteSettings(
                                        arguments: bodyCategory)));
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
                            setState(() {
                              bodyCategory = BodyCategory.all;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ExerciseListScreen(),
                                    settings: RouteSettings(
                                        arguments: bodyCategory)));
                          })),
                ])));
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ExerciseListScreen(),
            settings: RouteSettings(arguments: bodyCategory)));
  }
}

class ExerciseListScreen extends StatefulWidget {
  const ExerciseListScreen({Key? key}) : super(key: key);

  @override
  _ExerciseListScreen createState() => _ExerciseListScreen();
}

class _ExerciseListScreen extends State<ExerciseListScreen> {
//BodyCategory cat = _ExerciseScreenState().getCategory;

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as BodyCategory;
    String categoryName = getCategoryName(category);
    //final List<ExerciseData> exerciseData = Exercises.where(Exercises[index])

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
          elevation: 0,
        ),
        body: Container(
          color: Color(0xff31a6dc),

          //margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          child: ListView.builder(

              //padding: EdgeInsets.only(top: 8.0),
              itemCount: Exercises.length,
              itemBuilder: (BuildContext context, int index) {
                if (Exercises[index].category == category) {
                  return GestureDetector(
                      onTap: () {
                        createPopUp(
                            context,
                            Exercises[index].name,
                            Exercises[index].description,
                            Exercises[index].imageName,
                            category);
                      },
                      child: Card(
                          child: Row(children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          child: Image.asset(Exercises[index].imageName),
                        ),
                        Container(
                            child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('${Exercises[index].name}',
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Color(0xff2b2c3c),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))))
                      ])));
                } else if (category == BodyCategory.all) {
                  return GestureDetector(
                      onTap: () {
                        createPopUp(
                            context,
                            Exercises[index].name,
                            Exercises[index].description,
                            Exercises[index].imageName,
                            category);
                      },
                      child: Card(
                          child: Row(children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          child: Image.asset(Exercises[index].imageName),
                        ),
                        Container(
                            child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('${Exercises[index].name}',
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Color(0xff2b2c3c),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))))
                      ])));
                } else {
                  return const SizedBox();
                }
              }),
        ));
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
}
