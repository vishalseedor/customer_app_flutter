import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/tracking_api.dart';
import '../../const/color_const.dart';
import '../../map/config_map.dart';
import '../../provider/address/address_data.dart';
import '../../services/progress_dialog.dart';

class GoogleMapTracking extends StatefulWidget {
  static const routeName = 'googlemap-traking';
  const GoogleMapTracking({Key key}) : super(key: key);

  @override
  _GoogleMapTrackingState createState() => _GoogleMapTrackingState();
}

class _GoogleMapTrackingState extends State<GoogleMapTracking> {
  List<LatLng> polyLineCoordinates = [];
  Set<Polyline> polylineSet = {};
  StreamSubscription<Position> streamSubscription;
  double latitude = 0.0;
  double longitude = 0.0;
  var address = 'Getting Address..'.obs;
  double bottompaddingOfMap = 0;

  String distance = '0.00km';
  String time = '0.00 mins';

  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};

  double lat;
  double lang;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLocation();
    final address =
        Provider.of<AddressData>(context, listen: false).pickUpLocation;
    String delivery = address.area + ',' + address.town + ',' + address.state;
    getLatLng(delivery);
  }

  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(13.0826802, 80.2707184),
    zoom: 14.4746,
  );
  Position currentPosition;

  void locatePosition() async {
    // getpeemission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentPosition = position;

    LatLng latLangPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLangPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    // String address =await AssistentMethod.searchCoordinateAddres(position,context);
    // print('This is your address' + address.toString());
  }

  getLocation() async {
    bool serviceEnabled;

    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are  denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied,we cannot request permissions.');
    }
    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      //  latitude.value='Latitude:${position.latitude}';
      // longitude.value='Longitude:${position.longitude}';
      latitude = position.latitude;
      longitude = position.longitude;
      print(latitude.toString() + '--->>> moving latitude');
    });
  }

  @override
  Widget build(BuildContext context) {
    // _makingPhoneCall()async{
    //   const url = 'tel:9790611702';
    //   if(await canLaunch(url)){
    //     await launch(url);
    //   }else{
    //     throw "Could not launch $url";
    //   }
    // }

    final address =
        Provider.of<AddressData>(context, listen: false).pickUpLocation;

    Future<void> getPlaceDirection() async {
      // var initialPosition = Provider.of<AppData>(context,listen: false).pickUpLocation;
      // var finalPosition = Provider.of<AppData>(context,listen: false).dropOffLocation;

      var pickUpLatLand = LatLng(lat, lang);
      var dropOffLatLng = LatLng(latitude, longitude);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ProgressDialog(
              message: 'Please wait...',
            );
          });

      var details = await RequestAssistents.obtainPlaceDirectionDetails(
          pickUpLatLand, dropOffLatLng);
      setState(() {
        distance = details.distanceText;
        time = details.durationText;
      });

      Navigator.of(context).pop();

      PolylinePoints polylinePoints = PolylinePoints();

      List<PointLatLng> decodePolyLinePointsResult =
          polylinePoints.decodePolyline(details.encodepoints);

      polyLineCoordinates.clear();

      if (decodePolyLinePointsResult.isNotEmpty) {
        for (var pointLatLng in decodePolyLinePointsResult) {
          polyLineCoordinates
              .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
        }
      }

      polylineSet.clear();
      setState(() {
        Polyline polyline = Polyline(
            color: Colors.pink,
            polylineId: const PolylineId('PolylineId'),
            jointType: JointType.round,
            points: polyLineCoordinates,
            width: 2,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            geodesic: true);
        polylineSet.add(polyline);
      });
      LatLngBounds latLngBounds;
      if (pickUpLatLand.latitude > dropOffLatLng.latitude &&
          pickUpLatLand.longitude > dropOffLatLng.longitude) {
        latLngBounds =
            LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLand);
      } else if (pickUpLatLand.longitude > dropOffLatLng.longitude) {
        latLngBounds = LatLngBounds(
            southwest: LatLng(pickUpLatLand.latitude, dropOffLatLng.longitude),
            northeast: LatLng(dropOffLatLng.latitude, pickUpLatLand.longitude));
      } else if (pickUpLatLand.latitude > dropOffLatLng.latitude) {
        latLngBounds = LatLngBounds(
            southwest: LatLng(dropOffLatLng.latitude, pickUpLatLand.longitude),
            northeast: LatLng(pickUpLatLand.latitude, dropOffLatLng.longitude));
      } else {
        latLngBounds =
            LatLngBounds(southwest: pickUpLatLand, northeast: dropOffLatLng);
      }
      newGoogleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 50));

      Marker pickUpLocationMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: InfoWindow(title: address.area, snippet: 'my Location'),
        position: pickUpLatLand,
        markerId: const MarkerId('pickupId'),
      );

      Marker dropOffLocationMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow:
            const InfoWindow(title: 'Nagercoil', snippet: 'DropOff Location'),
        position: dropOffLatLng,
        markerId: const MarkerId('dropoffId'),
      );
      setState(() {
        markerSet.add(pickUpLocationMarker);
        markerSet.add(dropOffLocationMarker);
      });

      Circle pickupCircle = Circle(
          fillColor: Colors.blue,
          center: pickUpLatLand,
          radius: 12,
          strokeWidth: 3,
          strokeColor: Colors.blueAccent,
          circleId: const CircleId('pickupId'));
      Circle dropOffCircle = Circle(
          fillColor: Colors.orange,
          center: dropOffLatLng,
          radius: 12,
          strokeWidth: 3,
          strokeColor: Colors.orangeAccent,
          circleId: const CircleId('pickupId'));

      setState(() {
        circleSet.add(pickupCircle);
        circleSet.add(dropOffCircle);
      });
    }

    // var address = ModalRoute.of(context).settings.arguments;
    // print('phoneNumber' + address.toString());

    // Future.delayed(Duration.zero, () async {
    //   address;
    // });
    // Address address = ModalRoute.of(context).settings.arguments;

    // print('sushalt phone' + address.phoneNumber);

    Size size = MediaQuery.of(context).size;
    // String dropOffLocation = 'Nagercoil';
    // String delivery = address.area + ',' + address.town + ',' + address.state;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottompaddingOfMap),
            mapType: MapType.hybrid,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            polylines: polylineSet,
            markers: markerSet,
            circles: circleSet,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                bottompaddingOfMap = 200;
              });
              locatePosition();
            },
          ),
          Positioned(
            top: 25,
            left: 0,
            child: Card(
              color: CustomColor.whitecolor,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: size.height * 0.31,
              width: size.width,
              decoration: BoxDecoration(
                  color: CustomColor.whitecolor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColor.blackcolor,
                      blurRadius: 0.2,
                      offset: Offset(0.07, 0.07),
                    )
                  ]),
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  'Distance :' + distance.toString() ??
                                      '0.00km',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: CustomColor.blackcolor)),
                              Text('Time :' + time.toString() ?? '00.00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: CustomColor.blackcolor)),
                              GestureDetector(
                                onTap: () async {
                                  await getPlaceDirection();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: CustomColor.orangecolor),
                                  child: const Text('Start Tracking',
                                      style: TextStyle(
                                          color: CustomColor.whitecolor,
                                          fontSize: 13)),
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Your Address : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          color: CustomColor.blackcolor),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Text(
                                          address.houseNumber +
                                              ',' +
                                              address.area +
                                              ',' +
                                              address.town +
                                              ',' +
                                              address.state,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                              color: CustomColor.blackcolor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                            address.pincode +
                                                ',' +
                                                address.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                                color: CustomColor.blackcolor)),
                                      ],
                                    ))
                              ],
                            ),
                          ),

                          // Text(address.name + ',' + address.houseNumber + address.pincode + delivery +',' +address.phoneNumber,style: Theme.of(context).textTheme.caption,textAlign: TextAlign.center,),
                          // Text('Address Type : ' + address.addresstype,style: Theme.of(context).textTheme.subtitle2,),
                        ],
                      )),
                  const Divider(),
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text('Driver Address : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: CustomColor.blackcolor))),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Text(
                                            '120b'
                                            ','
                                            'Maravai'
                                            ','
                                            'Nagercoil'
                                            ','
                                            'TamilNadu',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                                color: CustomColor.blackcolor)),
                                        Text('629002' ',' 'Sushalt',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                                color: CustomColor.blackcolor)),
                                        InkWell(
                                          onTap: () => launch('tel:9790611702'),
                                          child: Container(
                                            width: size.width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: CustomColor.orangecolor),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            child: const Text(
                                              ' Make Call ',
                                              style: TextStyle(
                                                  color: CustomColor.whitecolor,
                                                  fontSize: 13),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ],
                      )),
                  // ElevatedButton(onPressed: (){
                  //   // getLatLng(delivery);
                  //    getPlaceDirection();
                  // }, child:const Text('Start'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void getLatLng(String placeName) async {
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$placeName&key=$mapKey';
    var response = await RequestAssistents.getRequest(url);
    if (response == 'failed') {
      return;
    }
    if (response['status'] == 'OK') {
      // Address address = Address();
      setState(() {
        lat = response['results'][0]['geometry']['location']['lat'];
        lang = response['results'][0]['geometry']['location']['lng'];
      });

      // print('sushalt lat lng ::' + lat.toString() +
      // lang.toString());
      // var lng = response['results'][0]['geometry']['location']['lat'];
      // print('sushalt latlng ::' + lng.toString());
    }
  }
}
