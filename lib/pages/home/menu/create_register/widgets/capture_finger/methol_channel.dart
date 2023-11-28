import 'dart:async';
import 'package:flutter/services.dart';


class AndroidChannel {
  static const String channelName = 'metolChannel';

  static const MethodChannel _channel = MethodChannel(channelName);

  static Future<Map<dynamic, dynamic>> startScan() async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod('startScan');
    print(result);
    return result;
  }
}