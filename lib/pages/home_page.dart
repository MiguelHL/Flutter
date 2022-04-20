import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigator.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.delete))
        ],
      ),
      body:  _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const  ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //capture the selected menu opt

    final uiProvider= Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    //final tempScan = ScanModel(valor: 'http://google.com');
    //DBProvider.db.nuevoScan(tempScan);
    //DBProvider.db.deleteAllScan().then(print);
    DBProvider.db.deleteScan(1);

  

    switch(currentIndex){

      case 0:
        return const MapasPage();
      case 1:
        return const DireccionesPage();

      default:
        return const MapasPage();

    }
  }
}