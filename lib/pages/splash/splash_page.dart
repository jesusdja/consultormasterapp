import 'package:consultormasterapp/config/master_colors.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/widgets_utils/circular_progress_colors.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          circularProgressColors(
            colorCircular: MasterColors.primary,
            widthContainer1: sizeW,
            widthContainer2: sizeW * 0.08
          ),
        ],
      ),
    );
  }
}
