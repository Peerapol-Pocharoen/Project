import 'package:hive/hive.dart';

// [task_name, location_name, latitude, longitude]
class LocationDataBase {
  List locationList = [];

  final _locationBox = Hive.box("locationbox");

  void createInitialData() {
    _locationBox.put("LOCATIONLIST", locationList);
  }

  void loadData() {
    locationList = _locationBox.get("LOCATIONLIST");
  }

  void updateData() {
    _locationBox.put("LOCATIONLIST", locationList);
  }
}
