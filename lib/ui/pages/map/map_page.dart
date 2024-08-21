import 'dart:async';
import 'package:app/constants/colors.dart';
import 'package:app/constants/secrets.dart';
import 'package:app/helpers/map_helper.dart';
import 'package:app/stores/place/place_store.dart';
import 'package:app/ui/pages/route_selector/route_selector_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  Map<MarkerId, Marker> markers = {};
  GoogleMapController mapController;

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.1875658, 44.5149051),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          markers: Set<Marker>.of(markers.values),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            mapController = controller;
          },
          polylines: Set<Polyline>.of(polylines.values),
          // polylines: Set.from(polyline),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: InkWell(
              onTap: () {
                showRouteSelectorPage();
              },
              child: _searchField(
                  prefixIcon: const Icon(Icons.search), label: "Search route"),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _searchField({
     String label,
     Icon prefixIcon,
  }) {
    return Card(
      elevation: 5,
      color: Colors.white.withOpacity(0.75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        height: 36.0,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 16,
              ),
              Icon(
                Icons.search,
                color: AppColors.tuna.withOpacity(0.4),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Search route",
                style: TextStyle(
                  color: AppColors.tuna.withOpacity(0.4),
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showRouteSelectorPage() async {
    PlaceStore _placeStore = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const RouteSelectorPage()));

    _getPolyline(
        locationStart: _placeStore.geocodingResultStart.geometry.location,
        locationEnd: _placeStore.geocodingResultEnd.geometry.location);
  }

  void _getPolyline({Location locationStart, Location locationEnd}) async {
    List<LatLng> polylineCoordinates = [];
    if (locationStart.lat != null &&
        locationStart.lng != null &&
        locationEnd.lat != null &&
        locationEnd.lng != null) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Secrets.API_KEY,
        PointLatLng(locationStart.lat, locationStart.lng),
        PointLatLng(locationEnd.lat, locationEnd.lng),
        travelMode: TravelMode.driving,
      );
      print('AAAASSSS    ${result.points} ${result.points.length}');
      print('AAAASSSS    ${result.points.length}');
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      } else {
        print(result.errorMessage);
      }

      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(locationStart.lat, locationStart.lng),
              zoom: 14.0),
        ),
      );
      _addMarker(
        LatLng(locationStart.lat, locationStart.lng),
        "origin",
        BitmapDescriptor.defaultMarker,
      );
      _addMarker(
        LatLng(locationEnd.lat, locationEnd.lng),
        "destination",
        BitmapDescriptor.defaultMarkerWithHue(90),
      );
      _addPolyLine(polylineCoordinates);
    }
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      consumeTapEvents: true,
      points: polylineCoordinates,
      color: AppColors.pizazz,
      width: 4,
    );

    setState(() {
      polylines[id] = polyline;
    });
  }
}
