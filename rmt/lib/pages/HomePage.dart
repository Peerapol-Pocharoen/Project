import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:rmt/LocalNotification.dart';
import 'package:rmt/LocationTile.dart';
import 'package:rmt/TimeTile.dart';
import 'package:rmt/data/LocationDataBase.dart';
import 'package:rmt/data/TimeDataBase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _timeBox = Hive.box("timebox");
  final _locationBox = Hive.box("locationbox");

  // list of to do
  TimeDataBase timedb = TimeDataBase();
  LocationDataBase locationdb = LocationDataBase();

  // Delete Task
  void deleteTimeTask(int index) {
    LocalNotification.cancel(timedb.timeList[index][2]);
    setState(() {
      timedb.timeList.removeAt(index);
    });
    timedb.updateData();
  }

  void deleteLocationTask(int index) {
    //LocalNotification.cancel(locationdb.locationList[index][2]);
    setState(() {
      locationdb.locationList.removeAt(index);
    });
    locationdb.updateData();
  }

  @override
  void initState() {
    if (_timeBox.get("TIMELIST") == null) {
      timedb.createInitialData();
    } else {
      timedb.loadData();
    }

    if (_locationBox.get("LOCATIONLIST") == null) {
      locationdb.createInitialData();
    } else {
      locationdb.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xFF68bddf),
              Color(0xFF76cdde),
              Color(0xFF84dcde),
              Color(0xFF92ecdd),
              Color(0xFFa0fcdd),
            ],
            stops: [0, 0.25, 0.5, 0.75, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        ),
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 100, bottom: 10, right: 25),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [BoxShadow(
                        color: Color(0xFFFFD400),
                        spreadRadius: 1,
                        offset: Offset(5, 5)
                    )]
                    ),
                    child: FittedBox(fit: BoxFit.scaleDown, child:Text("On Time", style: TextStyle(fontWeight: FontWeight.bold)))
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: timedb.timeList.length,
                itemBuilder: (context, index) {
                  return TimeTile(
                      taskName: timedb.timeList[index][0],
                      time: timedb.timeList[index][1],
                      deleteFunction: (context) => deleteTimeTask(index));
                },
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 20, bottom: 10, right: 25),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [BoxShadow(
                        color: Color(0xFFFFD400),
                        spreadRadius: 1,
                        offset: Offset(5, 5)
                      )]
                    ),
                    child: FittedBox(fit: BoxFit.scaleDown, child:Text("On Location", style: TextStyle(fontWeight: FontWeight.bold)))
                ),
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: locationdb.locationList.length,
              itemBuilder: (context, index) {
                return LocationTile(
                    taskName: locationdb.locationList[index][0],
                    locationName: locationdb.locationList[index][1],
                    deleteFunction: (context) => deleteLocationTask(index));
              },
            )),
          ],
        ),
      ],
    );
  }
}
