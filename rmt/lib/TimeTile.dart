import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class TimeTile extends StatelessWidget {
  final String taskName;
  final String time;

  Function(BuildContext)? deleteFunction;

  TimeTile(
      {super.key,
      required this.taskName,
      required this.time,
      required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left:20, top: 10),
      child: Slidable(
        endActionPane: ActionPane(motion: 
        const StretchMotion(), children: [
          SlidableAction(
          onPressed: deleteFunction, 
          icon: Icons.delete, 
          backgroundColor: Colors.red.shade300,)
        ]),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(time, style:TextStyle(fontSize: 13)),
          ), Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(taskName, style:TextStyle(fontSize: 16)),
          )]),
          alignment: Alignment.centerLeft,  
        ),
      ),
    );
  }
}
