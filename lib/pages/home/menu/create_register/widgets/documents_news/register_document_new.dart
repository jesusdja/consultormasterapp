import 'dart:io';

import 'package:camera/camera.dart';
import 'package:consultormasterapp/config/master_colors.dart';
import 'package:consultormasterapp/config/master_image.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/pages/home/menu/create_register/provider/create_register_new_provider.dart';
import 'package:consultormasterapp/pages/home/menu/create_register/widgets/documents_news/register_document_send_data.dart';
import 'package:consultormasterapp/services/permission.dart';
import 'package:consultormasterapp/widgets_utils/button_general.dart';
import 'package:consultormasterapp/widgets_utils/circular_progress_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterDocumentNew extends StatefulWidget {
  const RegisterDocumentNew({Key? key}) : super(key: key);

  @override
  State<RegisterDocumentNew> createState() => _RegisterDocumentNewState();
}

class _RegisterDocumentNewState extends State<RegisterDocumentNew> {

  late CreateRegisterNewProvider createRegisterNewProvider;

  @override
  void initState() {
    super.initState();
    initialData();
  }

  Future initialData() async{
    bool result = await PermissionApp().requestCameraPermission();
    if(!result) { initialData(); }
    await Future.delayed(const Duration(seconds: 2));
    createRegisterNewProvider.initCameraController();
  }



  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        create: (context) => CreateRegisterNewProvider(),
        child: Consumer<CreateRegisterNewProvider>(
            builder: (context, provider, child){
              createRegisterNewProvider = provider;

              return Scaffold(
                body: Container(
                  color: Colors.white,
                  height: double.infinity,width: double.infinity,
                  child: provider.loadData ? circularProgressColors() :
                  (provider.captureFinish ? ( provider.captureFinishContinue ?
                  const RegisterDocumentSendData() : bodyFinish()) : body()),
                ),
              );
            }
        )
    );
  }

  Widget body(){
    return Stack(
      children: [
        Center(child: CameraPreview(createRegisterNewProvider.cameraController!)),
        Positioned.fill(
          child: Image.asset(
            createRegisterNewProvider.takingFirstPhoto ? MasterImage.marco : MasterImage.marcoPosterior,
            fit: BoxFit.contain,
          ),
        ),
        Column(
          children: [
            Expanded(
              child: Container(),
            ),
            // boton de captura de pantalla
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centra los botones en la parte inferior
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 75.0), // Ajusta la cantidad de espacio vertical aquí
                  child:  createRegisterNewProvider.captureImage ?
                  circularProgressColors(widthContainer2: sizeW * 0.1) :
                  InkWell(
                    onTap: () {
                      createRegisterNewProvider.takePhoto();
                    },
                    borderRadius: BorderRadius.circular(100.0), // Ajusta el radio del borde para hacer el botón circular
                    child: Container(
                      width: 60.0, // Ajusta el ancho del botón
                      height: 60.0, // Ajusta la altura del botón
                      decoration: const BoxDecoration(
                        color: Colors.blue, // Puedes personalizar el color de fondo
                        shape: BoxShape.circle, // Hace que el contenedor sea circular
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: 40.0, // Ajusta el tamaño del ícono aquí
                          color: Colors.white, // Puedes personalizar el color del ícono
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget bodyFinish(){
    return createRegisterNewProvider.resultText.isEmpty ?
    circularProgressColors() :
    Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: sizeH * 0.1,),
                imagePhoto(type: 1),
                SizedBox(height: sizeH * 0.02,),
                imagePhoto(type: 2),
                SizedBox(height: sizeH * 0.02,),
                Container(
                  width: sizeW,
                  margin: EdgeInsets.symmetric(horizontal: sizeW * 0.03),
                  child: Text(createRegisterNewProvider.resultText),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: sizeH * 0.03,),
        buttons(),
        SizedBox(height: sizeH * 0.05,),
      ],
    );
  }

  Widget imagePhoto({required int type}){

    File file = createRegisterNewProvider.capturedImage1!;
    if(type == 2){ file = createRegisterNewProvider.capturedImage2!; }

    return Container(
      width: sizeW,
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.03),
      child: RotatedBox(
        quarterTurns: 1,
        child: Image(
          image: Image.file(file).image,
          fit: BoxFit.fitWidth,

        ),
      ),
    );
  }

  Widget buttons(){

    Color bgColor = MasterColors.primary4;
    double hD = sizeH * 0.05;

    return Container(
      width: sizeW,
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.03),
      child: Row(
        children: [
          Expanded(
            child: ButtonGeneral(
              title: 'Salir',
              backgroundColor: bgColor,
              height: hD,
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(width: sizeW * 0.02,),
          Expanded(
            child: ButtonGeneral(
              title: 'Repetir',
              backgroundColor: bgColor,
              height: hD,
              onPressed: () async {
                await createRegisterNewProvider.initialData();
                createRegisterNewProvider.initCameraController();
              },
            ),
          ),
          SizedBox(width: sizeW * 0.02,),
          Expanded(
            child: ButtonGeneral(
              title: 'Continuar',
              backgroundColor: bgColor,
              height: hD,
              onPressed: (){
                createRegisterNewProvider.captureFinishContinue = true;
              },
            ),
          ),
        ],
      ),
    );
  }
}
