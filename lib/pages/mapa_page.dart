import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage>{

    
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {

    final ScanModel scan= ModalRoute.of(context)?.settings.arguments as ScanModel;
    
    CameraPosition puntoInicial= CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 1.0,
    );
    return  Scaffold(
      body: GoogleMap(
        myLocationEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}