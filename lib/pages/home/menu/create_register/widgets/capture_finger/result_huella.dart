import 'dart:convert';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/widgets_utils/textfield_general.dart';
import 'package:flutter/material.dart';

class ResultHuella extends StatefulWidget {
  const ResultHuella({Key? key, required this.result}) : super(key: key);
  final Map<dynamic, dynamic> result;

  @override
  State<ResultHuella> createState() => _ResultHuellaState();
}

class _ResultHuellaState extends State<ResultHuella> {

  Map<dynamic, dynamic> result = {};
  TextEditingController controllerName = TextEditingController();

  @override
  void initState() {
    super.initState();
    result = widget.result;
  }

  @override
  Widget build(BuildContext context) {

    Image? image;
    try{
      if(result.containsKey('img')){
        image = Image.memory(base64Decode(result['img'].toString().replaceAll('\n', '')));
      }
    }catch(e){
      print(e.toString());
    }

    return Scaffold(
      body: SizedBox(
        width: sizeW,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: sizeH * 0.2,),
              if(image != null)...[
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop({'action' : 'reset'});
                  },
                  child: Container(
                    width: sizeW,
                    height: sizeH * 0.05,
                    margin: EdgeInsets.symmetric(horizontal: sizeW * 0.2),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(
                        color : Colors.black,
                        width : 1.0,
                        style : BorderStyle.solid,
                      ),
                    ),
                    child: const Center(
                      child: Text('Volver a capturar huella',textAlign: TextAlign.center,style: TextStyle(
                        fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold
                      )),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 350,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                          image: image.image,
                          fit: BoxFit.fill
                      )
                  ),
                ),
                SizedBox(height: sizeH * 0.05,),
                SizedBox(
                  width: sizeW,
                  child: TextFieldGeneral(
                    textEditingController: controllerName,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
