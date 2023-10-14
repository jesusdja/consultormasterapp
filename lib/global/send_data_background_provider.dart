import 'dart:async';
import 'dart:convert';
import 'package:consultormasterapp/global/providers/connectivity_provider.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/services/shared_preferences_static.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendDataBackGroundProvider extends ChangeNotifier {

  SendDataBackGroundProvider(){
    getData();
  }

  Future addToList({required String type, required String parms}) async{
    Map<String,dynamic> body = {'type' : type, 'parms' : parms};
    String dataSt = jsonEncode(body);

    List data = SharedPreferencesLocal.masterDataSend;
    List<String> listSt = [];
    for(int x = 0; x < data.length; x++){
      listSt.add(data[x]);
    }
    listSt.add(dataSt);
    SharedPreferencesLocal.masterDataSend = listSt;

    await Future.delayed(const Duration(seconds: 2));
    getData();
  }

  Future deleteToList({required int index}) async{
    List data = SharedPreferencesLocal.masterDataSend;
    List<String> listSt = [];
    for(int x = 0; x < data.length; x++){
      if(index != x){
        listSt.add(data[x]);
      }
    }
    SharedPreferencesLocal.masterDataSend = listSt;
  }


  Future<void> getData() async {

    try{
      if(Provider.of<ConnectivityProvider>(contextHome,listen: false).isConnection()){
        List data = SharedPreferencesLocal.masterDataSend;

        for(int x = 0; x < data.length; x++){
          try{
            Map dataSt = jsonDecode(data[x]);
            if(dataSt['type'] == '1'){
              type1(parms: dataSt['parms'], index: x);
            }
          }catch(e){
            debugPrint(e.toString());
          }
        }
      }
    }catch(_){
      await Future.delayed(const Duration(seconds: 3));
      getData();
    }
  }

  Future type1({required String parms, required int index}) async{
    deleteToList(index: index);
  }

}
