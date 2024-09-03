import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 104, 189, 223),
      //   title: const Text(""),
      // ),
      body: Container(
        foregroundDecoration: null,
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
          ),
        ),
        padding: const EdgeInsets.only(top: 70),
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(color: Colors.yellow[700]),
                height: 180,
                alignment: Alignment.topCenter,
                child: const Text(
                  "Setting",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 2),
                )),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:20),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 252, 252, 252),
                      borderRadius: BorderRadius.circular(10)),
                  height: 530,
                  width: 348,
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:17.5),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 140,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/dis.png",
                                    height: 50,
                                    width: 50,
                                  ),SizedBox(width: 12),
                                  const Text("Distance preference")
                                ],
                              ),
                              SizedBox(height: 6,),
                              const DistanceMenu(),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height:35 ,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/reg.png",
                                  height: 50,
                                  width: 50,
                                ),
                                const Text("Language & Region"),
                              ],
                            ),
                            const RegionMenu(),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 35,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 140,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/ring.png",
                                  height: 50,
                                  width: 50,
                                ),SizedBox(width: 17,),
                                const Text("Notification Sound")
                              ],
                            ),
                            SizedBox(height: 6,),
                            const RingtoneMenu(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//
// Distance
//

class DistanceMenu extends StatefulWidget {
  const DistanceMenu({super.key});

  @override
  State<DistanceMenu> createState() => _DistanceMenuState();
}

class _DistanceMenuState extends State<DistanceMenu> {
  List<String> items = ['50m', "100m", "200m"];
  String? selectedItem = '50m';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      height: 60,
      child: Center(
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 1, color: Colors.grey),
          )),
          hint: const Text(
            "Select Distance",
            style: TextStyle(fontSize: 11),
          ),
          value: selectedItem,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 12,color: Colors.black),
                    ),
                  ))
              .toList(),
          style: const TextStyle(fontSize: 12),
          onChanged: (item) => setState(() {
            selectedItem = item;
          }),
        ),
      ),
    );
  }
}

///
/// Region
///

class RegionMenu extends StatefulWidget {
  const RegionMenu({super.key});

  @override
  State<RegionMenu> createState() => _RegionMenuState();
}

class _RegionMenuState extends State<RegionMenu> {
  List<String> items = ['English'];
  String? selectedItem = 'English';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      height: 60,
      child: Center(
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 1, color: Colors.grey),
          )),
          hint: const Text(
            "Select Distance",
            style: TextStyle(fontSize: 11),
          ),
          value: selectedItem,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 12,color: Colors.black),
                    ),
                  ))
              .toList(),
          style: const TextStyle(fontSize: 12),
          onChanged: (item) => setState(() {
            selectedItem = item;
          }),
        ),
      ),
    );
  }
}

///
/// Ringtone
///

class RingtoneMenu extends StatefulWidget {
  const RingtoneMenu({super.key});

  @override
  State<RingtoneMenu> createState() => _RingtoneMenuState();
}

class _RingtoneMenuState extends State<RingtoneMenu> {
  List<String> items = ['Default'];
  String? selectedItem = 'Default';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      height: 60,
      child: Center(
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 1, color: Colors.grey),
          )),
          hint: const Text(
            "Select Distance",
            style: TextStyle(fontSize: 11),
          ),
          value: selectedItem,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ))
              .toList(),
          style: const TextStyle(fontSize: 12),
          onChanged: (item) => setState(() {
            selectedItem = item;
          }),
        ),
      ),
    );
  }
}
