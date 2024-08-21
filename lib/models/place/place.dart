class Place {
  String streetNumber;
  String street;
  String city;
  String zipCode;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion({this.placeId, this.description});

  factory Suggestion.fromMap(Map<String, dynamic> json) =>
      Suggestion(placeId: json["placeId"], description: json["description"]);

  Map<String, dynamic> toMap() => {
        "placeId": placeId,
        "description": description,
      };
}
