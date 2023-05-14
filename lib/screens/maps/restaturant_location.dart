import 'dart:async';

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/favorite_restaurants.dart';
import 'package:weight_loser/screens/maps/methods.dart';
import 'package:weight_loser/utils/AppConfig.dart';

import '../../models/favorite_restaurant.dart';
import '../../models/nearbylocation.dart';
import '../../utils/ImagePath.dart';
import '../../widget/CustomDrawer.dart';
import 'apiProvider.dart';

class RestaurantLocation extends StatefulWidget {
  RestaurantLocation({Key key, @required this.favrestaurants})
      : super(key: key);
  FavoriteRestaurant favrestaurants;

  @override
  State<RestaurantLocation> createState() => _RestaurantLocationState();
}

class _RestaurantLocationState extends State<RestaurantLocation> {
  GoogleMapController mapscontroller;
  final Connectivity _connectivity = Connectivity();
  //StreamSubscription<ConnectivityResult> _connectivitySubscription;
  NearByLocationModel _suggestions;
  LatLng initialpos;
  bool internetstatus = false;
  List<Marker> _markers = [];
  List<Circle> _circle = [];
  bool loadmarkers = false;
  bool _showGoogleMaps = false;

  @override
  void initState() {
    // TODO: implement initState
    _markers.clear();
    super.initState();

    LoadLocation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //_connectivitySubscription.cancel();
    mapscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //drawer: const CustomDrawer(),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.white,
        title: Text('Tabs Demo'),
        iconTheme: IconThemeData(color: Colors.grey),
        actions: [
          Padding(padding: const EdgeInsets.all(8.0), child: Text('')),
        ],
      ),
      body: Container(
          height: size.height,
          child: initialpos != null
              ? GoogleMap(
                  markers: Set<Marker>.of(_markers),

                  //circles: Set<Circle>.of(_circle),
                  onMapCreated: (controller) {
                    setState(() {
                      mapscontroller = controller;
                    });
                  },
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(initialpos.latitude, initialpos.longitude),
                      zoom: 13))
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  Future getcurrentlocation() async {
    Geolocator.getCurrentPosition().then((value) async {
      initialpos = LatLng(value.latitude, value.longitude);
      print("My Location: ${initialpos.latitude},${initialpos.longitude}");
      print("hello initialPos");
      await PlaceApiProvider()
          .fetchSuggestions("McDonald", initialpos)
          .then((value) async {
        print("Restaurants Result Length:" + value.results.length.toString());
        if (value != null) {
          _suggestions = value;

          _suggestions.results.forEach((element) async {
            var defaultImageUrl =
                'https://cdn.vectorstock.com/i/1000x1000/45/66/restaurant-orange-circle-icon-design-vector-21964566.webp';

            if (widget.favrestaurants != null) {
              widget.favrestaurants.restaurants.forEach((element1) {
                print("Image for:${element1.restaurantName}");
                if (element1.restaurantName.trim().toLowerCase() ==
                    element.name.trim().toLowerCase()) {
                  print("Match Found");
                  defaultImageUrl = '$imageBaseUrl${element1.image}';
                }
              });
            }

            print("Icon Url:" + defaultImageUrl);
            BitmapDescriptor bitmap =
                await ImageCropper().resizeAndCircle(defaultImageUrl, 110);
            LatLng point = LatLng(
                element.geometry.location.lat, element.geometry.location.lng);
            setState(() {
              _markers.add(Marker(
                onTap: () {},
                markerId: MarkerId(element.placeId),
                position: point,
                icon: bitmap,
                infoWindow: InfoWindow(
                    title: element.name,
                    snippet:
                        'Rating: ${element.rating == null ? 0 : element.rating}'),
              ));
            });
          });
        } else
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Could Not Load Nearby Restaurants"),
          ));
      });

      setState(() {
        initialpos;
      });
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() => internetstatus = true);
        break;
      case ConnectivityResult.none:
        setState(() => internetstatus = false);
        break;
      default:
        break;
    }
  }

  LoadLocation() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
        await getcurrentlocation();
      } else if (status.isDenied) {
        LocationPermission permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          await getcurrentlocation();
        } else if (status.isPermanentlyDenied) {
          openAppSettings().then((value) async {
            var status = await Permission.location.status;
            if (status.isGranted) {
              await getcurrentlocation();
            }
          });
        }
      }
      /*
      await Permission.locationWhenInUse.request().then((value) async {
        if (value.isGranted) {
          await Permission.locationAlways.request().then((value) async {
>>>>>>> 0069111d68de7434ab96547e401d343adb1f206f
            if (value.isGranted) {
              LocationPermission permission =
                  await Geolocator.checkPermission();
              if (permission == LocationPermission.denied) {
                permission = await Geolocator.requestPermission();
              }
              if (permission == LocationPermission.whileInUse ||
                  permission == LocationPermission.always) {
                await getcurrentlocation();
              }
            }
          });
        }
      });
      
    } else if (Platform.isIOS) {
      await Permission.locationWhenInUse.request().then((value) async {
        print("location Permission:" + value.toString());

        if (value.isPermanentlyDenied)
          openAppSettings();
        else if (value.isGranted) {
          await Permission.locationAlways.request().then((value) async {
            if (value.isGranted) {
              LocationPermission permission =
                  await Geolocator.checkPermission();
              if (permission == LocationPermission.denied) {
                permission = await Geolocator.requestPermission();
              }
              if (permission == LocationPermission.whileInUse ||
                  permission == LocationPermission.always) {
                await getcurrentlocation();
              }
            }
          });
        }
      });
    }
  */
    }
  }
}
