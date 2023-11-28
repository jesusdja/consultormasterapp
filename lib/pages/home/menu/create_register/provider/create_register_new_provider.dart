import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CreateRegisterNewProvider extends ChangeNotifier {

  CreateRegisterNewProvider(){
    initialData();
  }

  bool _loadData = true;
  bool get loadData => _loadData;
  set loadData( bool value ){ _loadData = value; notifyListeners(); }

  bool _takingFirstPhoto = true;
  bool get takingFirstPhoto => _takingFirstPhoto;
  set takingFirstPhoto( bool value ){ _takingFirstPhoto = value; notifyListeners(); }

  bool _captureFinish = false;
  bool get captureFinish => _captureFinish;
  set captureFinish( bool value ){ _captureFinish = value; notifyListeners(); }

  bool _captureFinishContinue = false;
  bool get captureFinishContinue => _captureFinishContinue;
  set captureFinishContinue( bool value ){ _captureFinishContinue = value; notifyListeners(); }

  bool _captureImage = false;
  bool get captureImage => _captureImage;
  set captureImage( bool value ){ _captureImage = value; notifyListeners(); }

  bool _captureFinger = false;
  bool get captureFinger => _captureFinger;
  set captureFinger( bool value ){ _captureFinger = value; notifyListeners(); }

  Position? _location;
  Position? get location => _location;
  set location( Position? value ){ _location = value; notifyListeners(); }

  bool _loadPosition = false;
  bool get loadPosition => _loadPosition;
  set loadPosition( bool value ){ _loadPosition = value; notifyListeners(); }

  CameraController? cameraController;
  final textRecognizer = TextRecognizer();

  List<String> resultsFirstPhoto = [];
  List<String> resultsSecondPhoto = [];
  File? capturedImage1;
  File? capturedImage2;
  String resultText = '';
  Map<String,String> resultMap = {};

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerDoc = TextEditingController();
  TextEditingController controllerComments = TextEditingController();

  Uint8List? _imgBytesList;
  Uint8List? get imgBytesList => _imgBytesList;
  set imgBytesList( Uint8List? value ){ _imgBytesList = value; notifyListeners(); }

  List<PlatformFile> _paths = [];
  List<PlatformFile> get paths => _paths;
  set paths( List<PlatformFile> value ){ _paths = value; notifyListeners(); }

  Future initialData() async {
    loadData = true;
    takingFirstPhoto = true;
    captureFinish = false;
    cameraController = null;

    resultsFirstPhoto = [];
    resultsSecondPhoto = [];
    capturedImage1 = null;
    capturedImage2 = null;
    resultText = '';
    resultMap = {};

    notifyListeners();
  }

  Future initialData2() async {

    controllerName = TextEditingController(text: resultMap['nNombres']);
    controllerLastName = TextEditingController(text: resultMap['nApellidos']);
    controllerDoc = TextEditingController(text: resultMap['NUIP']!.replaceAll('[', '').replaceAll(']', ''));
    controllerComments = TextEditingController();
    imgBytesList = null;
    location = null;

    determinePosition();

    notifyListeners();

  }

  Future initCameraController() async {
    List<CameraDescription> cameras = await availableCameras();
    if (cameraController != null) {
      cameraController = null; notifyListeners();
    }

    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );

      await cameraController!.initialize();
      await cameraController!.setFlashMode(FlashMode.off);
      loadData = false;
      notifyListeners();
    }
  }

  Future<void> takePhoto() async {
    captureImage = true;
    if (cameraController == null) return;

    final pictureFile = await cameraController!.takePicture();
    final file = File(pictureFile.path);
    final inputImage = InputImage.fromFile(file);
    final recognizedText = await textRecognizer.processImage(inputImage);

    if (takingFirstPhoto) {
      resultsFirstPhoto.add(recognizedText.text);
      takingFirstPhoto = false;
      capturedImage1 = file;
      captureImage = false;// Almacena la primera imagen capturada
      notifyListeners();
    } else {
      resultsSecondPhoto.add(recognizedText.text);
      takingFirstPhoto = true; // Switch back to the first photo mode
      capturedImage2 = file;
      captureImage = false;
      notifyListeners();// Almacena la segunda imagen capturada
      showResults(); // Show the results
    }
  }

  void showResults() {
    captureFinish = true; notifyListeners();

    // Combining the results from both photos
    final combinedResults = '${resultsFirstPhoto.join("\n")}\n\n${resultsSecondPhoto.join("\n")}';

    // Extracting NUIP, Apellidos, and Nombres from combinedResults
    final nuipMatches = RegExp(r'NUIP (\d+\.\d+\.\d+)').allMatches(combinedResults);

    // Extracting Apellidos from combinedResults for both "Apellidos" and "Apelidos"
    final apellidosMatches1 = RegExp(r'Apellidos\n(.+)').firstMatch(combinedResults);
    final apellidosMatches2 = RegExp(r'Apelidos\n(.+)').firstMatch(combinedResults);

    final nombresMatches = RegExp(r'Nombres\n(.+)').firstMatch(combinedResults);

    final nuipNumbers = nuipMatches.map((match) => match.group(1)).toList();
    final apellidos1 = apellidosMatches1?.group(1) ?? '';
    final apellidos2 = apellidosMatches2?.group(1) ?? '';
    final nombres = nombresMatches?.group(1) ?? '';

    // Combine both "Apellidos" and "Apelidos" into a single variable
    final apellidos = '$apellidos1 $apellidos2';

    // Construct the result text without enclosing [ ]
    resultMap['NUIP'] = '$nuipNumbers';
    resultMap['nApellidos'] = apellidos;
    resultMap['nNombres'] = nombres;
    resultText = 'NUIP:\n${nuipNumbers.join("\n")}\n\nApellidos:\n$apellidos\n\nNombres:\n$nombres';
    notifyListeners();
  }

  Future determinePosition() async {
    location = null;
    try{
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      location = await Geolocator.getCurrentPosition();
      notifyListeners();
    }catch(e){
      debugPrint(e.toString());
    }
    if(location == null){
      determinePosition();
    }
  }



}