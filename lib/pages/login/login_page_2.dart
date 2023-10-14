import 'package:consultormasterapp/config/master_colors.dart';
import 'package:consultormasterapp/config/master_style.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/pages/login/provider/login_provider.dart';
import 'package:consultormasterapp/pages/splash/providers/splash_provider.dart';
import 'package:consultormasterapp/services/shared_preferences_static.dart';
import 'package:consultormasterapp/widgets_utils/button_general.dart';
import 'package:consultormasterapp/widgets_utils/textfield_general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context1) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (context, provider, child){

          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child: Container()),
                      ClipPath(
                        clipper: _HeaderPaintDiagonal(),
                        child: Container(
                          height: 180,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[MasterColors.primary, MasterColors.primary2],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: SizedBox(
                  //     child: ,
                  //   ),
                  // ),
                  formLogin(provider: provider),
                ],
              ),
            ),
          );
        }
      )
    );
  }

  Widget formLogin({required LoginProvider provider}){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: sizeH * 0.4),
          Container(
            width: sizeW,
            margin: EdgeInsets.only(right: sizeW * 0.2,left: sizeW * 0.05),
            child: Row(
              children: [
                Expanded(
                  child: Text('USER :',style: MasterStyles().styleKalam(
                      size: sizeH * 0.02,color: MasterColors.primary4
                  ),textAlign: TextAlign.right),
                ),
                SizedBox(
                  width: sizeW * 0.5,
                  child: Column(
                    children: [
                      SizedBox(
                        width: sizeW,
                        height: sizeH * 0.03,
                        child: TextFieldGeneral(
                          textEditingController: provider.controllerUser,
                          colorBack: Colors.transparent,
                          borderColor: Colors.transparent,
                          activeInputBorder: false,
                          textInputType: TextInputType.name,
                          labelStyle: MasterStyles().stylePrimary(
                              size: sizeH * 0.02,color: Colors.grey
                          ),
                          padding: const EdgeInsets.all(0.0),
                          suffixIcon: InkWell(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
                              child: Icon(Icons.person,
                                  size: sizeH * 0.025,color: MasterColors.primary4),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        width: sizeW,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: sizeH * 0.03),
          Container(
            width: sizeW,
            margin: EdgeInsets.only(right: sizeW * 0.2,left: sizeW * 0.05),
            child: Row(
              children: [
                Expanded(
                  child: Text('PASSWORD :',style: MasterStyles().styleKalam(
                      size: sizeH * 0.02,color: MasterColors.primary4
                  ),textAlign: TextAlign.right),
                ),
                SizedBox(
                  width: sizeW * 0.5,
                  child: Column(
                    children: [
                      SizedBox(
                        width: sizeW,
                        height: sizeH * 0.03,
                        child: TextFieldGeneral(
                          textEditingController: provider.controllerPass,
                          colorBack: Colors.transparent,
                          borderColor: Colors.transparent,
                          activeInputBorder: false,
                          textInputType: TextInputType.name,
                          labelStyle: MasterStyles().stylePrimary(
                              size: sizeH * 0.02,color: Colors.grey
                          ),
                          hintText: '***********',
                          obscure: provider.obscureButton,
                          padding: const EdgeInsets.all(0.0),
                          suffixIcon: InkWell(
                            onTap: (){ provider.obscureButton = !provider.obscureButton; },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
                              child: Icon(provider.obscureButton ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                                  size: sizeH * 0.025,color: MasterColors.primary4),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        width: sizeW,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: sizeH * 0.06),
          // MaterialButton(
          //   height: 200,
          //   color: Colors.blue,
          //   onPressed: (){},
          // ),
          ButtonGeneral(
            title: 'SIGN IN',
            textStyle: MasterStyles().stylePrimary(
                size: sizeH * 0.022,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
            margin: EdgeInsets.symmetric(horizontal: sizeW * 0.2),
            height: sizeH * 0.05,
            backgroundColor: Colors.blue,
            radius: 20,
            gradient: const LinearGradient(
              colors: <Color>[MasterColors.primary,MasterColors.primary, MasterColors.primary2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onPressed: () async {
              SharedPreferencesLocal.masterLogin = 1;
              Provider.of<SplashProvider>(context,listen: false).initSplash();
            },
          )
        ],
      ),
    );
  }
}

class _HeaderPaintDiagonal extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double offset = 30;
    Path path = Path();
    path.moveTo(0, sizeH-(sizeH-offset));
    path.lineTo(0, sizeH);
    path.lineTo(sizeW, sizeH);
    path.lineTo(sizeW, sizeH-(sizeH-offset));
    path.quadraticBezierTo(3*sizeW/4,0,sizeW/2,sizeH-(sizeH-offset));
    path.quadraticBezierTo(sizeW/4,2*offset,0, sizeH-(sizeH-offset));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}

// class _HeaderPaintDiagonal2 extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue[300]!
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 10;
//
//     final path = Path();
//     path.lineTo(0, size.height * 0.30);
//     path.quadraticBezierTo(size.width * 0.25, size.height * 0.35,size.width * 0.5, size.height * 0.30);
//     path.quadraticBezierTo(size.width * 0.75,size.height * 0.22,size.width, size.height *0.25);
//     path.lineTo(size.width, 0);
//     canvas.drawPath(path, paint);
//   }
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
