import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utilis.dart';

class ScanTiles extends StatelessWidget {

  final String tipo;
  // ignore: use_key_in_widget_constructors
  const ScanTiles({required this.tipo});


  @override
  Widget build(BuildContext context) {
  
  final scanListProvider=Provider.of<ScanListProvider>(context);
  final scans = scanListProvider.scans;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_,index)=> Dismissible(
        key: UniqueKey(),
        onDismissed: (DismissDirection direction){
          Provider.of<ScanListProvider>(context, listen: false).borrarScanPorId(scans[index].id!);
        },
        background: Container(color:Colors.redAccent,),
        child: scans[index].tipo =='geo' && tipo=='geo' ?ListTile(
            leading: const Icon(Icons.map, color: Colors.deepPurple),
            title: Text(scans[index].valor),
            subtitle: Text(scans[index].id.toString()),
            trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
            onTap: (){
                  launchUrl(context, scans[index]);
            },
          ):scans[index].tipo =='http' && tipo =='http'? ListTile(
            leading: const Icon(Icons.home, color: Colors.deepPurple),
            title: Text(scans[index].valor),
            subtitle: Text(scans[index].id.toString()),
            trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
            onTap: (){
                launchUrl(context, scans[index]);
            },
          ):const SizedBox(),
      )
    );
  }
}