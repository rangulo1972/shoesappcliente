import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoesappclient/models/user_model.dart';
import 'package:shoesappclient/services/local/sp_global.dart';
import 'package:shoesappclient/services/remote/firestore_service.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/pages/init_page.dart';
import 'package:shoesappclient/ui/widgets/common_button_widget.dart';
import 'package:shoesappclient/ui/widgets/common_input_widget.dart';
import 'package:shoesappclient/ui/widgets/common_password_widget.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/responsive.dart';
import 'package:shoesappclient/utils/types.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameContoller = TextEditingController();

  final TextEditingController _phoneContoller = TextEditingController();

  final TextEditingController _mailContoller = TextEditingController();

  final TextEditingController _passwordContoller = TextEditingController();

  FirestoreService firestoreService = FirestoreService();

  final _registerFormKey = GlobalKey<FormState>();

  bool isLoading = false;

  registerUser() async {
    if (_registerFormKey.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _mailContoller.text,
          password: _passwordContoller.text,
        );
        if (userCredential.user != null) {
          UserModel model = UserModel(
            email: _mailContoller.text,
            name: _nameContoller.text,
            phone: _phoneContoller.text,
            role: "client",
          );
          String value = await firestoreService.registerUser(model);
          if (value.isNotEmpty) {
            SPGlobal().name = _nameContoller.text;
            SPGlobal().isLogin = true;
            isLoading = false;

            setState(() {});
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InitPage(),
              ),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        setState(() {});
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarError("Contraseña débil, debe tener mínimo 6 caracteres"),
          );
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarError("Email ya registrado, ingrese otro email"),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //!Background
          backgroundWidget(context),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _registerFormKey,
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
                      H4(text: "Regístrate"),
                      // spacing4Height,
                      // H5(
                      //   text: "Ingresa tus credenciales",
                      //   color: BrandColor.primaryFontColor.withOpacity(0.8),
                      // ),
                      spacing20Height,
                      CommonInputWidget(
                        label: "Nombres Completos",
                        hintText: "Ingresa tus nombres completos",
                        icon: AssetData.iconUser,
                        controller: _nameContoller,
                        inputType: InputTypeEnum.text,
                      ),
                      spacing20Height,
                      CommonInputWidget(
                        label: "Teléfono",
                        hintText: "Ingresa tu número de teléfono",
                        icon: AssetData.iconPhone,
                        controller: _phoneContoller,
                        inputType: InputTypeEnum.phone,
                      ),
                      spacing20Height,
                      CommonInputWidget(
                        label: "Correo Electrónico",
                        hintText: "Ingresa tu correo electrónico",
                        icon: AssetData.iconMail,
                        controller: _mailContoller,
                        inputType: InputTypeEnum.email,
                      ),
                      spacing20Height,
                      CommonPasswordWidget(controller: _passwordContoller),
                      spacing30Height,
                      CommonButtonWidget(
                        color: BrandColor.secondaryColor,
                        text: "Regístrate",
                        onPressed: () {
                          registerUser();
                        },
                      ),
                      spacing16Height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          H5(
                            text: "Ya tienes una cuenta?",
                            color:
                                BrandColor.primaryFontColor.withOpacity(0.70),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: H5(
                              text: "  Inicia Sesión",
                              fontWeight: FontWeight.w700,
                              color: BrandColor.secondaryColor,
                            ),
                          ),
                        ],
                      ),

                      //CommonButtonSocialWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading
              ? Container(
                  color: Colors.white70,
                  child: loadingWidget,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
