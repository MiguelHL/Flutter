import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';


class MapasPage extends StatelessWidget {
  const MapasPage({ Key? key }) : super(key: key);

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
        child: ListTile(
            leading: const Icon(Icons.map, color: Colors.deepPurple),
            title: Text(scans[index].valor),
            subtitle: Text(scans[index].id.toString()),
            trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
            onTap: (){
                // ignore: avoid_print
                print('hacer algo...');
            },
          ),
      )
    );
  }
}