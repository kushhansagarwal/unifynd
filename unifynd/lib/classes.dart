//make class called Events with date, description, event_name, location, organizer_id and time

class Events {
  String description;
  String event_name;
  String location;
  String organizer_id;
  String id;
  DateTime date;
  Map<String, double> geolocation;
  // LocationData

  Events(
    this.id,
    this.description,
    this.event_name,
    this.location,
    this.organizer_id,
    this.date,
    this.geolocation,
  );
}

//make class called service with category, portfolio_link, price, provider name, reviews and service_name

class Service {
  String category;
  String portfolio_link;
  num price;
  String provider_name;
  List<dynamic> reviews;
  num rating;
  String service_name;
  String service_descripton;

  Service(this.category, this.portfolio_link, this.price, this.provider_name,
      this.reviews, this.service_name, this.service_descripton, this.rating);
}

class Clubs {
  String email;
  String description;
  String website;
  String name;
  String category;
  List<dynamic> signatories;
  String advisor;
  String id;

  Clubs(this.email, this.description, this.website, this.name, this.category,
      this.signatories, this.advisor, this.id);
}

class Restaurant {
  String name;
  int activity;
  String link;
  String description;

  Restaurant(this.name, this.activity, this.link, this.description);
}
