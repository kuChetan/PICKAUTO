import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:location/location.dart';
import 'package:pickauto/components/const.dart';


import '../components/rounded_button.dart';

class LocationMapScreen extends StatefulWidget {
  const LocationMapScreen({Key? key});
  static String id = 'map_screen';

  @override
  State<LocationMapScreen> createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _sourceController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  bool _isTextfieldVisible = false;
  bool _showFbutton = true;
  List<LatLng> _sourceLocation = [];
  List<LatLng> _destinationLocation = [];
  List<Circle> sourceMarkers = [];
  List<Marker> destMarkers = [];
  bool _showFields = false;
  // List<Circle> getcircles =[];
  List<Polyline> _polyline = [];

 // initState
   @override
  void initState() {
    // TODO: implement initState
    _getUserPosition();
    // getPolyPoints();
    // addCustomIcon();
    super.initState();
  }


    // Intitial camera position is set to (0,0)
  LatLng _center = LatLng(0, 0);
  Position? _currentLocation;
  var geolocator = Geolocator();
  // This function is for gettng the current location of the user we need to call this function while app is start so need to call inside a initState.

  Future _getUserPosition() async {
    _currentLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _currentLocation = position;
      _center = LatLng(_currentLocation!.latitude, _currentLocation!.longitude);
    });

    // LatLng latlngPosition =
    //     LatLng(currentLocation!.latitude, currentLocation!.longitude);
    print(_currentLocation);
    // CameraPosition cameraPosition =
    //     CameraPosition(target: latlngPosition, zoom: 14);
    // return currentLocation;
    // GoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition),);
  }


// This function will work whenyour textbox is open. So using this function you will get the coordiantes of the google map by taping on the map
// So here we are passing the coordinates of the source and destination to the corresponding markers, Source location is going to Circle and destination coordinates are passing to the Markers.
//  Here we are checking that the textfiels are empty or not if empty then create a mark.
  _handleTap(LatLng tappedcoordinate) async {
    print(tappedcoordinate);
    // final Uint8List markerIcon = getByte
    // Passing the value of the choosed coordinates to the text field by converting it into string
    String latLngString =
        '${tappedcoordinate.latitude},${tappedcoordinate.longitude}';
    if (_sourceController.text.isEmpty ) {
      // FocusScope.of(context).focusedChild?.toString() ==
      //   'EditableText-[TextEditingValue(text: \'Source\')]'
      setState(() {
        _sourceController.text = latLngString;
        // print(_sourceController.text);
        // sourceMarkers = [];
        // _sourceLocation.add(tappedcoordinate);
        // print(_sourceLocation);
        sourceMarkers.add(
          Circle(
            circleId: CircleId(tappedcoordinate.toString()),
            fillColor: Colors.redAccent.withOpacity(0.5),
            center: tappedcoordinate,
            strokeWidth: 2,
            strokeColor: Colors.redAccent,
            radius: 100.0,
          ),
        );
      });
    } else if (_destinationController.text.isEmpty)
      // FocusScope.of(context).focusedChild?.toString() ==
      //   'EditableText-[TextEditingValue(text: \'Destination\')]') 
        {
      setState(() {
        _destinationController.text = latLngString;
        print(_destinationController.text);
        // destMarkers = [];
        // _destinationLocation.add(tappedcoordinate);
        destMarkers.add(
          Marker(
            markerId: MarkerId(tappedcoordinate.toString()),
            position: tappedcoordinate,
            infoWindow: InfoWindow(
              title: 'destination',
            ),
            // draggable: true,
          ),
        );
      });
    }
   
  }

    // On press on get path button the bellow function will work.
    // Here we Taking the String value from the textfield and converting it into double and storing it into a LatLng variable. Similarly we are doing for the destination part.
    // Then we draw the polyline by making an object and add it inside setstate.
  void _onPressed() {
    if(_sourceController.text.isEmpty && _destinationController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please Choose both Source and destination'),
        duration: Duration(seconds: 2),
        ),
      );
    }else
      {
    // Converting the String value of the text fields to Double and then converting it into LatLng
    LatLng source = LatLng
    (double.parse(_sourceController.text.split(',')[0]),
    double.parse(_sourceController.text.split(',')[1]));
    LatLng destination = LatLng
    (double.parse(_destinationController.text.split(',')[0]),
    double.parse(_destinationController.text.split(',')[1]));
    // Adding the source coordinate to sourceLocation list
      _sourceLocation.add(source);
      // Adding the destination coordinates to the destination list
      _destinationLocation.add(destination);
    // Here we are putting theh source and location of a polyline inside an object of polyine.

      Polyline polyline = Polyline(polylineId: PolylineId('${_sourceLocation.length}'),
      points: [source,destination],
      color: Colors.blue,
      width: 3,
      );
      // Add the polyline inside setState so when ever you creat a new one it will show you the polylines.
      setState(() {
        _polyline.add(polyline);
      
      // Here we are checking that textfield are visible or not. So after pressing the get path button text field will dissapear and shows the Floating button
      //Also on press the text field will clear the selected points. 

      _isTextfieldVisible = !_isTextfieldVisible;
      _showFbutton = !_showFbutton;
      _sourceController.clear();
      _destinationController.clear();
    });
    // Navigator.pop(context);
    // _toogleField();
  }

  }
 
 

  // on below line we have specified camera position
  static final CameraPosition _kGoogle = CameraPosition(
    target: LatLng(17.4331567, 78.4633012),
    zoom: 14.4746,
  );




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // currentLocation == null ? SpinKitDualRing(color: Colors.white,
          //  size: 100.0,):
          Container(
        child: SafeArea(
          // on below line creating google maps
          child: Stack(
            children: [
              GoogleMap(
                // on below line setting camera position
                initialCameraPosition:
                    // _kGoogle,
                    CameraPosition(target: _center, zoom: 13.5),
                //  heatmapLayers
                onTap: _isTextfieldVisible? _handleTap:null,

                circles: Set.from(sourceMarkers),
                markers: Set.from(destMarkers),
                polylines: Set.from(_polyline),
                // on below line specifying map type.
                mapType: MapType.normal,
                // on below line setting user location enabled.
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                // on below line setting compass enabled.
                compassEnabled: true,
                // on below line specifying controller on map complete.
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  // getUserPosition();
                },
              ),
              // Position is used for to show the container by pressing the floating button, So to use it we need to wrap our map inside a stack,
              // At first the visibility is se to false so when it got enabled it will come to the screen.
              Positioned(
                bottom: 0,
                left: 0 ,
                right: 0,

                child: Visibility(
                  visible: _isTextfieldVisible,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                         Text(
                            'Add Your Source and Destination',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          // Source textfield
                          TextField(
                            controller: _sourceController,
                            autofocus: true,
                            // readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: kTextfieldDecoration.copyWith(
                                hintText: 'Source'),
                            onTap: (){
                              // _focusNode.unfocus();
                              setState(() {
                                // _isSourceFocused = true;
                              });
                            },
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          // Destination Textfield
                          TextField(
                            controller: _destinationController,
                            autofocus: true,
                            textAlign: TextAlign.center,
                            decoration: kTextfieldDecoration.copyWith(
                                hintText: 'Destination'),
                            onTap: (){
                              // _focusNode.unfocus();
                              setState(() {
                                // _isSourceFocused = true;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          // Custom button
                          RoundedButton(
                            onPressed: _onPressed,
                            selectedColor: Colors.redAccent,
                            buttonText: 'Get Path',
                          ),

                      ],
                    ),
                  ),),),
            ],
          ),
        ),
      ),
      // Here we are checking that the floating butto is pressed or not if pressed then dont show if not then show.
      floatingActionButton:_showFbutton? Positioned(
        bottom: 16.0,
        right: 16.0,
        child: FloatingActionButton(
          onPressed: () {
          //  on pressed the button dont show the floating button
            setState(() {
              _isTextfieldVisible = !_isTextfieldVisible;
              _showFbutton = !_showFbutton;
            });
            // _toogleField();
          
          },
          backgroundColor: Colors.redAccent,
          child: Icon(
            Icons.subdirectory_arrow_right_rounded,
            color: Colors.white,
          ),
        ),
      ):null,
    );
  }
}
