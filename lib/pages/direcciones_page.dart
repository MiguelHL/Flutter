import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';


class DireccionesPage extends StatelessWidget {
  const DireccionesPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final scanListProvider=Provider.of<ScanListProvider>(context);
  final scans = scanListProvider.scans;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_,index)=> ListTile(
          leading: const Icon(Icons.home_max_outlined, color: Colors.deepPurple),
          title: Text(scans[index].valor),
          subtitle: Text(scans[index].id.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
          onTap: (){
              // ignore: avoid_print
              print('hacer algo...');
          },
        )
    );
  }
}