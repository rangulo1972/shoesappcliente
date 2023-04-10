import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesappclient/services/local/sp_global.dart';
import 'package:shoesappclient/ui/pages/init_page.dart';
import 'package:shoesappclient/ui/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //**--- Para el Shared Preferences */
  SPGlobal prefs = SPGlobal();
  await prefs.initSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShoesApp',
      theme: ThemeData(
        textTheme: GoogleFonts.manropeTextTheme(),
      ),
      home: PreInit(),
    );
  }
}

//! creamos la clase PreInit para poder realizar el llamado de las páginas según
//! lo que se tenga almacenado en el Shared Preference

class PreInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //! con el operador ternrio consultamos si isLoging es true, para que elegir
    //! a qué págian se debe de ingresar
    return SPGlobal().isLogin ? const InitPage() : LoginPage();
  }
}
