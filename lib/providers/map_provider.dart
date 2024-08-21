/*
import 'package:app/constants/secrets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;

class MapProvider {
  /// Get user's current location.
  Future<location.LocationData> getCurrentLocation() async {
    final location.LocationData locationData = location.LocationData.fromMap({
      'latitude': 8.592128,
      'longitude': 76.8547989,
    });
    return locationData;
  }

  /// Get route path between two points.
  /// Polylines data is included in the response.
  /// Decoder is available in the helper function.
  Future<DirectionsResponse> getDirection(
      {required LatLng start, required LatLng end}) async {
    final GoogleMapsDirections _directions =
        GoogleMapsDirections(apiKey: Secrets.API_KEY);
    final DirectionsResponse directionsResponse =
        await _directions.directionsWithLocation(
      Location(start.latitude, start.longitude),
      Location(end.latitude, end.longitude),
      trafficModel: TrafficModel.bestGuess,
      travelMode: TravelMode.driving,
      departureTime: DateTime.now(),
    );
    return directionsResponse;
  }
}
*/
