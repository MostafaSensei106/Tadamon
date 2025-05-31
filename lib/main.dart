import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/core/error/error_screen.dart';
import 'package:tadamon/core/routing/app_router.dart';
import 'package:tadamon/core/services/object_box_services/object_box_service.dart';
import 'package:tadamon/features/report_products/logic/services/report_service.dart';
import 'package:tadamon/firebase_options.dart';
import 'package:tadamon/tadamon.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ObjectBoxService.init();

  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.playIntegrity,
  // );

  errorScreen();
  ReportService.initializePreferences();
  runApp(TadamonApp(AppRouter()));
}
