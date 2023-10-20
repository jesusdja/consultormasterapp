import 'dart:developer';

import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/pages/splash/providers/splash_provider.dart';
import 'package:consultormasterapp/widgets_utils/circular_progress_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:consultormasterapp/pages/home/home_page.dart';
import 'package:consultormasterapp/pages/login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    sizeH = MediaQuery.of(context).size.height;
    sizeW = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<SplashProvider>(context);

    log('splashStatus : ${authProvider.splashStatus}');

    if( authProvider.splashStatus == SplashStatus.login ) {
      return const LoginPage();
    }
    if( authProvider.splashStatus == SplashStatus.home ) {
      return const HomePage();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: sizeW,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            circularProgressColors(widthContainer1: sizeW,widthContainer2: sizeW * 0.1),
          ],
        ),
      ),
    );
  }
}
