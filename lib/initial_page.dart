import 'package:consultormasterapp/global/providers/connectivity_provider.dart';
import 'package:consultormasterapp/pages/home/home_page.dart';
import 'package:consultormasterapp/pages/login/login_page.dart';
import 'package:consultormasterapp/pages/splash/providers/splash_provider.dart';
import 'package:consultormasterapp/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

double sizeH = 0;
double sizeW = 0;
late BuildContext contextHome;

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<ConnectivityProvider>(context,listen: false).dispose();
  }

  @override
  Widget build(BuildContext context) {

    sizeH = MediaQuery.of(context).size.height;
    sizeW = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<SplashProvider>(context);
    contextHome = context;

    Widget body = const SplashPage();

    if( authProvider.splashStatus == SplashStatus.login ) {
      body = const LoginPage();
    }
    if( authProvider.splashStatus == SplashStatus.home ) {
      body = const HomePage();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: body,
    );
  }
}
