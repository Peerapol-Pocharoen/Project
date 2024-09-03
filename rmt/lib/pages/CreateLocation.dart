import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:rmt/data/LocationDataBase.dart';
import 'package:rmt/pages/CreateTime.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class CreateLocation extends StatefulWidget {
  const CreateLocation({super.key});

  @override
  State<CreateLocation> createState() => _CreateLocationState();
}

class _CreateLocationState extends State<CreateLocation> {
  LocationDataBase locationdb = LocationDataBase();

  final _gController = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(41.311158, 69.279737),
    zoom: 14.4746,
  );
  final Location _locationController = Location();

  TextEditingController textController = TextEditingController();
  TextEditingController textMapController = TextEditingController();

  bool thisPage = true;
  bool newValue = true;
  bool isSwitched = true;
  final _controller = ValueNotifier<bool>(false);

  void saveLocationTask() {
    setState(() {
      locationdb.locationList.add([
        textController.text,
        textMapController.text,
        locationdb.locationList.length * 2 + 2,
        cameraPosition.target.latitude,
        cameraPosition.target.longitude
      ]);
      locationdb.updateData();
      textController.clear();
    });
  }

  @override
  void initState() {
    locationdb.loadData();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!thisPage)
        ? const CreateTime()
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
                                  decoration: const InputDecoration(
                                      hintText: "Insert title here",
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(),
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
                                   color: const Color(0xFF956DEB)),
                              child: TextButton(
                                onPressed: saveLocationTask,
                                child: const Text("Submit",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white))),
                            ),
                          )],
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom:20),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(10.0),
                              filled: true,
                              fillColor: Color.fromARGB(255, 255, 255, 255)),
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          controller: textMapController,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 400,
                      child: MapPicker(
                        //add map picker controller
                        mapPickerController: mapPickerController,
                        
                        child: GoogleMap(
                          myLocationEnabled: true,
                          zoomControlsEnabled: false,
                          // hide location button
                          myLocationButtonEnabled: false,
                          mapType: MapType.normal,
                          //  camera position
                          initialCameraPosition: cameraPosition,
                          onMapCreated: (GoogleMapController controller) {
                            _gController.complete(controller);
                          },
                          onCameraMoveStarted: () {
                            // notify map is moving
                            mapPickerController.mapMoving!();
                            textMapController.text = "checking ...";
                          },
                          onCameraMove: (cameraPosition) {
                            this.cameraPosition = cameraPosition;
                          },
                          onCameraIdle: () async {
                            // notify map stopped moving
                            mapPickerController.mapFinishedMoving!();
                            //get address name from camera position
                            List<geo.Placemark> placemarks =
                                await geo.placemarkFromCoordinates(
                              cameraPosition.target.latitude,
                              cameraPosition.target.longitude,
                            );

                            // update the ui with the address
                            textMapController.text =
                                '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData currentP;

    serviceEnabled = await _locationController.serviceEnabled();

    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentP = await _locationController.getLocation();
    cameraPosition = CameraPosition(
      target: LatLng(currentP.latitude!, currentP.longitude!),
      zoom: 14,
    );

    if (currentP.latitude != null && currentP.longitude != null) {
      setState(() {
        cameraPosition = CameraPosition(
          target: LatLng(currentP.latitude!, currentP.longitude!),
          zoom: 14,
        );
        _cameraToPosition(cameraPosition);
      });
    }
  }

  Future<void> _cameraToPosition(CameraPosition pos) async {
    final GoogleMapController controller = await _gController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(pos));
  }
}
