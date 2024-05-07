import 'package:banking_app/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/app.dart';
import 'data/local/storage_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  StorageRepository.instance;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await StorageRepository.init();

  runApp(App());
}