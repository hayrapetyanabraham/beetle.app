import 'package:app/constants/colors.dart';
import 'package:app/stores/place/place_store.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class RouteSelectorPage extends StatefulWidget {
  const RouteSelectorPage({Key? key}) : super(key: key);

  @override
  _RouteSelectorPageState createState() => _RouteSelectorPageState();
}

class _RouteSelectorPageState extends State<RouteSelectorPage> {
  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();
  late Position _currentPosition;
  String _currentAddress = '';
  String _startAddress = '';
  String _destinationAddress = '';

  late PlaceStore _placeStore;

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _placeStore = Provider.of<PlaceStore>(context);
  }

  Future<void> getSuggestion() async {
    _placeStore.input = startAddressController.text.toString();
    _placeStore.lang = 'en';
    await _placeStore.getSuggestion();
  }

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
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          child: _searchField(
              label: 'Start',
              hint: 'Choose starting address',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.my_location),
                onPressed: () {
                  startAddressController.text = _currentAddress;
                  _startAddress = _currentAddress;
                },
              ),
              controller: startAddressController,
              focusNode: startAddressFocusNode,
              locationCallback: (String value) {
                setState(() {
                  _startAddress = value;
                  getSuggestion();
                });
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          child: _searchField(
              label: 'End',
              hint: 'Choose end address',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.my_location),
                onPressed: () {
                  startAddressController.text = _currentAddress;
                  _startAddress = _currentAddress;
                },
              ),
              controller: destinationAddressController,
              focusNode: desrinationAddressFocusNode,
              locationCallback: (String value) {
                setState(() {
                  _destinationAddress = value;
                });
              }),
        ),
      ],
    );
  }

  Widget _searchField({
    required String label,
    required Icon prefixIcon,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return Card(
      elevation: 5,
      color: Colors.white.withOpacity(0.75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        height: 36.0,
        child: TextField(
          onChanged: (value) {
            locationCallback(value);
          },
          controller: controller,
          focusNode: focusNode,
          autocorrect: false,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelText: label,
            filled: true,
            fillColor: Colors.white,
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
                color: Colors.white.withOpacity(0.75),
                width: 0,
              ),
            ),
            contentPadding: EdgeInsets.all(15),
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
