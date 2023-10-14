import 'package:consultormasterapp/config/master_colors.dart';
import 'package:consultormasterapp/config/master_style.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/pages/home/menu/create_register/create_register.dart';
import 'package:consultormasterapp/pages/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {

    homeProvider = Provider.of<HomeProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05),
          child: Column(
            children: [
              SizedBox(height: sizeH * 0.02,),
              SizedBox(
                width: sizeW,
                child: Text('HOLA,',style: MasterStyles().stylePrimary(size: sizeH * 0.026,color: Colors.blue[900]!),),
              ),
              SizedBox(
                width: sizeW,
                child: Text('JESUS CORTEZ,',style: MasterStyles().stylePrimary(size: sizeH * 0.026,color: Colors.blue[900]!),),
              ),
              SizedBox(height: sizeH * 0.01,),
              SizedBox(
                width: sizeW,
                child: Text('Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500.',
                  style: MasterStyles().stylePrimary(size: sizeH * 0.016,color: Colors.black),maxLines: 1),
              ),
              SizedBox(height: sizeH * 0.03,),
              SizedBox(
                width: sizeW,
                child: Text('Que desea hacer hoy?',style: MasterStyles().stylePrimary(
                    size: sizeH * 0.026,color: Colors.blue[900]!),
                textAlign: TextAlign.center,),
              ),
              SizedBox(height: sizeH * 0.03,),
              Expanded(
                child: Wrap(
                  spacing: sizeW * 0.05,
                  runSpacing: sizeH * 0.02,
                  children: [
                    cardMenu(type: 1),
                    cardMenu(type: 2),
                    cardMenu(type: 3),
                  ],
                ),
              ),
              Container(
                height: 5,
                width: sizeW,
                margin: EdgeInsets.symmetric(vertical: sizeH * 0.02,horizontal: sizeW * 0.2),
                color: Colors.black,
                // decoration: const BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [MasterColors.primary2,MasterColors.primary2,MasterColors.primary,MasterColors.primary],
                  //   begin: Alignment.centerLeft,
                  //   end: Alignment.centerRight,
                  // ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar(){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      actions: [
        SizedBox(
          width: sizeW,
          child: Row(
            children: [
              SizedBox(width: sizeW * 0.05,),
              Expanded(
                child: Text('Dashboard',style: MasterStyles().stylePrimary(size: sizeH * 0.02,color: Colors.black,fontWeight: FontWeight.bold),),
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(right: sizeW * 0.05),
                  child: Icon(Icons.notifications,color: Colors.blue[900]!,size: sizeH * 0.03,),
                ),
                onTap: (){

                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget cardMenu({required int type}){

    Color colorText = Colors.white;
    String title = '';
    if(type == 1){ title = 'Consultar estado'; }
    if(type == 2){ title = 'Crear registro'; }
    if(type == 3){ title = 'Pendientes'; }

    double wAll = sizeH * 0.18;

    return Container(
      width: wAll,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        border: Border.all(
          color : Colors.grey[400]!,
          width : 1.0,
          style : BorderStyle.solid,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey,
        //     offset: Offset(0.0,0.0),
        //     spreadRadius: -5,
        //     blurRadius: 15,
        //   )
        // ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: (){
              if(type == 1){
                Navigator.push(context,MaterialPageRoute<void>(
                    builder: (context) => const CreateRegister()
                ),);
              }
            },
            child: Container(
              //color: Colors.black,
              //margin: const EdgeInsets.all(10.0),
              // decoration: const BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(20.0)),
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey,
              //       offset: Offset(0.0,0.0),
              //       spreadRadius: -5,
              //       blurRadius: 15,
              //     )
              //   ],
              //   color: Colors.white,
              // ),
              child: Center(
                child: Container(
                  width: sizeH * 0.1,
                  height: sizeH * 0.1,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Image.asset('assets/img/lupapng.gif').image,
                          fit: BoxFit.contain
                      )
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: sizeH * 0.01),
          SizedBox(
            width: wAll,
            child: Text(title,style: MasterStyles().stylePrimary(
              size: sizeH * 0.016,color: Colors.black,fontWeight: FontWeight.bold
            ),textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}
