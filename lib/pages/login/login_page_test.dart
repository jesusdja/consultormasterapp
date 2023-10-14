// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
//
// import 'package:consultormasterapp/initial_page.dart';
// import 'package:consultormasterapp/widgets_utils/button_general.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
//
// import 'package:barcode_scanner/barcode_scanning_data.dart';
// import 'package:barcode_scanner/json/common_data.dart';
// import 'package:barcode_scanner/scanbot_barcode_sdk.dart';
// import 'package:barcode_scanner/scanbot_sdk_models.dart';
//
//
// bool shouldInitWithEncryption = false;
//
// const BARCODE_SDK_LICENSE_KEY = "";
//
// _initScanbotSdk() async {
//   Directory? storageDirectory;
//   if (Platform.isAndroid) {
//     storageDirectory = await getExternalStorageDirectory();
//   }
//   if (Platform.isIOS) {
//     storageDirectory = await getApplicationDocumentsDirectory();
//   }
//   EncryptionParameters? encryptionParameters;
//   if (shouldInitWithEncryption) {
//     encryptionParameters = EncryptionParameters(
//         password: "password", mode: FileEncryptionMode.AES256);
//   }
//   var config = ScanbotSdkConfig(
//       licenseKey: BARCODE_SDK_LICENSE_KEY,
//       encryptionParameters: encryptionParameters,
//       loggingEnabled: true,
//       // Consider disabling logging in production builds for security and performance reasons.
//       storageBaseDirectory:
//       "${storageDirectory?.path}/custom-barcode-sdk-storage");
//
//   try {
//     config.useCameraX = true;
//     await ScanbotBarcodeSdk.initScanbotSdk(config);
//   } catch (e) {
//     print(e);
//   }
// }
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
//   @override
//   void initState() {
//     _initScanbotSdk();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MainPageWidget();
//   }
// }
//
// class MainPageWidget extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPageWidget> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text('Barcode SDK Flutter Example App',
//             style: TextStyle(inherit: true, color: Colors.black)),
//       ),
//       body: ListView(
//         children: <Widget>[
//           SizedBox(height: sizeH * 0.05,),
//           ButtonGeneral(
//             title: "Scan Barcode",
//               onPressed: () {
//                 startBarcodeScanner();
//               },
//           ),
//         ],
//       ),
//     );
//   }
//
//   startBatchBarcodeScanner() async {
//     if (!await checkLicenseStatus(context)) {
//       return;
//     }
//     try {
//       final additionalParameters = BarcodeAdditionalParameters(
//           minimumTextLength: 3,
//           maximumTextLength: 45,
//           minimum1DBarcodesQuietZone: 10,
//           codeDensity: CodeDensity.HIGH);
//       var config = BatchBarcodeScannerConfiguration(
//         barcodeFormatter: (item) async {
//           Random random = Random();
//           int randomNumber = random.nextInt(4) + 2;
//           await Future.delayed(Duration(seconds: randomNumber));
//           return BarcodeFormattedData(
//               title: item.barcodeFormat.toString(),
//               subtitle: item.text ?? "" "custom string");
//         },
//         topBarBackgroundColor: Colors.blueAccent,
//         topBarButtonsColor: Colors.white70,
//         cameraOverlayColor: Colors.black26,
//         finderLineColor: Colors.red,
//         finderTextHintColor: Colors.cyanAccent,
//         cancelButtonTitle: "Cancel",
//         enableCameraButtonTitle: "camera enable",
//         enableCameraExplanationText: "explanation text",
//         finderTextHint:
//         "Please align any supported barcode in the frame to scan it.",
//         // clearButtonTitle: "CCCClear",
//         // submitButtonTitle: "Submitt",
//         barcodesCountText: "%d codes",
//         fetchingStateText: "might be not needed",
//         noBarcodesTitle: "nothing to see here",
//         barcodesCountTextColor: Colors.purple,
//         finderAspectRatio: const FinderAspectRatio(width: 2, height: 1),
//         topBarButtonsInactiveColor: Colors.orange,
//         detailsActionColor: Colors.yellow,
//         detailsBackgroundColor: Colors.amber,
//         detailsPrimaryColor: Colors.yellowAccent,
//         finderLineWidth: 7,
//         successBeepEnabled: true,
//         // flashEnabled: true,
//         orientationLockMode: OrientationLockMode.NONE,
//         // cameraZoomFactor: 1,
//         additionalParameters: additionalParameters,
//         cancelButtonHidden: false,
//         overlayConfiguration: SelectionOverlayConfiguration(
//             overlayEnabled: true,
//             automaticSelectionEnabled: true
//         ),
//         //useButtonsAllCaps: true
//       );
//
//       var result = await ScanbotBarcodeSdk.startBatchBarcodeScanner(config);
//       print(result);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   startBarcodeScanner({bool shouldSnapImage = false}) async {
//     if (!await checkLicenseStatus(context)) {
//       return;
//     }
//     final additionalParameters = BarcodeAdditionalParameters(
//       minimumTextLength: 3,
//       maximumTextLength: 45,
//       minimum1DBarcodesQuietZone: 10,
//       codeDensity: CodeDensity.HIGH,
//     );
//     var config = BarcodeScannerConfiguration(
//       barcodeImageGenerationType: shouldSnapImage
//           ? BarcodeImageGenerationType.VIDEO_FRAME
//           : BarcodeImageGenerationType.NONE,
//       topBarBackgroundColor: Colors.blueAccent,
//       finderLineColor: Colors.red,
//       cancelButtonTitle: "Cancel",
//       finderTextHint:
//       "Please align any supported barcode in the frame to scan it.",
//       successBeepEnabled: true,
//
//       // cameraZoomFactor: 1,
//       additionalParameters: additionalParameters,
//       // see further customization configs ...
//       orientationLockMode: OrientationLockMode.NONE,
//       //useButtonsAllCaps: true,
//     );
//
//     try {
//       var result = await ScanbotBarcodeSdk.startBarcodeScanner(config);
//
//       print(result);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   cleanupStorage() async {
//     try {
//       await ScanbotBarcodeSdk.cleanupBarcodeStorage();
//       showAlertDialog(context, "Barcode image storage was cleaned",
//           title: "Info");
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   showLicenseStatus() async {
//     try {
//       var result = await ScanbotBarcodeSdk.getLicenseStatus();
//       showAlertDialog(context, jsonEncode(result), title: "License Status");
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<bool> checkLicenseStatus(BuildContext context) async {
//     var result = await ScanbotBarcodeSdk.getLicenseStatus();
//     if (result.isLicenseValid) {
//       return true;
//     }
//     await showAlertDialog(
//         context, 'Scanbot SDK trial period or (trial) license has expired.',
//         title: 'Info');
//     return false;
//   }
// }
//
// Future<void> showAlertDialog(BuildContext context, String textToShow,
//     {String? title}) async {
//   Widget text = SimpleDialogOption(
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Text(textToShow),
//     ),
//   );
//
//   // set up the SimpleDialog
//   AlertDialog dialog = AlertDialog(
//     title: title != null ? Text(title) : null,
//     content: text,
//     contentPadding: const EdgeInsets.all(0),
//     actions: <Widget>[
//       TextButton(
//         child: const Text('OK'),
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//       ),
//     ],
//   );
//
//   // show the dialog
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return dialog;
//     },
//   );
// }