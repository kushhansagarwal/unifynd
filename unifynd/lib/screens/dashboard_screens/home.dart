import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:unifynd/classes.dart';
import 'package:unifynd/constants.dart';

import '../../api.dart';

Map<String, double> currentLocation = {
  "lat": 34.072572871874215,
  "lon": -118.45361434947856
};

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Events> eventList = [];

  Future<List<Events>> getEvents() async {
    var events = await API().getEvents();
    return events;
  }

  @override
  void initState() {
    // TODO: implement initState
    getEvents().then((value) {
      setState(() {
        eventList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Find events near you", style: kCardTitle),
          SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Container(
              width: size.width,
              height: size.height * 0.3,
              child: GoogleMap(
                markers: {
                  Marker(
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueAzure),
                      markerId: MarkerId('1'),
                      position: LatLng(
                          currentLocation["lat"]!, currentLocation["lon"]!),
                      infoWindow: InfoWindow(title: "You")),
                  for (var event in eventList)
                    Marker(
                        markerId: MarkerId(event.event_name),
                        position: LatLng(event.geolocation["lat"]!,
                            event.geolocation["lon"]!),
                        infoWindow: InfoWindow(title: event.event_name))
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(34.072572871874215, -118.45361434947856),
                    zoom: 14),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          for (var event in eventList) EventCard(size: size, event: event),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
    required this.size,
    required this.event,
  }) : super(key: key);

  final Size size;
  final Events event;

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.event_name,
                        style: kCardTitle,
                      ),
                      Text("by ${event.organizer_id}"),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_pin),
                          SizedBox(
                            width: 5,
                          ),
                          Text(event.location),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.watch),
                          SizedBox(
                            width: 5,
                          ),
                          Text(DateFormat.yMMMd().format(event.date))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(event.description),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("RSVP Now!"),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: kAccentOneColor.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.event_name,
                  style: kCardTitle,
                ),
                Text(
                    "${calculateDistance(currentLocation['lat']!, currentLocation['lon']!, event.geolocation["lat"], event.geolocation["lon"]).toStringAsFixed(2)} miles away"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  event.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kCardSubtile,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Register"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          kPrimaryColor.withAlpha(40)),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
