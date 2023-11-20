import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {

  DatabaseService _databaseService = DatabaseService();

  TextEditingController controllerNumIdentificacion = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  bool _obscureButton = true;
  bool get obscureButton => _obscureButton;
  set obscureButton(bool value){ _obscureButton = value; notifyListeners(); }

  Future initialPage() async{
    controllerNumIdentificacion = TextEditingController();
    controllerPass = TextEditingController();
    obscureButton = true;
    notifyListeners();
  }

  Future<Map<String,dynamic>> loginUser() async {

    Map<String,dynamic> result = {
      'error' : true,
      'message' : '',
    };

    MySqlConnection conn = await _databaseService.createConnection();
    CifradoService cifradoService = CifradoService();
    String claveCifrada = cifradoService.encryptPassword(controllerPass.text);

    try {
      var results = await _databaseService.executeQuery(
        conn,
        'SELECT id_dispositivo, id_estado_usuario, id_perfil, nro_identificacion FROM tbl_usuarios WHERE nro_identificacion = ?',
        [controllerNumIdentificacion.text],
      );

      if (results.isNotEmpty) {
        dynamic idDispositivoRaw = results.first['id_dispositivo'];
        int idEstadoUsuario = results.first['id_estado_usuario'] as int;
        int idPerfil = results.first['id_perfil'] as int;
        String nroIdentificacionDB = results.first['nro_identificacion'].toString();

        String idDispositivo = (idDispositivoRaw is num || idDispositivoRaw is String) ? idDispositivoRaw.toString() : '';

        // Verificar si la contraseña ingresada coincide con nro_identificacion en la base de datos
        if (controllerPass.text == nroIdentificacionDB) {
          result['message'] = 'Debe cambiar su contraseña antes de iniciar sesión.';
        }


        // VERIFICA ESTADO DE USUARIO Y ID PERFIL PARA PERMITIR INICIAR SESION

        if (idEstadoUsuario == 1 && (idPerfil == 1 || idPerfil == 19 || idPerfil == 8 || idPerfil == 35)) {

          String dispositivoId = await obtenerIdDispositivo();

          // Si idDispositivo no es un número o letra, considerarlo como vacío y enlazar el ID del dispositivo
          if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(idDispositivo)) {
            // Verificar si el dispositivoId ya está enlazado a otro usuario
            var existingUserResults = await conn.query(
              'SELECT * FROM tbl_usuarios WHERE id_dispositivo = ?',
              [dispositivoId],
            );

            if (existingUserResults.isNotEmpty) {
              // El dispositivo ya está enlazado a otro usuario, no permitir el inicio de sesión
              await conn.close();
              result['message'] = 'Inicio de sesión fallido, el dispositivo está enlazado a otro usuario.';
            }

            // Actualizar la columna id_dispositivo en la base de datos con el ID del dispositivo del teléfono
            await conn.query(
              'UPDATE tbl_usuarios SET id_dispositivo = ? WHERE nro_identificacion = ?',
              [dispositivoId, controllerNumIdentificacion.text],
            );
          } else {
            // Verificar si el ID del dispositivo almacenado no coincide con el ID actual
            if (idDispositivo != dispositivoId) {
              // Los IDs no coinciden, indicar que el dispositivo no está enlazado
              await conn.close();
              result['message'] = 'Inicio de sesión fallido, el usuario se encuentra enlazado en otro dispositivo.';
            }
          }

          var loginResults = await conn.query(
            'SELECT * FROM tbl_usuarios WHERE nro_identificacion = ? AND clave = ?',
            [controllerNumIdentificacion.text, claveCifrada],
          );

          if (loginResults.isNotEmpty) {
            result['error'] = false;
            result['message'] = 'Inicio de sesión exitoso.';
          } else {
            result['message'] = 'Inicio de sesión fallido, credenciales incorrectas.';
          }
        } else if (idEstadoUsuario == 4) {
          result['message'] = 'Inicio de sesión fallido. Usuario bloqueado.';

        } else if (idEstadoUsuario == 2) {
          result['message'] = 'Inicio de sesión fallido, usuario Inactivo.';

        } else if (idEstadoUsuario == 3) {
          result['message'] = 'Inicio de sesión fallido, usuario deshabilitado.';

        } else if (idEstadoUsuario == 6) {
          result['message'] = 'Inicio de sesión fallido, usuario deshabilitado.';
        } else {
          result['message'] = 'Inicio de sesión fallido, no tiene permisos para usar esta App.';
        }
      } else {
        result['message'] = 'Inicio de sesión fallido, usuario no encontrado.';
      }
    } catch (e) {
      result['message'] = 'Inicio de sesión fallido, error al ejecutar la consulta: $e';
    }


    await conn.close();
    return result;
  }
}
