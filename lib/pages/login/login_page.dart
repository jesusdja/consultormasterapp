// ignore_for_file: use_build_context_synchronously

import 'package:consultormasterapp/config/master_colors.dart';
import 'package:consultormasterapp/config/master_style.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/pages/login/provider/login_provider.dart';
import 'package:consultormasterapp/pages/splash/providers/splash_provider.dart';
import 'package:consultormasterapp/services/shared_preferences_static.dart';
import 'package:consultormasterapp/widgets_utils/button_general.dart';
import 'package:consultormasterapp/widgets_utils/textfield_general.dart';
import 'package:consultormasterapp/widgets_utils/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late LoginProvider loginProvider;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200)).then((value){
      loginProvider.initialPage();
    });
  }

  @override
  Widget build(BuildContext context) {

    loginProvider = Provider.of<LoginProvider>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MasterColors.primaryV2,
        body: Stack(
          children: [
            imgBg(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: sizeH * 0.13),
                  iconApp(),
                  SizedBox(height: sizeH * 0.02),
                  SizedBox(
                    width: sizeW,
                    child: Text('MCAS',style: MasterStyles().stylePrimary(
                      size: sizeH * 0.03,color: Colors.white,
                    ),textAlign: TextAlign.center),
                  ),
                  SizedBox(height: sizeH * 0.15),
                  SizedBox(
                    width: sizeW,
                    height: sizeH * 0.07,
                    child: TextFieldGeneral(
                      padding: const EdgeInsetsDirectional.only(top: 2,start: 10,end: 10),
                      textEditingController: loginProvider.controllerNumIdentificacion,
                      colorBack: Colors.transparent,
                      borderColor: Colors.white,
                      activeInputBorder: false,
                      textInputType: TextInputType.name,
                      hintText: 'Número de Identificación',
                      labelStyle: MasterStyles().stylePrimary(size: sizeH * 0.025,color: Colors.white70),
                      radius: 60,
                      suffixIcon: InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
                          child: Icon(Icons.person,
                              size: sizeH * 0.025,color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: sizeH * 0.03),
                  SizedBox(
                    width: sizeW,
                    height: sizeH * 0.07,
                    child: TextFieldGeneral(
                      padding: const EdgeInsetsDirectional.only(top: 2,start: 10,end: 10),
                      textEditingController: loginProvider.controllerPass,
                      colorBack: Colors.transparent,
                      borderColor: Colors.white,
                      activeInputBorder: false,
                      radius: 60,
                      textInputType: TextInputType.name,
                      labelStyle: MasterStyles().stylePrimary(size: sizeH * 0.025,color: Colors.white70),
                      hintText: 'Contraseña',
                      obscure: loginProvider.obscureButton,
                      suffixIcon: InkWell(
                        onTap: (){ loginProvider.obscureButton = !loginProvider.obscureButton; },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
                          child: Icon(loginProvider.obscureButton ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                              size: sizeH * 0.025,color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: sizeH * 0.06),
                  ButtonGeneral(
                    title: 'Iniciar Sesión',
                    textStyle: MasterStyles().stylePrimary(
                        size: sizeH * 0.023,
                        color: MasterColors.primaryV2,
                        fontWeight: FontWeight.bold
                    ),
                    height: sizeH * 0.07,
                    backgroundColor: Colors.white,
                    radius: 60,
                    onPressed: () async {

                      String textError = '';
                      if(loginProvider.controllerNumIdentificacion.text.isEmpty){
                        textError = 'Campo Número de Identificación es requerido';
                      }
                      if(loginProvider.controllerPass.text.isEmpty){
                        textError = 'Campo contrasena es requerido';
                      }

                      if(textError.isEmpty){
                        Map<String,dynamic> result = await loginProvider.loginUser();
                        if (!result['error']) {
                          showAlert(text: result['message']);
                          SharedPreferencesLocal.masterLogin = 1;
                          Provider.of<SplashProvider>(context,listen: false).initSplash();
                        } else {
                          showAlert(text: result['message'],isError: true);
                        }
                      }else{
                        showAlert(text: textError,isError: true);
                      }
                    },
                  ),
                  SizedBox(height: sizeH * 0.15),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget iconApp(){
    return Container(
      width: sizeH * 0.06,
      height: sizeH * 0.06,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset('assets/img/dni.png').image,
              fit: BoxFit.contain
          )
      ),
    );
  }

  Widget imgBg(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset('assets/img/fondoLogin.png').image,
              fit: BoxFit.fill
          )
      ),
    );
  }
}



// // ignore_for_file: use_build_context_synchronously
//
// import 'package:consultormasterapp/config/master_colors.dart';
// import 'package:consultormasterapp/config/master_style.dart';
// import 'package:consultormasterapp/initial_page.dart';
// import 'package:consultormasterapp/pages/login/provider/login_provider.dart';
// import 'package:consultormasterapp/pages/splash/providers/splash_provider.dart';
// import 'package:consultormasterapp/services/shared_preferences_static.dart';
// import 'package:consultormasterapp/widgets_utils/button_general.dart';
// import 'package:consultormasterapp/widgets_utils/textfield_general.dart';
// import 'package:consultormasterapp/widgets_utils/toast_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//
//   late LoginProvider loginProvider;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(milliseconds: 200)).then((value){
//       loginProvider.initialPage();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     loginProvider = Provider.of<LoginProvider>(context);
//
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: MasterColors.primaryV2,
//         body: Container(
//           margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: sizeH * 0.13),
//               iconApp(),
//               SizedBox(height: sizeH * 0.01),
//               SizedBox(
//                 width: sizeW,
//                 child: Text('Bienvenid@',style: MasterStyles().stylePrimary(
//                     size: sizeH * 0.05,color: Colors.black,fontWeight: FontWeight.bold
//                 ),textAlign: TextAlign.left),
//               ),
//               SizedBox(height: sizeH * 0.01),
//               SizedBox(
//                 width: sizeW,
//                 child: Text('Verificación de usuario',style: MasterStyles().stylePrimary(
//                   size: sizeH * 0.03,color: Colors.black,
//                 ),textAlign: TextAlign.left),
//               ),
//               SizedBox(height: sizeH * 0.03),
//               SizedBox(
//                 width: sizeW,
//                 child: Text('Usuario :',style: MasterStyles().stylePrimary(
//                     size: sizeH * 0.025,color: Colors.black
//                 ),textAlign: TextAlign.left),
//               ),
//               SizedBox(height: sizeH * 0.01),
//               SizedBox(
//                 width: sizeW,
//                 height: sizeH * 0.06,
//                 child: TextFieldGeneral(
//                   textEditingController: loginProvider.controllerUser,
//                   colorBack: Colors.transparent,
//                   borderColor: Colors.black,
//                   activeInputBorder: false,
//                   textInputType: TextInputType.name,
//                   labelStyle: MasterStyles().stylePrimary(
//                       size: sizeH * 0.025,color: Colors.grey
//                   ),
//                   suffixIcon: InkWell(
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
//                       child: Icon(Icons.person,
//                           size: sizeH * 0.025,color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: sizeH * 0.02),
//               SizedBox(
//                 width: sizeW,
//                 child: Text('Contraseña :',style: MasterStyles().stylePrimary(
//                     size: sizeH * 0.025,color: Colors.black
//                 ),textAlign: TextAlign.left),
//               ),
//               SizedBox(height: sizeH * 0.01),
//               SizedBox(
//                 width: sizeW,
//                 height: sizeH * 0.06,
//                 child: TextFieldGeneral(
//                   textEditingController: loginProvider.controllerPass,
//                   colorBack: Colors.transparent,
//                   borderColor: Colors.black,
//                   activeInputBorder: false,
//                   textInputType: TextInputType.name,
//                   labelStyle: MasterStyles().stylePrimary(
//                       size: sizeH * 0.025,color: Colors.grey
//                   ),
//                   hintText: 'Contraseña',
//                   obscure: loginProvider.obscureButton,
//                   padding: const EdgeInsets.all(0.0),
//                   suffixIcon: InkWell(
//                     onTap: (){ loginProvider.obscureButton = !loginProvider.obscureButton; },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
//                       child: Icon(loginProvider.obscureButton ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
//                           size: sizeH * 0.025,color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: sizeH * 0.06),
//               Expanded(child: Container()),
//               ButtonGeneral(
//                 title: 'Continuar',
//                 textStyle: MasterStyles().stylePrimary(
//                     size: sizeH * 0.025,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold
//                 ),
//                 height: sizeH * 0.08,
//                 backgroundColor: Colors.black,
//                 radius: 5,
//                 // gradient: const LinearGradient(
//                 //   colors: <Color>[MasterColors.primary,MasterColors.primary, MasterColors.primary2],
//                 //   begin: Alignment.topLeft,
//                 //   end: Alignment.bottomRight,
//                 // ),
//                 onPressed: () async {
//
//                   String textError = '';
//                   if(loginProvider.controllerUser.text.isEmpty){
//                     textError = 'Campo usuario es requerido';
//                   }
//                   if(loginProvider.controllerUser.text.isEmpty){
//                     textError = 'Campo contrasena es requerido';
//                   }
//
//                   if(textError.isEmpty){
//                     bool isLoggedIn = await loginProvider.loginUser();
//                     if (isLoggedIn) {
//                       showAlert(text: 'Inicio de sesión exitoso');
//                       SharedPreferencesLocal.masterLogin = 1;
//                       Provider.of<SplashProvider>(context,listen: false).initSplash();
//                     } else {
//                       showAlert(text: 'Inicio de sesión fallido',isError: true);
//                     }
//                   }else{
//                     showAlert(text: textError,isError: true);
//                   }
//                 },
//               ),
//               SizedBox(height: sizeH * 0.05),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget iconApp(){
//     return Container(
//       width: sizeH * 0.06,
//       height: sizeH * 0.06,
//       alignment: Alignment.centerLeft,
//       decoration: BoxDecoration(
//         color: Colors.red,
//         image: DecorationImage(
//           image: Image.asset('assets/img/dni.png').image,
//           fit: BoxFit.contain
//         )
//       ),
//     );
//   }
// }
