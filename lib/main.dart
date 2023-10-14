import 'package:consultormasterapp/global/providers/connectivity_provider.dart';
import 'package:consultormasterapp/global/send_data_background_provider.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/pages/home/provider/home_provider.dart';
import 'package:consultormasterapp/pages/splash/providers/splash_provider.dart';
import 'package:consultormasterapp/services/shared_preferences_static.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await SharedPreferencesLocal.configurePrefs();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false,create: ( _ ) => SplashProvider()),
        ChangeNotifierProvider(lazy: false,create: ( _ ) => HomeProvider()),
        ChangeNotifierProvider(lazy: false,create: ( _ ) => ConnectivityProvider()),
        ChangeNotifierProvider(lazy: false,create: ( _ ) => SendDataBackGroundProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExpenseWallet',
      home: InitialPage(),
    );
  }
}
