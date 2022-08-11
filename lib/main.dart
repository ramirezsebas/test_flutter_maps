import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[
      Marker(
        width: 80,
        height: 80,
        point: LatLng(-25.351160369420136, -57.51604328218503),
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      ),
      Marker(
        width: 80,
        height: 80,
        point: LatLng(-25.35281956987464, -57.53726112077505),
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      ),
      Marker(
        width: 80,
        height: 80,
        point: LatLng(-25.355014343819185, -57.54162108878123),
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      ),
      Marker(
        width: 80,
        height: 80,
        point: LatLng(-25.347902585349217, -57.513640022917414),
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      ),
      Marker(
        width: 80,
        height: 80,
        point: LatLng(-25.354157764375888, -57.5435449549236),
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      ),
    ];
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Maps'),
        ),
        body: Builder(
          builder: (context) {
            return ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPage(
                      markers: markers,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.map),
              label: const Text("VER SUCURSALES"),
            );
          },
        ),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  const MapPage({Key? key, required this.markers}) : super(key: key);
  final List<Marker> markers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      body: MyFlutterMap(markers: markers),
    );
  }
}

class MyFlutterMap extends StatelessWidget {
  MyFlutterMap({
    Key? key,
    required this.markers,
  }) : super(key: key);

  final List<Marker> markers;
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      key: const Key("map"),
      options: MapOptions(
        center: LatLng(-25.352927998045462, -57.5371988078218),
        zoom: 14,
        maxZoom: 19.0,
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      ),
      nonRotatedLayers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayerOptions(markers: markers)
      ],
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: () {},
        ),
      ],
    );
  }
}

abstract class MapRepository {
  Future<List<Marker>> getMarkers();
}

class MyMap extends StatelessWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Coordinates {
  final double x;
  final double y;

  const Coordinates({required this.x, required this.y});
}

abstract class MarkerBehavior {
  void find(List<Coordinates> coordinates);
}

class FlutterMapMarkerBehaviour implements MarkerBehavior {
  final FlutterMap map;

  FlutterMapMarkerBehaviour(this.map);

  @override
  void find(List<Coordinates> coordinates) {
    List<Marker> markers = coordinates
        .map(
          (e) => Marker(
            width: 80,
            height: 80,
            point: LatLng(e.x, e.y),
            builder: (ctx) => const Icon(
              Icons.location_on,
              color: Colors.red,
            ),
          ),
        )
        .toList();
  }
}
