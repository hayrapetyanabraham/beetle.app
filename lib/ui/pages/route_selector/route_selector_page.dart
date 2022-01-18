import 'package:app/constants/colors.dart';
import 'package:app/stores/place/place_store.dart';
import 'package:app/ui/pages/map/map_location_selector_page.dart';
import 'package:app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:provider/provider.dart';

class RouteSelectorPage extends StatefulWidget {
  const RouteSelectorPage({Key key}) : super(key: key);

  @override
  _RouteSelectorPageState createState() => _RouteSelectorPageState();
}

class _RouteSelectorPageState extends State<RouteSelectorPage> {
  final startAddressController = TextEditingController();
  final endAddressController = TextEditingController();
  PlaceStore _placeStore;
  final startAddressFocusNode = FocusNode();
  final endAddressFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _placeStore = Provider.of<PlaceStore>(context);
    if (_placeStore.geocodingResultStart != null) {
      startAddressController.text =
          _placeStore.geocodingResultStart.formattedAddress.toString();
    }
    if (_placeStore.geocodingResultEnd != null) {
      endAddressController.text =
          _placeStore.geocodingResultEnd.formattedAddress.toString();
    }
  }

  Future<void> getSuggestionStart() async {
    _placeStore.input = startAddressController.text.toString();
    _placeStore.lang = 'en';
    await _placeStore.getSuggestionStart();
  }

  Future<void> getSuggestionEnd() async {
    _placeStore.input = endAddressController.text.toString();
    _placeStore.lang = 'en';
    await _placeStore.getSuggestionEnd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildConfirmButton(),
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
    return Observer(builder: (context) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: _searchField(
                label: 'Start',
                hint: 'Choose starting address',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.map_outlined),
                  onPressed: () {
                    showMapLocationSelectorPage();
                  },
                ),
                controller: startAddressController,
                focusNode: startAddressFocusNode,
                locationCallback: (String value) {
                  getSuggestionStart();
                }),
          ),
          if (_placeStore.geocodingResultsStart != null) ...[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: _listAddresses(
                    geocodingResults: _placeStore.geocodingResultsStart,
                    onSelectedItem: (geocodingResult) {
                      _placeStore.geocodingResultStart = geocodingResult;
                      startAddressController.text =
                          '${geocodingResult.formattedAddress}';
                      _placeStore.resetStart();
                    }),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: _searchField(
                label: 'End',
                hint: 'Choose end address',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.map_outlined),
                  onPressed: () {
                    showMapLocationSelectorPage();
                  },
                ),
                controller: endAddressController,
                focusNode: endAddressFocusNode,
                locationCallback: (String value) {
                  getSuggestionEnd();
                }),
          ),
          if (_placeStore.geocodingResultsEnd != null) ...[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: _listAddresses(
                    geocodingResults: _placeStore.geocodingResultsEnd,
                    onSelectedItem: (geocodingResult) {
                      _placeStore.geocodingResultEnd = geocodingResult;
                      endAddressController.text =
                          '${geocodingResult.formattedAddress}';
                      _placeStore.resetEnd();
                    }),
              ),
            ),
          ],
        ],
      );
    });
  }

  ListTile _itemPlace(
      {String title, String subtitle, IconData icon, Function onTap}) {
    return ListTile(
      onTap: () {
        onTap();
      },
      title: Text(title ?? '',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.tuna.withOpacity(0.6),
          )),
      subtitle: Text(
        subtitle ?? '',
        style: TextStyle(
          fontSize: 11,
          color: AppColors.tuna.withOpacity(0.6),
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _listAddresses(
      {List<GeocodingResult> geocodingResults, Function onSelectedItem}) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: geocodingResults.length,
        itemBuilder: (BuildContext context, int index) {
          GeocodingResult geocodingResult = geocodingResults[index];
          return _itemPlace(
              icon: Icons.add_location,
              title: geocodingResult.formattedAddress,
              subtitle:
                  'lat: ${geocodingResult.geometry.location.lat}  lng: ${geocodingResult.geometry.location.lng}',
              onTap: () {
                onSelectedItem(geocodingResult);
              });
        },
      ),
    );
  }

  Future<void> showMapLocationSelectorPage() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const MapLocationSelectorPage()));
  }

  Widget _searchField({
     String label,
     Icon prefixIcon,
     TextEditingController controller,
     FocusNode focusNode,
     String hint,
    Widget suffixIcon,
     Function(String) locationCallback,
  }) {
    return Card(
      elevation: 5,
      color: Colors.white.withOpacity(0.75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
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
    );
  }

  Widget _buildConfirmButton() {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: RoundedButtonWidget(
          buttonText: 'Confirm',
          buttonColor: AppColors.pizazz,
          disabledColor: AppColors.chardonnay,
          textColor: Colors.white,
          isDisabled: false,
          onPressed: () async {
            Navigator.of(context).pop(_placeStore);
          },
        ));
  }
}
