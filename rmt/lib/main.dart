import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rmt/AddButton.dart';
import 'package:rmt/LocalNotification.dart';
import 'package:rmt/pages/CreateLocation.dart';
import 'package:rmt/pages/CreateTime.dart';
import 'pages/CalendarPage.dart';
import 'pages/HomePage.dart';
import 'pages/LocationPage.dart';
import 'pages/SettingsPage.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  //init notification
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init();

  tz.initializeTimeZones();

  // init the hive
  await Hive.initFlutter();

  // ignore: unused_local_variable
  var timeBox = await Hive.openBox("timebox");
  // ignore: unused_local_variable
  var locationBox = await Hive.openBox("locationbox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: const MainScreen(),
      theme: ThemeData(primarySwatch: Colors.amber),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int navIndex = 0;
  int pageIndex = 0;
  final screens = [
    const HomePage(),
    const LocationPage(),
    const CalendarPage(),
    const SettingsPage(),
    const CreateTime(),
    const CreateLocation(),
  ];

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          const Color.fromARGB(255, 104, 189, 223), //104,189,223,1.00)
      body: screens[pageIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        indicatorColor: const Color(0x00000000),
        height: 67, // nav bar height
        backgroundColor: const Color(0xFFFFD400), // nav bar color
        selectedIndex: navIndex,
        onDestinationSelected: (navIndex) => setState(() {
          pageIndex = navIndex;
          this.navIndex = navIndex;
        }),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home, color: Colors.white, size: 27),
              selectedIcon: Icon(Icons.home, color: Colors.grey, size: 27),
              label: "Home"),
          NavigationDestination(
              icon: Icon(Icons.location_on, color: Colors.white, size: 27),
              selectedIcon: Icon(Icons.location_on, color: Colors.grey, size: 27),
              label: "Location"),
          NavigationDestination(
              icon: Icon(Icons.calendar_month, color: Colors.white, size: 27),
              selectedIcon: Icon(Icons.calendar_month, color: Colors.grey, size: 27),
              label: "Calendar"),
          NavigationDestination(
              icon: Icon(Icons.settings, color: Colors.white, size: 27),
              selectedIcon: Icon(Icons.settings, color: Colors.grey, size: 27),
              label: "Setting"),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: keyboardIsOpened
          ? null
          : AddButton(
              onPressedTime: () {
                setState(() {
                  Navigator.of(context).pop();
                  pageIndex = 4;
                  navIndex = 2;
                });
              },
              onPressedLocation: () {
                setState(() {
                  Navigator.of(context).pop();
                  pageIndex = 5;
                  navIndex = 1;
                });
              },
            ),
    );
  }
}
