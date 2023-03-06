import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:unifynd/classes.dart';
import 'package:unifynd/constants.dart';

import '../../api.dart';

class ClubsScreen extends StatefulWidget {
  const ClubsScreen({Key? key}) : super(key: key);

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  List<Clubs> clubList = [];

  Future<List<Clubs>> getClubs() async {
    var clubs = await API().getClubs();
    return clubs;
  }

  @override
  void initState() {
    // TODO: implement initState
    getClubs().then((value) {
      setState(() {
        clubList = value;
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
          Text("Find your place", style: kCardTitle),
          SizedBox(
            height: 20,
          ),
          for (var event in clubList) EventCard(size: size, club: event),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
    required this.size,
    required this.club,
  }) : super(key: key);

  final Size size;
  final Clubs club;

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
                        club.name,
                        style: kCardTitle,
                      ),
                      Text(club.category),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(Icons.email),
                          SizedBox(
                            width: 5,
                          ),
                          Text(club.email),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(club.description),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Signatories", style: kCardSubtile),
                      for (var signatory in club.signatories) Text(signatory),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Advisor", style: kCardSubtile),
                      Text(club.advisor),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Join Now!"),
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
                  club.name,
                  style: kCardTitle,
                ),
                Text(
                  club.category,
                  style: kCardByTitle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  club.description,
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
