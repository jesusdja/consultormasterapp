
import 'package:consultormasterapp/config/master_crypter.dart';
import 'package:consultormasterapp/services/my_sql_connection_static.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {

  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  bool _obscureButton = true;
  bool get obscureButton => _obscureButton;
  set obscureButton(bool value){ _obscureButton = value; notifyListeners(); }

  Future initialPage() async{
    controllerUser = TextEditingController();
    controllerPass = TextEditingController();
    obscureButton = true;
    notifyListeners();
  }

  Future<bool> loginUser() async {
    String claveCifrada = MasterEncrypted().encryptPassword(controllerPass.text);
    var conn = MySqlConnectionLocal.mySqlConnection;
    var results = await conn.query(
      'SELECT * FROM tbl_usuarios WHERE nro_identificacion = ? AND clave = ?',
      [controllerUser.text, claveCifrada],
    );
    if (results.isNotEmpty) {
      // Si hay resultados, significa que el inicio de sesión fue exitoso
      // Asigna el valor de id_entidad a la variable global loggedInIdEntidad
      //loggedInIdEntidad = results.first['id_entidad'];
      return true;
    } else {
      return false;
    }
  }
}
