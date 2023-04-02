import 'package:flutter/material.dart';
class Exhibit {

  Exhibit(this.qr){
    conversation = "";
    if(qr.substring(0,4) == "http"){
      qrType = 1;
    }else{
      qrType = 0;
    }

    if(qrType == 0) {
      final exhibitInfo = qr.split('\$');
      exhibitName = exhibitInfo[0];
      exhibitContext = exhibitInfo[1];
    }
  }

  String qr = "";
  int qrType = 0; // planned feature to determine QR context
  String exhibitName = "";
  String exhibitContext = "";
  String conversation = "";

  String getConversation() {
    return conversation;
  }
}