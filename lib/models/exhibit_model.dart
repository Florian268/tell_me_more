import 'package:flutter/material.dart';
class ExhibitModel {

  ExhibitModel(this.qr){
    if(qr.substring(0,4) == "http"){
      qrType = 1;
    }else{
      qrType = 0;
    }

    if(qrType == 0) {
      final exhibitInfo = qr.split('\$');
      _exhibitName = exhibitInfo[0];
      exhibitContext = exhibitInfo[1];
    }
  }

  String qr = "";
  int qrType = 0; // planned feature to determine QR context
  late String _exhibitName;
  String exhibitContext = "";

  String getExhibitName() {
    return _exhibitName;
  }
}