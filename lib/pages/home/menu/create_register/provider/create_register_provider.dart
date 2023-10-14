import 'package:flutter/material.dart';

class CreateRegisterProvider extends ChangeNotifier {

  CreateRegisterProvider(){
    initialData();
  }

  bool _loadData = true;
  bool get loadData => _loadData;
  set loadData( bool value ){ _loadData = value; notifyListeners(); }

  bool _takingFirstPhoto = true;
  bool get takingFirstPhoto => _takingFirstPhoto;
  set takingFirstPhoto( bool value ){ _takingFirstPhoto = value; notifyListeners(); }

  String _typeSelected = 'Seleccionar una opcion';
  String get typeSelected => _typeSelected;
  set typeSelected( String value ){ _typeSelected = value; notifyListeners(); }

  List<String> typesSt = ['Seleccionar una opcion','Documentos nuevos','Documentos viejos','Documentos extranjeros'];

  String _typeSt = 'Seleccionar una opcion';
  String get typeSt => _typeSt;
  set typeSt( String value ){ _typeSt = value; notifyListeners(); }


  void initialData(){
    typeSelected = 'Seleccionar una opcion';
    typeSt = '';
    loadData = true;
    takingFirstPhoto = true;
    notifyListeners();
  }
}