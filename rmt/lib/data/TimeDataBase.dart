import 'package:hive/hive.dart';

// [task_name, date-time(string), datetime, hour, min]
class TimeDataBase {
  List timeList = [];

  final _timeBox = Hive.box("timebox");

  void createInitialData() {
    _timeBox.put("TIMELIST", timeList);
  }

  void loadData() {
    timeList = _timeBox.get("TIMELIST");
  }

  void updateData() {
    _timeBox.put("TIMELIST", timeList);
  }

}