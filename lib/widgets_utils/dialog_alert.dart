import 'package:consultormasterapp/config/master_colors.dart';
import 'package:consultormasterapp/config/master_image.dart';
import 'package:consultormasterapp/config/master_style.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool?> alertTitle({required String title, String? subTitle}) async{
  bool? res = await showDialog(
      context: contextHome,
      builder: ( context ) {
        return AlertDialog(
          title: Text(title),
          content: Text(subTitle ?? ''),
          actions: <Widget>[
            CupertinoButton(
              child: const Text('Aceptar'),
              onPressed: ()  {
                Navigator.of(context).pop(true);
              },
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
            CupertinoButton(
              child: const Text('Cancelar'),
              onPressed: ()  {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      }
  );
  return res;
}

Future<bool?> alertCard() async{
  bool? res = await showDialog(
      context: contextHome,
      builder: ( context ) {
        return SimpleDialog(
          children: [
            SizedBox(
              width: sizeW * 0.8,
              child: Column(
                children: [
                  Container(
                    width: sizeW,
                    height: sizeH * 0.2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Image.asset(MasterImage.dni).image,
                          fit: BoxFit.fitHeight,
                        )
                    ),
                  ),
                  textTitle(title: 'Recomendaciones para escanear cualquier tipo de documento'),
                  SizedBox(height: sizeH * 0.02),
                  textOptionTitle(title: 'Ubicate en un lugar iluminado, preferiblemente luz natural.'),
                  textOptionTitle(title: 'Ubica el documente en una superficie plana.'),
                  textOptionTitle(title: 'Captura el documento con la camara enfocada.'),
                  textOptionTitle(title: 'Verifica que la camara no este empanada o sucia.'),
                  SizedBox(height: sizeH * 0.02),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue[500]),),
                    child: Text('Continuar',style: MasterStyles().stylePrimary(
                        size: sizeH * 0.02,color: Colors.white,fontWeight: FontWeight.bold
                    ),),
                    onPressed: (){
                      Navigator.of(context).pop(true);
                    },
                  )
                ],
              ),
            ),
          ],
        );
      }
  );
  return res ?? true;
}

Widget textTitle({required String title}){
  return Container(
    width: sizeW,
    margin: EdgeInsets.symmetric(horizontal: sizeW * 0.03),
    child: Text(title,style: MasterStyles().stylePrimary(
        size: sizeH * 0.025,color: Colors.black,fontWeight: FontWeight.bold
    ),textAlign: TextAlign.center),
  );
}

Widget textOptionTitle({required String title}){
  return Container(
    width: sizeW,
    margin: EdgeInsets.only(left: sizeW * 0.05, right: sizeW * 0.02),
    child: Text(title,style: MasterStyles().stylePrimary(
        size: sizeH * 0.018,color: MasterColors.textColor,fontWeight: FontWeight.bold
    ),textAlign: TextAlign.left),
  );
}

//ubicate en un lugar iluminado, preferiblemente luz natural
//ubica el documente en una superfie plana
//captura el documento con la camara enfocada
//verifica que la camara no este empanada y este limpia
//cedula nueva, cecula anterior, cedula extranjera