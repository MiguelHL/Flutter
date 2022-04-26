import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans =[];
  String tipoSeleccionado ='http';

  Future<ScanModel> nuevoScan( String valor) async{

    final nuevoScan= ScanModel(valor: valor);
    final id= await DBProvider.db.nuevoScan(nuevoScan);

    nuevoScan.id =id;

    if(tipoSeleccionado == nuevoScan.tipo){
      scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  cargarScans() async{

    final scans= await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScanPorTipo( String tipo)async{

    final scans= await DBProvider.db.getScansForType(tipo);
    this.scans = [...scans];
    tipoSeleccionado = tipo;
    notifyListeners();

  }

  borrarTodos()async{

    await DBProvider.db.deleteAllScan();
    scans=[]; notifyListeners();

  }

  borrarScanPorId(int id) async{

    await DBProvider.db.deleteScan(id);
    scans= await DBProvider.db.getAllScans();
    // ignore: list_remove_unrelated_type

  }
}