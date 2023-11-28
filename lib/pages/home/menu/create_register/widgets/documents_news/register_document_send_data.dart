import 'package:consultormasterapp/config/master_colors.dart';
import 'package:consultormasterapp/config/master_style.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/pages/home/menu/create_register/provider/create_register_new_provider.dart';
import 'package:consultormasterapp/pages/home/menu/create_register/widgets/capture_finger/capture_finger_page.dart';
import 'package:consultormasterapp/pages/home/menu/create_register/widgets/documents_news/capture_files.dart';
import 'package:consultormasterapp/pages/home/menu/create_register/widgets/documents_news/capture_finger_painter.dart';
import 'package:consultormasterapp/widgets_utils/button_general.dart';
import 'package:consultormasterapp/widgets_utils/circular_progress_colors.dart';
import 'package:consultormasterapp/widgets_utils/textfield_general.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterDocumentSendData extends StatefulWidget {
  const RegisterDocumentSendData({Key? key}) : super(key: key);

  @override
  State<RegisterDocumentSendData> createState() => _RegisterDocumentSendDataState();
}

class _RegisterDocumentSendDataState extends State<RegisterDocumentSendData> {

  late CreateRegisterNewProvider createRegisterNewProvider;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200)).then((value){
      createRegisterNewProvider.initialData2();
    });
  }

  @override
  Widget build(BuildContext context) {

    createRegisterNewProvider = Provider.of<CreateRegisterNewProvider>(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.infinity,width: double.infinity,
        child: createRegisterNewProvider.captureFinger ? const CaptureFingerPage() : bodyFinish(),
      ),
    );
  }

  Widget bodyFinish(){
    return createRegisterNewProvider.resultText.isEmpty ?
    circularProgressColors() :
    Column(
      children: [
        Expanded(
          child: formData(),
        ),
        SizedBox(height: sizeH * 0.03,),
        buttons(),
        SizedBox(height: sizeH * 0.05,),
      ],
    );
  }

  Widget formData(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: sizeH * 0.1,),
          card(type: 1),
          SizedBox(height: sizeH * 0.02,),
          card(type: 2),
          SizedBox(height: sizeH * 0.02,),
          card(type: 3),
          SizedBox(height: sizeH * 0.02,),
          card(type: 4),
          SizedBox(height: sizeH * 0.02,),
          buttonFirma(),
          SizedBox(height: sizeH * 0.02,),
          buttonUploadFile(),
        ],
      ),
    );
  }


  Widget card({required int type}){

    TextEditingController controller = TextEditingController();
    String title = ''; bool multiLine = false;
    if(type == 1){
      controller = createRegisterNewProvider.controllerName;
      title = 'Nombres:';
    }
    if(type == 2){
      controller = createRegisterNewProvider.controllerLastName;
      title = 'Apellidos:';
    }
    if(type == 3){
      controller = createRegisterNewProvider.controllerDoc;
      title = 'Documento:';
    }
    if(type == 4){
      controller = createRegisterNewProvider.controllerComments;
      title = 'Comentario:';
      multiLine = true;
    }

    return Container(
      width: sizeW,
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
      child: Column(
        children: [
          SizedBox(
            width: sizeW,
            child: Text(title,style: MasterStyles().styleKalam(
              size: sizeH * 0.02,fontWeight: FontWeight.bold
            )),
          ),
          !multiLine ? SizedBox(
            width: sizeW,
            child: TextFieldGeneral(
              textEditingController: controller,
            ),
          ) :
          SizedBox(
            width: sizeW,
            child: TextFieldGeneral(
              textEditingController: controller,
              maxLines: 5,
              textInputType: TextInputType.multiline,
            ),
          )
        ],
      ),
    );
  }

  Widget buttonFirma(){
    return SizedBox(
      width: sizeW,
      child: ButtonGeneral(
        title: 'Agregar firma',
        backgroundColor: MasterColors.primary4,
        height: sizeH * 0.06,
        onPressed: () async {
          final imgBytesList = await Navigator.push(context,MaterialPageRoute<Uint8List?>(
              builder: (context) => CaptureFingerPainter(
                imgBytesList: createRegisterNewProvider.imgBytesList,
              )
          ),);
          if(imgBytesList != null){
            createRegisterNewProvider.imgBytesList = imgBytesList;
          }
        },
        margin: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
      ),
    );
  }

  Widget buttonUploadFile(){
    return SizedBox(
      width: sizeW,
      child: createRegisterNewProvider.loadPosition ?
      Center(
        child: circularProgressColors(
          widthContainer1: sizeW,widthContainer2: sizeW * 0.06
        ),
      ) :
      ButtonGeneral(
        title: 'Subir archivos',
        backgroundColor: MasterColors.primary4,
        height: sizeH * 0.06,
        margin: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
        onPressed: () async {
          final pathList = await Navigator.push(context,MaterialPageRoute<List<PlatformFile>?>(
              builder: (context) => CaptureFiles(
                listPlatformFile: createRegisterNewProvider.paths,
              )
          ),);
          createRegisterNewProvider.paths = pathList ?? [];
        },
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
              title: 'Atras',
              backgroundColor: bgColor,
              height: hD,
              onPressed: () async {
                createRegisterNewProvider.captureFinishContinue = false;
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
                createRegisterNewProvider.captureFinger = true;
              },
            ),
          ),
        ],
      ),
    );
  }
}
