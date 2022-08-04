import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import 'dart:io';
import 'package:platform_device_id/platform_device_id.dart';

class DeviceInformation with ChangeNotifier {
  String _deviceId = '';
  String _devieceName = '';

  String get deviceId {
    return _deviceId;
  }

  String get deviceName {
    return _devieceName;
  }

  Future<void> initPlatformStatesss() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      if (Platform.isAndroid) {
        _devieceName = 'Android';
      } else if (Platform.isIOS) {
        _devieceName = 'ios';
      }
      _deviceId = await PlatformDeviceId.getDeviceId;
      // notifyListeners();
    } on PlatformException {
      _deviceId = 'Failed to get deviceId.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }
}
