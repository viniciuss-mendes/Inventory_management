import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import'package:lps_app/pages/pagina_login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey[200],
    ),
    home: PaginaLogin(),
  ));
}

