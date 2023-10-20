import 'dart:developer';

import 'package:consultormasterapp/widgets_utils/toast_widget.dart';
import 'package:mysql1/mysql1.dart';

class MySqlConnectionLocal {

  static late MySqlConnection mySqlConnection;

  static Future configureConnection() async {
    try{
      var settings = ConnectionSettings(
        host: 'cluster-ro-chlfd6z8pt.amazonaws.com',
        port: 3306,
        user: 'admin',
        password: 'R8P8H1248C12',
        db: 'codatabase',
      );
      mySqlConnection = await MySqlConnection.connect(settings);
    }catch(e){
      log(e.toString());
      showAlert(text: e.toString(),isError: true);
    }
  }

  Future closet() async{
    await mySqlConnection.close();
  }
}
