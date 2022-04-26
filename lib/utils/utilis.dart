import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchUrl(BuildContext context,ScanModel scan) async {

  final url=scan.valor;
  if(scan.tipo=='http'){
    // ignore: deprecated_member_use
    if(await canLaunch(url)){
    // ignore: deprecated_member_use
      await launch(url);
    }else{
      throw 'Could not launch';
  }
  }else{
    // ignore: avoid_print
    Navigator.pushNamed(context,'mapa', arguments: scan);
  }
  // ignore: deprecated_member_use
 
}