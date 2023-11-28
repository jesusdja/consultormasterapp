// ignore_for_file: use_build_context_synchronously

import 'package:animated_button/animated_button.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/pages/home/menu/create_register/widgets/capture_finger/methol_channel.dart';
import 'package:consultormasterapp/pages/home/menu/create_register/widgets/capture_finger/result_huella.dart';
import 'package:flutter/material.dart';

class CaptureFingerPage extends StatefulWidget {
  const CaptureFingerPage({Key? key}) : super(key: key);

  @override
  State<CaptureFingerPage> createState() => _CaptureFingerPageState();
}

class _CaptureFingerPageState extends State<CaptureFingerPage> {

  @override
  void initState() {
    super.initState();
    //PermissionHandlerClass();
  }

  @override
  Widget build(BuildContext context) {

    sizeH = MediaQuery.of(context).size.height;
    sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: floatingActionButtonWidget(),
      body: SizedBox(
        width: double.infinity,
        child: Container(),
      ),
    );
  }

  Widget floatingActionButtonWidget(){
    return AnimatedButton(
      onPressed: () => startScan(),
      enabled: true,
      width: sizeW * 0.2,
      child: const Icon(
        Icons.fingerprint_outlined,
        color: Colors.white,
        size: 45,
      ),
    );
  }
  //METODOS
  void startScan() async {
    Map<dynamic,dynamic> result = await AndroidChannel.startScan();
    bool? res = await Navigator.push(context, MaterialPageRoute(builder:
        (BuildContext context) => ResultHuella(result: result,)));
    if(res != null && res){
      setState(() {});
    }
  }
}
