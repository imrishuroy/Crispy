import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

import '/models/outlet.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

const String _errorImg = 'https://mediawebben.se/assets/img/error/img.png';

// Todo: Remove map zoom in and zoom out
class MapScreen extends StatefulWidget {
  final Outlet? outlet;

  const MapScreen({Key? key, required this.outlet}) : super(key: key);

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  void _launchURL({required url}) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  void _lauchPhoneNo(String? phNo) async {
    await launch('tel://$phNo');
  }

  final Completer<GoogleMapController> _controller = Completer();

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(23.2524, 77.5021),
  //   zoom: 14.4746,
  // );

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(23.2524, 77.5021),
  //   zoom: 14.4746,
  // );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  @override
  void initState() {
    _add();
    super.initState();
  }

  void _add() {
    print('Map runs ---------_!');
    var markerIdVal = 'aaarrkmalsala';
    final MarkerId markerId = MarkerId(markerIdVal);
    if (widget.outlet?.location?.latitude != null &&
        widget.outlet?.location?.longitude != null) {
      print('Map runs ---------_2');
      // creating a new MARKER
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(widget.outlet!.location!.latitude,
            widget.outlet!.location!.longitude),
        //  LatLng(
        //   center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
        //   center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
        // ),
        infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
        onTap: () {
          //_onMarkerTapped(markerId);
        },
      );

      setState(() {
        // adding a new marker to map
        markers[markerId] = marker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Lat  --------- ${widget.outlet?.location?.latitude}');

    print('Long  --------- ${widget.outlet?.location?.longitude}');

    return Scaffold(
      backgroundColor: Colors.black,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           GeoCode geoCode = GeoCode();
//           // From coordinates
//           final address = await geoCode.reverseGeocoding(
//               latitude: 23.2486367, longitude: 77.50223369999999);
//           print('Address $address');
// // first = addresses.first;
// // print("${first.featureName} : ${first.addressLine}");
//         },
//       ),
      // body: GoogleMap(
      //     myLocationButtonEnabled: false,
      //     // tiltGesturesEnabled: false,
      //     // onCameraMove: (CameraPosition cameraPosition) {
      //     //   print(cameraPosition.zoom);
      //     // },
      //     // zoomGesturesEnabled: true,
      //     markers: Set<Marker>.of(markers.values),
      //     mapType: MapType.normal,
      //     zoomControlsEnabled: true,
      //     initialCameraPosition: _kGooglePlex,
      //     onMapCreated: (GoogleMapController controller) {
      //       _controller.complete(controller);
      //     },
      //     onTap: (LatLng latLng) {
      //       Marker marker = Marker(
      //         draggable: true,
      //         markerId: MarkerId(latLng.toString()),
      //       );
      //     }
      //     //_customInfoWindowController.hideInfoWindow!();

      //     ),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 500.0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child: GoogleMap(
                  markers: Set<Marker>.of(markers.values),
                  mapType: MapType.normal,
                  //enable zoom gestures
                  zoomGesturesEnabled: false,
                  //  initialCameraPosition: ,
                  // initialCameraPosition: _kGooglePlex,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.outlet?.location?.latitude ?? 22.0,
                        widget.outlet?.location?.longitude ?? 30.0),
                    zoom: 14.4746,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 80.0,
                              width: 110.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    widget.outlet?.outletImg ?? _errorImg,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              // child: Image.network(
                              //     'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=Aap_uEDQ8E_TnsEQCXm7jEH7pnNH_tJPi_Fi3quV62k4-AZwO3vikRoxVwI3bnJKtxuWdqf9pTLeARAITVdBv6qIxCS9Nsa4zxYHFSuHxM4z-wraYPN4x6jxevNLXEmueMcLlSa0hMEDFPofYlErzwKxgqUbKYYP_vJQ_eKz22osO_8G-OSz&key=AIzaSyCWjmMNRDr1881C34m8p4iTac6ocqWdlYI'),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                widget.outlet?.name ?? 'N/A',
                                style: const TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  // letterSpacing: 0.9,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Text(
                          widget.outlet?.address ?? 'N/A',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,

                            // letterSpacing: 0.9,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        // const Text(
                        //   'Contact :',
                        //   style: TextStyle(
                        //     fontSize: 17.0,
                        //     color: Colors.black,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        const SizedBox(height: 4.0),
                        SizedBox(
                          width: 200.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0;
                                  i < (widget.outlet?.rattings ?? 0);
                                  i++)
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        InkWell(
                          onTap: () {
                            _lauchPhoneNo(widget.outlet?.phNo);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: Colors.grey,
                                size: 22.0,
                              ),
                              const SizedBox(width: 10.0),
                              Text(
                                widget.outlet?.phNo ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.public,
                              color: Colors.grey,
                              size: 22.0,
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  print('this rusn --------1');
                                  if (widget.outlet?.website != null &&
                                      widget.outlet?.website != '') {
                                    print('this rusn --------2');
                                    if (widget.outlet!.website!
                                        .contains('http')) {
                                      print('this rusn --------');
                                      _launchURL(url: widget.outlet!.website);
                                    }
                                  }
                                },
                                child: Text(
                                  widget.outlet?.website ?? 'N/A',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      decoration: TextDecoration.underline,
                                      overflow: TextOverflow.fade),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}








// import 'package:flutter/material.dart';
// //AIzaSyBTtR33f5AF8dwtcNmmmj1LXitclssRepM
// class MapScreen extends StatelessWidget {
//   const MapScreen({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

      
//     );
//   }
// }

// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// // ignore_for_file: public_member_api_docs

// import 'dart:async';
// import 'dart:math';
// import 'dart:ui';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class PlaceMarkerBody extends StatefulWidget {
//   const PlaceMarkerBody();

//   @override
//   State<StatefulWidget> createState() => PlaceMarkerBodyState();
// }

// typedef MarkerUpdateAction = Marker Function(Marker marker);

// class PlaceMarkerBodyState extends State<PlaceMarkerBody> {
//   PlaceMarkerBodyState();
//   static final LatLng center = const LatLng(-33.86711, 151.1947171);

//   GoogleMapController? controller;
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   MarkerId? selectedMarker;
//   int _markerIdCounter = 1;
//   LatLng? markerPosition;

//   void _onMapCreated(GoogleMapController controller) {
//     this.controller = controller;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void _onMarkerTapped(MarkerId markerId) {
//     final Marker? tappedMarker = markers[markerId];
//     if (tappedMarker != null) {
//       setState(() {
//         final MarkerId? previousMarkerId = selectedMarker;
//         if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
//           final Marker resetOld = markers[previousMarkerId]!
//               .copyWith(iconParam: BitmapDescriptor.defaultMarker);
//           markers[previousMarkerId] = resetOld;
//         }
//         selectedMarker = markerId;
//         final Marker newMarker = tappedMarker.copyWith(
//           iconParam: BitmapDescriptor.defaultMarkerWithHue(
//             BitmapDescriptor.hueGreen,
//           ),
//         );
//         markers[markerId] = newMarker;

//         markerPosition = null;
//       });
//     }
//   }

//   void _onMarkerDrag(MarkerId markerId, LatLng newPosition) async {
//     setState(() {
//       this.markerPosition = newPosition;
//     });
//   }

//   void _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
//     final Marker? tappedMarker = markers[markerId];
//     if (tappedMarker != null) {
//       setState(() {
//         this.markerPosition = null;
//       });
//       await showDialog<void>(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//                 actions: <Widget>[
//                   TextButton(
//                     child: const Text('OK'),
//                     onPressed: () => Navigator.of(context).pop(),
//                   )
//                 ],
//                 content: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 66),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Text('Old position: ${tappedMarker.position}'),
//                         Text('New position: $newPosition'),
//                       ],
//                     )));
//           });
//     }
//   }

//   void _add() {
//     final int markerCount = markers.length;

//     if (markerCount == 12) {
//       return;
//     }

//     final String markerIdVal = 'marker_id_$_markerIdCounter';
//     _markerIdCounter++;
//     final MarkerId markerId = MarkerId(markerIdVal);

//     final Marker marker = Marker(
//       markerId: markerId,
//       position: LatLng(
//         center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
//         center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
//       ),
//       infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
//       onTap: () => _onMarkerTapped(markerId),
//       onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
//       onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
//     );

//     setState(() {
//       markers[markerId] = marker;
//     });
//   }

//   void _remove(MarkerId markerId) {
//     setState(() {
//       if (markers.containsKey(markerId)) {
//         markers.remove(markerId);
//       }
//     });
//   }

//   void _changePosition(MarkerId markerId) {
//     final Marker marker = markers[markerId]!;
//     final LatLng current = marker.position;
//     final Offset offset = Offset(
//       center.latitude - current.latitude,
//       center.longitude - current.longitude,
//     );
//     setState(() {
//       markers[markerId] = marker.copyWith(
//         positionParam: LatLng(
//           center.latitude + offset.dy,
//           center.longitude + offset.dx,
//         ),
//       );
//     });
//   }

//   void _changeAnchor(MarkerId markerId) {
//     final Marker marker = markers[markerId]!;
//     final Offset currentAnchor = marker.anchor;
//     final Offset newAnchor = Offset(1.0 - currentAnchor.dy, currentAnchor.dx);
//     setState(() {
//       markers[markerId] = marker.copyWith(
//         anchorParam: newAnchor,
//       );
//     });
//   }

//   Future<void> _changeInfoAnchor(MarkerId markerId) async {
//     final Marker marker = markers[markerId]!;
//     final Offset currentAnchor = marker.infoWindow.anchor;
//     final Offset newAnchor = Offset(1.0 - currentAnchor.dy, currentAnchor.dx);
//     setState(() {
//       markers[markerId] = marker.copyWith(
//         infoWindowParam: marker.infoWindow.copyWith(
//           anchorParam: newAnchor,
//         ),
//       );
//     });
//   }

//   Future<void> _toggleDraggable(MarkerId markerId) async {
//     final Marker marker = markers[markerId]!;
//     setState(() {
//       markers[markerId] = marker.copyWith(
//         draggableParam: !marker.draggable,
//       );
//     });
//   }

//   Future<void> _toggleFlat(MarkerId markerId) async {
//     final Marker marker = markers[markerId]!;
//     setState(() {
//       markers[markerId] = marker.copyWith(
//         flatParam: !marker.flat,
//       );
//     });
//   }

//   Future<void> _changeInfo(MarkerId markerId) async {
//     final Marker marker = markers[markerId]!;
//     final String newSnippet = marker.infoWindow.snippet! + '*';
//     setState(() {
//       markers[markerId] = marker.copyWith(
//         infoWindowParam: marker.infoWindow.copyWith(
//           snippetParam: newSnippet,
//         ),
//       );
//     });
//   }

//   Future<void> _changeAlpha(MarkerId markerId) async {
//     final Marker marker = markers[markerId]!;
//     final double current = marker.alpha;
//     setState(() {
//       markers[markerId] = marker.copyWith(
//         alphaParam: current < 0.1 ? 1.0 : current * 0.75,
//       );
//     });
//   }

//   Future<void> _changeRotation(MarkerId markerId) async {
//     final Marker marker = markers[markerId]!;
//     final double current = marker.rotation;
//     setState(() {
//       markers[markerId] = marker.copyWith(
//         rotationParam: current == 330.0 ? 0.0 : current + 30.0,
//       );
//     });
//   }

//   Future<void> _toggleVisible(MarkerId markerId) async {
//     final Marker marker = markers[markerId]!;
//     setState(() {
//       markers[markerId] = marker.copyWith(
//         visibleParam: !marker.visible,
//       );
//     });
//   }

//   Future<void> _changeZIndex(MarkerId markerId) async {
//     final Marker marker = markers[markerId]!;
//     final double current = marker.zIndex;
//     setState(() {
//       markers[markerId] = marker.copyWith(
//         zIndexParam: current == 12.0 ? 0.0 : current + 1.0,
//       );
//     });
//   }

//   void _setMarkerIcon(MarkerId markerId, BitmapDescriptor assetIcon) {
//     final Marker marker = markers[markerId]!;
//     setState(() {
//       markers[markerId] = marker.copyWith(
//         iconParam: assetIcon,
//       );
//     });
//   }

//   Future<BitmapDescriptor> _getAssetIcon(BuildContext context) async {
//     final Completer<BitmapDescriptor> bitmapIcon =
//         Completer<BitmapDescriptor>();
//     final ImageConfiguration config = createLocalImageConfiguration(context);

//     const AssetImage('assets/red_square.png')
//         .resolve(config)
//         .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
//       final ByteData? bytes =
//           await image.image.toByteData(format: ImageByteFormat.png);
//       if (bytes == null) {
//         bitmapIcon.completeError(Exception('Unable to encode icon'));
//         return;
//       }
//       final BitmapDescriptor bitmap =
//           BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
//       bitmapIcon.complete(bitmap);
//     }));

//     return await bitmapIcon.future;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final MarkerId? selectedId = selectedMarker;
//     return Stack(children: [
//       Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Expanded(
//             child: GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: const CameraPosition(
//                 target: LatLng(-33.852, 151.211),
//                 zoom: 11.0,
//               ),
//               markers: Set<Marker>.of(markers.values),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               TextButton(
//                 child: const Text('Add'),
//                 onPressed: _add,
//               ),
//               TextButton(
//                 child: const Text('Remove'),
//                 onPressed:
//                     selectedId == null ? null : () => _remove(selectedId),
//               ),
//             ],
//           ),
//           Wrap(
//             alignment: WrapAlignment.spaceEvenly,
//             children: <Widget>[
//               TextButton(
//                 child: const Text('change info'),
//                 onPressed:
//                     selectedId == null ? null : () => _changeInfo(selectedId),
//               ),
//               TextButton(
//                 child: const Text('change info anchor'),
//                 onPressed: selectedId == null
//                     ? null
//                     : () => _changeInfoAnchor(selectedId),
//               ),
//               TextButton(
//                 child: const Text('change alpha'),
//                 onPressed:
//                     selectedId == null ? null : () => _changeAlpha(selectedId),
//               ),
//               TextButton(
//                 child: const Text('change anchor'),
//                 onPressed:
//                     selectedId == null ? null : () => _changeAnchor(selectedId),
//               ),
//               TextButton(
//                 child: const Text('toggle draggable'),
//                 onPressed: selectedId == null
//                     ? null
//                     : () => _toggleDraggable(selectedId),
//               ),
//               TextButton(
//                 child: const Text('toggle flat'),
//                 onPressed:
//                     selectedId == null ? null : () => _toggleFlat(selectedId),
//               ),
//               TextButton(
//                 child: const Text('change position'),
//                 onPressed: selectedId == null
//                     ? null
//                     : () => _changePosition(selectedId),
//               ),
//               TextButton(
//                 child: const Text('change rotation'),
//                 onPressed: selectedId == null
//                     ? null
//                     : () => _changeRotation(selectedId),
//               ),
//               TextButton(
//                 child: const Text('toggle visible'),
//                 onPressed: selectedId == null
//                     ? null
//                     : () => _toggleVisible(selectedId),
//               ),
//               TextButton(
//                 child: const Text('change zIndex'),
//                 onPressed:
//                     selectedId == null ? null : () => _changeZIndex(selectedId),
//               ),
//               TextButton(
//                 child: const Text('set marker icon'),
//                 onPressed: selectedId == null
//                     ? null
//                     : () {
//                         _getAssetIcon(context).then(
//                           (BitmapDescriptor icon) {
//                             _setMarkerIcon(selectedId, icon);
//                           },
//                         );
//                       },
//               ),
//             ],
//           ),
//         ],
//       ),
//       Visibility(
//         visible: markerPosition != null,
//         child: Container(
//           color: Colors.white70,
//           height: 30,
//           padding: EdgeInsets.only(left: 12, right: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               markerPosition == null
//                   ? Container()
//                   : Expanded(child: Text("lat: ${markerPosition!.latitude}")),
//               markerPosition == null
//                   ? Container()
//                   : Expanded(child: Text("lng: ${markerPosition!.longitude}")),
//             ],
//           ),
//         ),
//       ),
//     ]);
//   }
// }
