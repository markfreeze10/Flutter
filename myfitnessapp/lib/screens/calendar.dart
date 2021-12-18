import 'package:flutter/material.dart';
import 'package:myfitnessapp/data/appData.dart';
import 'package:myfitnessapp/model/workout_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool firstOpening = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //dates.add(DateTime(2020, 6, 24));
    dates.add(DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 0, 0, 0));
    setState(() {});
  }

  List<Widget>? widgetList = [];
  //int _counter = 0;
  late Widget w;
  getDates(List<Workout> list) {
    list.forEach((element) {
      dates.add(DateTime(element.dateTime.year, element.dateTime.month,
          element.dateTime.day, 0, 0, 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    getDates(workoutList);
    setState(() {});
    print(dates);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CalendarDatePicker(
              initialDate: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 0, 0, 1),
              firstDate: DateTime(2019, 1, 1),
              lastDate: DateTime(2022, 12, 31),
              selectableDayPredicate: ((date) => dates.contains(date)),
              onDateChanged: onDateChanged,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: widgetList!.length,
                    itemBuilder: (context, index) {
                      return widgetList![index];
                    }))
          ],
        ),
      ),
    );
  }

  Widget createWidget(String dateString, int i) {
    switch (i) {
      case (0):
        w = Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      dateString,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ))));
        break;
      case (1):
        w = Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      dateString,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ))));
        break;
      case (2):
        w = Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      dateString,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))));
        break;
      default:
    }

    return w;
  }

  void onDateChanged(DateTime value) {
    print('ääääää');
    bool b = false;
    widgetList!.clear();
    //haben das Datum als Rückgabewert bspw. 12.12.21
    workoutList.forEach((element) {
      //wenn WorkoutDatum = angeklicktes Datum im Kalendar => true
      if (element.dateTime == value) {
        //hinzufügen von Datum in die WidgetList
        if (b == false) {
          widgetList!.add(createWidget(
              DateFormat("dd.MM.yyyy").format(element.dateTime), 0));
          widgetList!.add(createWidget(element.exerciseData.name, 1));
          element.workoutSet.forEach((element) {
            widgetList!.add(createWidget(
                element.kg.toString() +
                    '  kg ' +
                    element.reps.toString() +
                    ' wdh',
                2));
          });
        } else {
          widgetList!.add(createWidget(element.exerciseData.name, 1));
          element.workoutSet.forEach((element) {
            widgetList!.add(createWidget(
                element.kg.toString() +
                    '  kg ' +
                    element.reps.toString() +
                    ' wdh',
                2));
          });
        }

        b = true;
        //element.workoutSet.forEach((set) {});
      }
    });
    print(widgetList!.length);
    setState(() {});

    dates.clear();
    dates.add(DateTime(2021, 12, 25));
  }
}
