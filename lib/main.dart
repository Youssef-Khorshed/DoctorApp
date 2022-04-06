import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'MyApp/data.dart';
import 'MyApp/myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Data.data();
  runApp(DevicePreview(builder: (context) => MyApp()));
}
