
import 'package:hive_flutter/hive_flutter.dart';

class XCBoxes {
  static late Box authBox;
  static late Box settingsBox;
  static late Box deviceInfoBox;
  static late Box<String> simBox;

  Future<void> initBoxes() async {
      await Hive.initFlutter();
      authBox = await Hive.openBox('auth');
      settingsBox = await Hive.openBox('settings');
      deviceInfoBox = await Hive.openBox('device-info');
      simBox = await Hive.openBox<String>('sim-cards');
      
  }
}