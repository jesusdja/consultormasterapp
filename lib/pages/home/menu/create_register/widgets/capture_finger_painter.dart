import 'dart:ui' as ui;
import 'package:consultormasterapp/config/master_colors.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/widgets_utils/button_general.dart';
import 'package:finger_painter/finger_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CaptureFingerPainter extends StatefulWidget {
  const CaptureFingerPainter({Key? key, required this.imgBytesList}) : super(key: key);
  final Uint8List? imgBytesList;
  @override
  State<CaptureFingerPainter> createState() => _CaptureFingerPainterState();
}

class _CaptureFingerPainterState extends State<CaptureFingerPainter> {

  Image? image;
  late PainterController painterController;
  bool typeClean = false;
  Uint8List? imgBytesList;

  @override
  void initState() {
    super.initState();

    image = null;
    typeClean = false;
    imgBytesList = null;

    painterController = PainterController()
      ..setStrokeColor(Colors.black)
      ..setMinStrokeWidth(3)
      ..setMaxStrokeWidth(15)
      ..setBlurSigma(0.0)
      ..setPenType(PenType.paintbrush2)
      ..setBlendMode(ui.BlendMode.srcOver);

    if(widget.imgBytesList != null){
      painterController.setBackgroundImage(widget.imgBytesList!);
      imgBytesList = widget.imgBytesList!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: sizeH * 0.1),
          Painter(
            controller: painterController,
            backgroundColor: const Color(0xFFF0F0F0),
            onDrawingEnded: (bytes) async {
              imgBytesList = painterController.getImageBytes();
              setState(() {});
            },
            size: Size(double.infinity, sizeH * 0.6),
            // child: Image.asset('assets/map.png', fit: BoxFit.cover),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(),
          ),
          SizedBox(height: sizeH * 0.03),
          buttons(),
          SizedBox(height: sizeH * 0.03),
        ],
      ),
    );
  }

  Widget controls({required Uint8List? imgBytesList}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: sizeW * 0.03),
          //   decoration: BoxDecoration(
          //     color: const Color(0x00FFFFFF),
          //     border: Border.all(
          //       color: const Color(0xFF000000),
          //       style: BorderStyle.solid,
          //       width: 4.0,
          //     ),
          //     borderRadius: BorderRadius.zero,
          //     shape: BoxShape.rectangle,
          //     boxShadow: const <BoxShadow>[
          //       BoxShadow(
          //         color: Color(0x66000000),
          //         blurRadius: 10.0,
          //         spreadRadius: 4.0,
          //       )
          //     ],
          //   ),
          //   child: imgBytesList != null ? Image.memory(
          //     imgBytesList,
          //     gaplessPlayback: true,
          //     fit: BoxFit.scaleDown,
          //     height: sizeH * 0.2,
          //     width: sizeW,
          //   ) : SizedBox(height: sizeH * 0.2,width: sizeW),
          // ),
          SizedBox(height: sizeH * 0.03),
          buttons(),
          SizedBox(height: sizeH * 0.03),
        ],
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
              title: 'Atras',
              backgroundColor: bgColor,
              height: hD,
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(width: sizeW * 0.02,),
          Expanded(
            child: ButtonGeneral(
              title: typeClean ? 'Escribir' : 'Borrar todo',
              backgroundColor: bgColor,
              height: hD,
              onPressed: (){
                if(typeClean){
                  painterController.setBlendMode(BlendMode.overlay);
                  typeClean = false;
                }else{
                  painterController.setBlendMode(BlendMode.clear);
                  typeClean = true;
                }
                setState(() {});
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
                Navigator.of(context).pop(painterController.getImageBytes());
              },
            ),
          ),
        ],
      ),
    );
  }
}

