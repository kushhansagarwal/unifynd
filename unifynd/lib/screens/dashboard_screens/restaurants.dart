import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unifynd/classes.dart';
import 'package:unifynd/constants.dart';
import '../../api.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  List<Restaurant> restaurantList = [];
  List<int> orders = [];

  Future<List<Restaurant>> getRestaurants() async {
    var restaurants = await API().getRestaurants();
    return restaurants;
  }

  @override
  void initState() {
    var currentTime = DateTime.now();
    var time2MinutesAgo = currentTime.subtract(Duration(minutes: 2));

//print all collections in the database if they are created within the last 2 minutes
    FirebaseFirestore.instance.collection('order_number').get().then((value) {
      for (var doc in value.docs) {
        try {
          var data = doc.data();
          var time = data['timestamp'].toDate();

          if (time.isAfter(time2MinutesAgo)) {
            orders.add(int.parse(doc.id));
          }
        } catch (e) {}
      }
    });

    // TODO: implement initState
    getRestaurants().then((value) {
      setState(() {
        restaurantList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Find food options", style: kCardTitle),
          SizedBox(
            height: 20,
          ),
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: kAccentOneColor.withAlpha(20),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              //populate child with chips with random numbers
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (var order in orders)
                    Chip(
                      label: Text(order.toString()),
                    )
                ],
              ),
            ),
          ),
          for (var event in restaurantList)
            RestaurantCard(size: size, restaurant: event),
        ],
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    Key? key,
    required this.size,
    required this.restaurant,
  }) : super(key: key);

  final Size size;
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var url = restaurant.link;
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
                    Text(
                      restaurant.name,
                      style: kCardTitle,
                    ),
                    Text(
                      "${restaurant.activity.toString()}%",
                      style: kCardTitle.copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 15,
                        color: () {
                          //make a switch case
                          if (restaurant.activity > 60) {
                            return Colors.red;
                          } else if (restaurant.activity > 40) {
                            return Colors.orange;
                          } else if (restaurant.activity > 30) {
                            return Colors.green;
                          } else if (restaurant.activity > 10) {
                            return Colors.green;
                          } else {
                            return Colors.red;
                          }
                        }(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(restaurant.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: kCardTitle.copyWith(
                      fontWeight: FontWeight.w100,
                      fontSize: 15,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
