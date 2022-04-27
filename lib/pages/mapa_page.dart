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

    
  // ignore: prefer_final_fields
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {

    final ScanModel scan= ModalRoute.of(context)?.settings.arguments as ScanModel;
    
    CameraPosition puntoInicial= CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 1.0,
    );

    // ignore: prefer_collection_literals
    Set<Marker> markers= Set<Marker>();
    markers.add(Marker(
      markerId: const MarkerId('geo-location'),
      position: scan.getLatLng(),
      )
    );

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed:()async{
              final GoogleMapController controller= await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: scan.getLatLng(),zoom: 17,tilt: 50)
                )
              );
            }
          )
        ],
      ),
      body: GoogleMap(
        myLocationEnabled: false,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: (){
        if(mapType == MapType.normal){
          mapType=MapType.satellite;
        }else{
          mapType=MapType.normal;
        }
        setState(() {
          
        });
      },
      child: const Icon(Icons.ac_unit),),
    );
  }
}