import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/library.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _instruction = "";
  // final _origin = WayPoint(
  //   name: "Way Point 1",
  //   latitude: 127.026957,
  //   longitude: 37.497932,
  // );
  // final _stop1 = WayPoint(
  //   name: "Way Point 2",
  //   latitude: 37.549501,
  //   longitude: 127.051207,
  // );
  final _origin = WayPoint(name: "Way Point 3", latitude: 38.91040213277608, longitude: -77.03848242759705);
  final _stop1 = WayPoint(name: "Way Point 4", latitude: 38.909650771013034, longitude: -77.03850388526917);
  final _stop2 = WayPoint(name: "Way Point 1", latitude: 38.91040213277608, longitude: -77.03848242759705);
  final _stop3 = WayPoint(name: "Way Point 2", latitude: 38.909650771013034, longitude: -77.03850388526917);
  final _stop4 = WayPoint(name: "Way Point 5", latitude: 38.90894949285854, longitude: -77.03651905059814);

  late MapBoxNavigation _directions;
  late MapBoxOptions _options;

  final bool _isMultipleStop = false;
  double? _distanceRemaining, _durationRemaining;
  late MapBoxNavigationViewController _controller;
  bool _routeBuilt = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    _options = MapBoxOptions(
        //initialLatitude: 36.1175275,
        //initialLongitude: -115.1839524,
        zoom: 15.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: false,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        units: VoiceUnits.imperial,
        simulateRoute: false,
        animateBuildRoute: true,
        longPressDestinationEnabled: true,
        language: "en");

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await _directions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Running on: $_platformVersion\n'),
                    Container(
                      color: Colors.grey,
                      width: double.infinity,
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: (Text(
                          "Full Screen Navigation",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: const Text("Start A to B"),
                          onPressed: () async {
                            var wayPoints = <WayPoint>[];
                            // wayPoints.add(_origin);
                            // wayPoints.add(_stop1);

                            var v1 = WayPoint(
                              name: "Way Point 10",
                              latitude: 37.549501,
                              longitude: 127.051207,
                            );
                            var v2 = WayPoint(
                              name: "Way Point 20",
                              latitude: 37.559510,
                              longitude: 128.051210,
                            );
                            wayPoints.add(v1);
                            wayPoints.add(v2);

                            await _directions.startNavigation(
                                wayPoints: wayPoints,
                                options: MapBoxOptions(
                                  mode: MapBoxNavigationMode.walking,
                                  // simulateRoute: false,
                                  language: "en",
                                ));
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // ElevatedButton(
                        //   child: const Text("Start Multi Stop"),
                        //   onPressed: () async {
                        //     _isMultipleStop = true;
                        //     var wayPoints = <WayPoint>[];
                        //     wayPoints.add(_origin);
                        //     wayPoints.add(_stop1);
                        //     wayPoints.add(_stop2);
                        //     wayPoints.add(_stop3);
                        //     wayPoints.add(_stop4);
                        //     wayPoints.add(_origin);

                        //     await _directions.startNavigation(
                        //         wayPoints: wayPoints,
                        //         options: MapBoxOptions(
                        //             mode: MapBoxNavigationMode.driving,
                        //             simulateRoute: true,
                        //             language: "en",
                        //             allowsUTurnAtWayPoints: true,
                        //             units: VoiceUnits.metric));
                        //   },
                        // )
                      ],
                    ),
                    // Container(
                    //   color: Colors.grey,
                    //   width: double.infinity,
                    //   child: const Padding(
                    //     padding: EdgeInsets.all(10),
                    //     child: (Text(
                    //       "Embedded Navigation",
                    //       style: TextStyle(color: Colors.white),
                    //       textAlign: TextAlign.center,
                    //     )),
                    //   ),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ElevatedButton(
                    //       onPressed: _isNavigating
                    //           ? null
                    //           : () {
                    //               if (_routeBuilt) {
                    //                 _controller.clearRoute();
                    //               } else {
                    //                 var wayPoints = <WayPoint>[];
                    //                 // wayPoints.add(_origin);
                    //                 // wayPoints.add(_stop1);
                    //                 // wayPoints.add(_stop2);
                    //                 // wayPoints.add(_stop3);
                    //                 // wayPoints.add(_stop4);
                    //                 // wayPoints.add(_origin);

                    //                 var v1 = WayPoint(
                    //                   name: "Way Point 10",
                    //                   latitude: 37.549501,
                    //                   longitude: 127.051207,
                    //                 );
                    //                 var v2 = WayPoint(
                    //                   name: "Way Point 20",
                    //                   latitude: 37.549510,
                    //                   longitude: 127.051210,
                    //                 );
                    //                 wayPoints.add(v1);
                    //                 wayPoints.add(v2);
                    //                 _isMultipleStop = wayPoints.length > 2;
                    //                 _controller.buildRoute(wayPoints: wayPoints);
                    //               }
                    //             },
                    //       child: Text(_routeBuilt && !_isNavigating ? "Clear Route" : "Build Route"),
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: _routeBuilt && !_isNavigating
                    //           ? () {
                    //               _controller.startNavigation();
                    //             }
                    //           : null,
                    //       child: const Text("Start "),
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: _isNavigating
                    //           ? () {
                    //               _controller.finishNavigation();
                    //             }
                    //           : null,
                    //       child: const Text("Cancel "),
                    //     )
                    //   ],
                    // ),
                    // const Center(
                    //   child: Padding(
                    //     padding: EdgeInsets.all(10),
                    //     child: Text(
                    //       "Long-Press Embedded Map to Set Destination",
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   color: Colors.grey,
                    //   width: double.infinity,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(10),
                    //     child: (Text(
                    //       _instruction.isEmpty ? "Banner Instruction Here" : _instruction,
                    //       style: const TextStyle(color: Colors.white),
                    //       textAlign: TextAlign.center,
                    //     )),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 10),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       Row(
                    //         children: <Widget>[
                    //           const Text("Duration Remaining: "),
                    //           Text(_durationRemaining != null
                    //               ? "${(_durationRemaining! / 60).toStringAsFixed(0)} minutes"
                    //               : "---")
                    //         ],
                    //       ),
                    //       Row(
                    //         children: <Widget>[
                    //           const Text("Distance Remaining: "),
                    //           Text(_distanceRemaining != null
                    //               ? "${(_distanceRemaining! * 0.000621371).toStringAsFixed(1)} miles"
                    //               : "---")
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const Divider()
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.grey,
                child: MapBoxNavigationView(
                    options: _options,
                    onRouteEvent: _onEmbeddedRouteEvent,
                    onCreated: (MapBoxNavigationViewController controller) async {
                      _controller = controller;
                      controller.initialize();
                    }),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future<void> _onEmbeddedRouteEvent(e) async {
    if (_distanceRemaining != null) _distanceRemaining = await _directions.distanceRemaining;
    if (_durationRemaining != null) _durationRemaining = await _directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        if (progressEvent.currentStepInstruction != null) _instruction = progressEvent.currentStepInstruction!;
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          _routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          _routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          _isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        if (!_isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          _routeBuilt = false;
          _isNavigating = false;
        });
        break;
      default:
        break;
    }
    setState(() {});
  }
}
