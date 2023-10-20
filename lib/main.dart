import 'package:consultormasterapp/global/providers/connectivity_provider.dart';
import 'package:consultormasterapp/global/send_data_background_provider.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/pages/home/provider/home_provider.dart';
import 'package:consultormasterapp/pages/login/provider/login_provider.dart';
import 'package:consultormasterapp/pages/splash/providers/splash_provider.dart';
import 'package:consultormasterapp/services/my_sql_connection_static.dart';
import 'package:consultormasterapp/services/shared_preferences_static.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await SharedPreferencesLocal.configurePrefs();
  await MySqlConnectionLocal.configureConnection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consultor master',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(lazy: false,create: ( _ ) => SplashProvider()),
          ChangeNotifierProvider(lazy: false,create: ( _ ) => HomeProvider()),
          ChangeNotifierProvider(lazy: false,create: ( _ ) => ConnectivityProvider()),
          ChangeNotifierProvider(lazy: false,create: ( _ ) => SendDataBackGroundProvider()),
          ChangeNotifierProvider(lazy: false,create: ( _ ) => LoginProvider()),
        ],
        child: const InitialPage(),
      ),
    );
  }
}
