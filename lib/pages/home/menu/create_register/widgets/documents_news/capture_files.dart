import 'dart:developer';

import 'package:consultormasterapp/config/master_colors.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/widgets_utils/button_general.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CaptureFiles extends StatefulWidget {
  const CaptureFiles({Key? key, required this.listPlatformFile}) : super(key: key);
  final List<PlatformFile>? listPlatformFile;

  @override
  State<CaptureFiles> createState() => _CaptureFilesState();
}

class _CaptureFilesState extends State<CaptureFiles> {

  List<PlatformFile> listPlatformFile = [];
  
  @override
  void initState() {
    super.initState();
    listPlatformFile = widget.listPlatformFile ?? [];
  }

  Future<bool> exit()async{
    return true;
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: exit,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: sizeH * 0.1,),
            Expanded(child: listDataUpload(),),
            SizedBox(height: sizeH * 0.02,),
            buttonUploadFile(),
            SizedBox(height: sizeH * 0.02,),
            buttons(),
            SizedBox(height: sizeH * 0.02,),
          ],
        ),
      ),
    );
  }

  Widget listDataUpload(){
    return SingleChildScrollView(
      child: Column(
        children: listPlatformFile.map((e) => Card(
          margin: EdgeInsets.only(top: sizeH * 0.02,right: sizeW * 0.02,left: sizeW * 0.02),
          elevation: 10,
          child: SizedBox(
            width: sizeW,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: sizeW * 0.03),
                    child: Text(e.name)
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.cancel_outlined,size: sizeH * 0.03),
                  onPressed: (){
                    listPlatformFile.remove(e);
                    setState(() {});
                  },
                )
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget buttonUploadFile(){
    return SizedBox(
      width: sizeW,
      child: ButtonGeneral(
        title: 'Agregar archivos',
        backgroundColor: MasterColors.primary4,
        height: sizeH * 0.05,
        margin: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
        onPressed: () async {
          uploadFiles();
        },
      ),
    );
  }

  Future uploadFiles() async {
    List<PlatformFile>? paths = [];
    try {
      paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'doc','pdf',],
      ))
          ?.files;
    } on PlatformException catch (e) {
      log('Unsupported operation : ${e.toString()}');
    } catch (e) {
      log(e.toString());
    }
    if (paths != null && paths.isNotEmpty) {
      for (var element in paths) {
        listPlatformFile.add(element);
      }
      setState(() {});
    }
  }

  Widget buttons(){

    Color bgColor = MasterColors.primary4;
    double hD = sizeH * 0.05;

    return Container(
      width: sizeW,
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
      child: Row(
        children: [
          Expanded(
            child: ButtonGeneral(
              title: 'Atras',
              backgroundColor: bgColor,
              height: hD,
              onPressed: (){
                Navigator.of(context).pop(listPlatformFile);
              },
            ),
          ),
          SizedBox(width: sizeW * 0.035,),
          Expanded(
            child: ButtonGeneral(
              title: 'Continuar',
              backgroundColor: bgColor,
              height: hD,
              onPressed: (){
                Navigator.of(context).pop(listPlatformFile);
              },
            ),
          ),
        ],
      ),
    );
  }
}
