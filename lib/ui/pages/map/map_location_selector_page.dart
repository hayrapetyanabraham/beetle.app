import 'dart:async';

import 'package:app/constants/colors.dart';
import 'package:app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocationSelectorPage extends StatefulWidget {
  const MapLocationSelectorPage({Key? key}) : super(key: key);

  @override
  _MapLocationSelectorPageState createState() =>
      _MapLocationSelectorPageState();
}

class _MapLocationSelectorPageState extends State<MapLocationSelectorPage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.1875658, 44.5149051),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 6.0,
        automaticallyImplyLeading: true,
        shadowColor: Colors.black.withOpacity(0.16),
        title: const Text(
          'Select route',
          style: TextStyle(fontSize: 20.0),
        ));
  }

  Widget _buildBody() {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.location_on,
              color: Colors.red[300],
              size: 48,
            )),
        Align(alignment: Alignment.bottomCenter, child: _buildConfirmButton()),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: RoundedButtonWidget(
          buttonText: 'Confirm',
          buttonColor: AppColors.pizazz,
          disabledColor: AppColors.chardonnay,
          textColor: Colors.white,
          isDisabled: false,
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ));
  }
}
