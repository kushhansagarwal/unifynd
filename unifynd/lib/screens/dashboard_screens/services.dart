import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:unifynd/classes.dart';
import 'package:unifynd/constants.dart';

import '../../api.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  List<Service> eventList = [];

  Future<List<Service>> getServices() async {
    var events = await API().getServices();
    return events;
  }

  @override
  void initState() {
    // TODO: implement initState
    getServices().then((value) {
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
          Text("Explore services by students", style: kCardTitle),
          SizedBox(
            height: 20,
          ),
          for (var event in eventList) ServiceCard(size: size, service: event),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    Key? key,
    required this.size,
    required this.service,
  }) : super(key: key);

  final Size size;
  final Service service;

  double convertToNearestHalf(num value) {
    double convertedValue = (value * 2).round() / 2;
    return convertedValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return ServiceModalSheet(service: service);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.service_name,
                          style: kCardTitle,
                        ),
                        Text(
                          "by ${service.provider_name}",
                          style: kCardByTitle,
                        ),
                      ],
                    ),
                    RatingBar.builder(
                      itemSize: 20.0,
                      ignoreGestures: true,
                      initialRating: convertToNearestHalf(service.rating),
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  service.service_descripton,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kCardSubtile,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Connect"),
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

class ServiceModalSheet extends StatelessWidget {
  const ServiceModalSheet({
    Key? key,
    required this.service,
  }) : super(key: key);

  final Service service;

  double convertToNearestHalf(num value) {
    double convertedValue = (value * 2).round() / 2;
    return convertedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service.service_name,
              style: kCardTitle,
            ),
            Text("in ${service.category} by ${service.provider_name}"),
            SizedBox(
              height: 20,
            ),
            Text(service.service_descripton),
            SizedBox(
              height: 20,
            ),
            Text(
              "Reviews",
              style: kCardByTitle,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                for (var review in service.reviews)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              review["reviewer_name"],
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            RatingBar.builder(
                              itemSize: 20.0,
                              ignoreGestures: true,
                              initialRating:
                                  convertToNearestHalf(review["rating"]),
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (double value) {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(review["review"]),
                      ]),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
