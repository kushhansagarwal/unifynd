//make class called API with methods called getEvents and getServices

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'classes.dart';

class API {
  Future<List<Events>> getEvents() async {
    var url = 'https://unifynd.herokuapp.com/events/getEvents';
    var response = await http.get(Uri.parse(url));
    var events = <Events>[];

    if (response.statusCode == 200) {
      var eventsJson = json.decode(response.body);
      for (var eventJson in eventsJson['data']['events']) {
        //parse date as a unix timestamp
        var date =
            DateTime.fromMillisecondsSinceEpoch(eventJson['date'] * 1000);

        print(eventJson['Location']["_latitude"]);
        print(eventJson['Location']["_longitude"]);
        events.add(
          Events(
            eventJson['id'],
            eventJson['description'],
            eventJson['event_name'],
            eventJson['location'],
            eventJson['organizer_id'],
            date,
            {
              "lat": eventJson['Location']["_latitude"],
              "lon": eventJson['Location']["_longitude"]
            },
          ),
        );
      }
    }
    return events;
  }

  Future<List<Service>> getServices() async {
    var url = 'https://unifynd.herokuapp.com/marketplace/getMarketplace';
    var response = await http.get(Uri.parse(url));
    var services = <Service>[];

    if (response.statusCode == 200) {
      var servicesJson = json.decode(response.body);
      for (var serviceJson in servicesJson['data']['services']) {
        print(serviceJson['reviews']);
        print(serviceJson['reviews'].runtimeType);

        var rawReviews = serviceJson['reviews'];

        List<dynamic> reviews = rawReviews
            .map((rawReviews) => {
                  'date': rawReviews['date'],
                  'review': rawReviews['review'],
                  'rating': rawReviews['rating'],
                  'reviewer_name': rawReviews['reviewer_name'],
                })
            .toList();

        //find average rating
        num totalRating = 0;
        for (var review in reviews) {
          totalRating += review['rating'];
        }
        var averageRating = totalRating / reviews.length;

        services.add(
          Service(
            serviceJson['category'],
            serviceJson['portfolio_link'],
            serviceJson['price'],
            serviceJson['provider_name'],
            //parse reviews as json
            // json.decode(serviceJson['reviews']),
            serviceJson['reviews'],
            serviceJson['service_name'],
            serviceJson['service_description'],
            averageRating,
          ),
        );
      }
    }
    return services;
  }

  Future<List<Clubs>> getClubs() async {
    var url = 'https://unifynd.herokuapp.com/clubs/getClubs';
    var response = await http.get(Uri.parse(url));
    var clubs = <Clubs>[];

    if (response.statusCode == 200) {
      var eventsJson = json.decode(response.body);
      for (var eventJson in eventsJson['data']['clubs']) {
        clubs.add(
          Clubs(
            eventJson['email'],
            eventJson['description'],
            eventJson['website'],
            eventJson['name'],
            eventJson['category'],
            eventJson['signatories'],
            eventJson['advisor'],
            eventJson['id'],
          ),
        );
      }
    }
    return clubs;
  }

  Future<List<Restaurant>> getRestaurants() async {
    var url = 'https://unifynd.herokuapp.com/restaurants/getRestaurants';
    var response = await http.get(Uri.parse(url));
    var restaurants = <Restaurant>[];

    if (response.statusCode == 200) {
      var eventsJson = json.decode(response.body);
      for (var eventJson in eventsJson['data']['restaurants']) {
        restaurants.add(Restaurant(
          eventJson['name'],
          eventJson['activity'],
          eventJson['link'],
          eventJson['description'],
        ));
      }
    }
    return restaurants;
  }
}
