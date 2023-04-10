import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoesappclient/services/local/sp_global.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/pages/login_page.dart';
import 'package:shoesappclient/ui/widgets/common_button_widget.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/responsive.dart';

class ProfilePage extends StatelessWidget {
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ["email"]);
  final String name = SPGlobal().name;
  final String email = SPGlobal().mail;
  final String phone = SPGlobal().phone;

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //!Background
          backgroundWidget(context),
          //!Profile
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: ResponsiveUI.pDiagonal(context, 0.07),
                  ),
                  Image.asset(
                    AssetData.iconLogo,
                    height: 52,
                  ),
                  H1(text: "ShoesApp"),
                  spacing8Height,
                  H4(text: "Perfil Usuario"),
                  spacing40Heigth,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      H5(text: "Nombre del Usuario:"),
                      H4(text: name),
                      spacing6Height,
                      H5(text: "Email del Usuario:"),
                      H4(text: email),
                      spacing6Height,
                      H5(text: "Teléfono del Usuario:"),
                      H4(
                          text: phone.isNotEmpty
                              ? phone
                              : "Registrado con Redes Sociales"),
                      spacing6Height,
                      H5(text: "Rol del Usuario:"),
                      H4(text: "Cliente"),
                      spacing6Height,
                    ],
                  ),
                  spacing40Heigth,
                  CommonButtonWidget(
                    text: "Cerrar Sesión",
                    color: BrandColor.secondaryColor,
                    onPressed: () {
                      //! Limpiamos todos los datos almacenados en SPGlobal
                      SPGlobal().isLogin = false;
                      SPGlobal().name = "";
                      SPGlobal().mail = "";
                      SPGlobal().phone = "";
                      //! Ejecutamos las salidas del ingresado realizado por
                      //! redes sociales
                      FacebookAuth.instance.logOut();
                      googleSignIn.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                          (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
