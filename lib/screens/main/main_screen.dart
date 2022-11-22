import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foundee_mobile/common/map/map_functions.dart';
import 'package:foundee_mobile/services/geolocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Geolocation _geo = Geolocation();
  final MapFunctions _mapFunctions = MapFunctions();
  final storage = const FlutterSecureStorage();

  LatLng? _center;
  Position? _initialPosition;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    storage.read(key: 'access_token').then((value) =>
        {if (value == null) Navigator.pushReplacementNamed(context, '/login')});

    _geo
        .determinePosition()
        .then(
          (Position value) => setState(() {
            _initialPosition = value;
            _center = LatLng(value.latitude, value.longitude);
          }),
        )
        .catchError((onError) {
      print(onError);
    });
  }

  void _onMapChanged(MapPosition position) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _center = position.center;
        _mapFunctions.loadPoints(position.bounds!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Foundee"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Center(
                child: Image(
                  image: AssetImage("assets/logo_no_text.png"),
                ),
              ),
            ),
            ListTile(
              title: const Text("Logout"),
              leading: const Icon(Icons.logout),
              onTap: () {
                storage.delete(key: 'access_token');
                Navigator.pushReplacementNamed(context, '/login');
              },
            )
          ],
        ),
      ),
      body: _initialPosition != null
          ? Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    center: LatLng(_initialPosition!.latitude,
                        _initialPosition!.longitude),
                    zoom: 15.0,
                    onPositionChanged: (position, _hasGesture) {
                      _onMapChanged(position);
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(_initialPosition!.latitude,
                              _initialPosition!.longitude),
                          builder: (ctx) => const FlutterLogo(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.pushNamed(context, "/addnewpoint", arguments: _center);
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
