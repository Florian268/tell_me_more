import 'package:flutter/material.dart';
class Exhibit {

  Exhibit(this.qr){
    final qrInfo = qr.split('Data: ');
    final exhibitInfo = qrInfo[1].split('\$');
    exhibitName = exhibitInfo[0];
    exhibitContext = exhibitInfo[1];
  }

  String qr = "";
  String exhibitName = "";
  String exhibitContext = "";
}