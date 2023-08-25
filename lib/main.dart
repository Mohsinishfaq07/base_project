import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dependency_container.dart' as di;
import 'myApp.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack, overlays: []);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));

  runApp(const MyApp());
}
