import 'package:flutter/cupertino.dart';
import 'package:wave_odc/providers/data_provider.dart';

class LayoutController{
  final DataProvider provider;
  final BuildContext context;
  LayoutController({required this.provider, required this.context});

  void changerPage(int index) {
     provider.setSelectedIndex(index);
     switch(index){
       case 0:
          Navigator.pushReplacementNamed(context, "/vendor/home");
          break;
       case 1:
         Navigator.pushReplacementNamed(context, "/vendor/transactions");
         break;
       default:
         Navigator.pushReplacementNamed(context, "/vendor/home");
         break;
     }
  }
}