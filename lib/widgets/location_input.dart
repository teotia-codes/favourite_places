import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
class LocationInput extends StatefulWidget {
  const LocationInput({super.key});
  @override
  State<StatefulWidget> createState() {
return _LocationInput();
  }
}
class _LocationInput extends State<LocationInput> {
 Location? _pickedLocation;
 var _isGettingLocation = false;
 void _getCurrentLocation() async {
Location location =  Location();

bool serviceEnabled;
PermissionStatus permissionGranted;
LocationData locationData;

serviceEnabled = await location.serviceEnabled();
if (!serviceEnabled) {
  serviceEnabled = await location.requestService();
  if (!serviceEnabled) {
    return;
  }
}
        
permissionGranted = await location.hasPermission();
if (permissionGranted == PermissionStatus.denied) {
  permissionGranted = await location.requestPermission();
  if (permissionGranted != PermissionStatus.granted) {
    return;
  }
}
setState(() {
  _isGettingLocation = true;
});
locationData = await location.getLocation();
setState(() {
  _isGettingLocation = false;
});
}
 @override
  Widget build(BuildContext context) {
    Widget previewContent = Text('No lacation chosen',textAlign:TextAlign.center );
    if(_isGettingLocation){
      previewContent = const CircularProgressIndicator();
    }
  return Column(
    children: [
      Container(
        height: 170,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 1,
          )
        ),
        child: previewContent,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [TextButton.icon(onPressed: _getCurrentLocation, icon: Icon(Icons.location_on_outlined), label: Text(
        'Get current location'
,style: GoogleFonts.ubuntuCondensed(),
       )),
       TextButton.icon(onPressed: () {}, icon: Icon(Icons.map_outlined), label: Text(
        'Select on Map'
,style: GoogleFonts.ubuntuCondensed(),
       ))],
      )
    ],
  );
  }
}