import 'package:consultormasterapp/global/providers/connectivity_provider.dart';

import 'package:consultormasterapp/pages/splash/splash_page.dart';
import 'package:consultormasterapp/services/my_sql_connection_static.dart';
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
    MySqlConnectionLocal().closet();
    Provider.of<ConnectivityProvider>(context,listen: false).dispose();
  }

  @override
  Widget build(BuildContext context) {

    contextHome = context;

    return const SplashPage();
  }
}
