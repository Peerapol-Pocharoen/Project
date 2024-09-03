import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:rmt/LocalNotification.dart';
import 'package:rmt/data/TimeDataBase.dart';
import 'package:rmt/pages/CreateLocation.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:timezone/timezone.dart' as tz;

class CreateTime extends StatefulWidget {
  const CreateTime({super.key});

  @override
  State<CreateTime> createState() => _CreateTimeState();
}

class _CreateTimeState extends State<CreateTime> {
  TimeDataBase timedb = TimeDataBase();

  TextEditingController textController = TextEditingController();
  DateTime today = DateTime.now();
  int hour = 0;
  int min = 0;

  bool thisPage = true;
  bool newValue = false;
  bool isSwitched = false;
  final _controller = ValueNotifier<bool>(false);

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void saveTimeTask() {
    final time =
        DateTime(today.year, today.month, today.day, hour, min, 0, 0, 0);

    if (time.compareTo(DateTime.now()) > 0) {
      final scheduledDate = tz.TZDateTime.from(time, tz.getLocation('Asia/Bangkok')); // region-lang
      LocalNotification.showScheduleNotification(
        id: timedb.timeList.length*2+1,
        title: textController.text,
        body: "${today.day}-${today.month}-${today.year} ${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}",
        payload: "Something",
        scheduledDate: scheduledDate);
      
      timedb.timeList.add([
        textController.text,
        "${today.day}-${today.month}-${today.year} ${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}",
        timedb.timeList.length*2+1,
        today,
        hour,
        min
      ]);
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: const Text("Ok")),
          ],
          title: const Text("RMT"),
          contentPadding: const EdgeInsets.all(20),
          content: const Text("Task Submited"),
        ));
    } else {
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: const Text("Close")),
          ],
          title: const Text("RMT"),
          contentPadding: const EdgeInsets.all(20),
          content: const Text("Invalid date and/or time"),
        ));
    }

    setState(() {
      timedb.updateData();
      textController.clear();
      today = DateTime.now();
      hour = 0;
      min = 0;
    });
  }

  @override
  void initState() {
    timedb.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!thisPage)
        ? const CreateLocation()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              alignment: Alignment.topCenter,
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
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 40 ,left:50, right: 20, bottom: 10),
                              child: AdvancedSwitch(
                                  
                                  initialValue: newValue,
                                  controller: _controller,
                                  activeColor: const Color.fromARGB(255, 253, 228, 0),
                                  inactiveColor:
                                      const Color.fromARGB(255, 253, 228, 0),
                                  activeChild: const Text(
                                    "Location",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  inactiveChild: const Text("Time",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  width: 97,
                                  height: 30,
                                  enabled: true,          
                                  onChanged: (newValue) => setState(() {
                                        thisPage = false;
                                      })),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: SizedBox(
                                width: 160,
                                height: 45,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      hintText: "Insert title here",
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),                                
                                      filled: true,
                                      fillColor: Color.fromARGB(255, 255, 255, 255)),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  textInputAction: TextInputAction.done,
                                  controller: textController,
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Container(
                              decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(5),
                                   color: Color(0xFF956DEB)
                                ),
                              child: TextButton(
                                onPressed: saveTimeTask,
                                child: const Text("Submit", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white))),
                            ),
                          )],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: 300,
                      height: 300,
                      padding: const EdgeInsets.only(top:10 ),
                      child: TableCalendar(
                        rowHeight: 33,
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                        calendarStyle: const CalendarStyle(
                          tablePadding: EdgeInsets.all(8),
                        ),
                        availableGestures: AvailableGestures.all,
                        selectedDayPredicate: (day) => isSameDay(day, today),
                        focusedDay: today,
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        onDaySelected: _onDaySelected,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      height: 200,
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NumberPicker(
                            minValue: 0,
                            maxValue: 23,
                            value: hour,
                            zeroPad: true,
                            infiniteLoop: true,
                            itemWidth: 50,
                            itemHeight: 50,
                            onChanged: (value) {
                              setState(() {
                                  hour = value;
                              });
                            },
                            textStyle: const TextStyle(
                                color: Colors.grey, fontSize: 20),
                            selectedTextStyle: const TextStyle(
                                color: Colors.black, fontSize: 30),
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: Colors.black),
                                    bottom: BorderSide(color: Colors.black))),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          NumberPicker(
                            minValue: 0,
                            maxValue: 59,
                            value: min,
                            zeroPad: true,
                            infiniteLoop: true,
                            itemWidth: 50,
                            itemHeight: 50,
                            onChanged: (value) {
                              setState(() {
                                min = value;
                              });
                            },
                            textStyle: const TextStyle(
                                color: Colors.grey, fontSize: 20),
                            selectedTextStyle: const TextStyle(
                                color: Colors.black, fontSize: 30),
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: Colors.black),
                                    bottom: BorderSide(color: Colors.black))),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
