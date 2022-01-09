import 'dart:async';

import 'package:app/constants/colors.dart';
import 'package:app/ui/pages/route_selector/route_selector_page.dart';
import 'package:app/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  final destinationAddressController = TextEditingController();
  final desrinationAddressFocusNode = FocusNode();

//40.1875658,44.5149051
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.1875658, 44.5149051),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        InkWell(
          onTap: () {
            showRouteSelectorPage();
          },
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: _searchField(
                  prefixIcon: const Icon(Icons.search), label: "Search route"),
            ),
          ),
        )
      ]),
      /*     body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),*/
      /*   floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),*/
    );
  }

  Widget  _searchField({
    required String label,
    required Icon prefixIcon,
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
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const RouteSelectorPage()));

    /// Navigator.of(context).push(Routes.routeSelectorPage);
  }

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required Icon prefixIcon,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return SizedBox(
      height: 36,
      child: TextField(
        onChanged: null,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white.withOpacity(0.75),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.75),
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
