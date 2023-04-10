import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoesappclient/models/user_model.dart';
import 'package:shoesappclient/services/local/sp_global.dart';
import 'package:shoesappclient/services/remote/firestore_service.dart';

import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/pages/init_page.dart';
import 'package:shoesappclient/ui/pages/register_page.dart';

import 'package:shoesappclient/ui/widgets/common_button_widget.dart';
import 'package:shoesappclient/ui/widgets/common_input_widget.dart';
import 'package:shoesappclient/ui/widgets/common_password_widget.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/responsive.dart';
import 'package:shoesappclient/utils/types.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  FirestoreService firestoreService = FirestoreService();

  final _loginFormKey = GlobalKey<FormState>();

  bool isLoading = false;

  login() async {
    if (_loginFormKey.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        //? para comprobar lo que nos está devolviendo el server
        //print(userCredential);
        //?----------------------------------------------------
        if (userCredential.user != null) {
          UserModel? userModel =
              await firestoreService.getUser(_emailController.text);
          //? para comprobar lo que nos está devolviendo el server
          //print(userModel!.toJson());
          //?----------------------------------------------------
          if (userModel != null) {
            SPGlobal().name = userModel.name;
            SPGlobal().mail = userModel.email;
            SPGlobal().phone = userModel.phone;
            SPGlobal().isLogin = true;
            isLoading = false;
            setState(() {});
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const InitPage(),
                ),
                (route) => false);
            //**------------------------------------- */
            // ignore: use_build_context_synchronously
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => InitPage(),
            //   ),
            // );
            //**------------------------------------ */
          }
        }
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        setState(() {});
        if (e.code == "wrong-password") {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarError("La contraseña ingresada es incorrecta"),
          );
        } else if (e.code == "user-not-found") {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarError("Email no registrado"),
          );
        }
      }
    }
  }

  loginWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ["email"]);
    GoogleSignInAccount? googleSingInAccount = await googleSignIn.signIn();
    //? para comprobar lo que nos está devolviendo el server
    //print(googleSingInAccount);
    //?----------------------------------------------------
    //! para hacer el Sign Out
    //googleSignIn.signOut();
    //!---------------------
    if (googleSingInAccount == null) {
      return;
    }
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSingInAccount.authentication;

    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      UserModel? userModel =
          await firestoreService.getUser(userCredential.user!.email!);
      if (userModel == null) {
        UserModel model = UserModel(
          email: userCredential.user!.email!,
          name: userCredential.user!.displayName!,
          phone: "",
          role: "client",
        );
        String value = await firestoreService.registerUser(model);
        if (value.isNotEmpty) {
          SPGlobal().name = userCredential.user!.displayName!;
          SPGlobal().mail = userCredential.user!.email!;
          SPGlobal().phone = "";
          SPGlobal().isLogin = true;
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const InitPage(),
              ),
              (route) => false);
          //**------------------------------------ */
          // ignore: use_build_context_synchronously
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => InitPage(),
          //   ),
          // );
          //**------------------------------------ */
        }
      } else {
        //sharedPreferences
        SPGlobal().name = userModel.name;
        SPGlobal().mail = userModel.email;
        SPGlobal().phone = userModel.phone;
        SPGlobal().isLogin = true;
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const InitPage(),
            ),
            (route) => false);
        //**-------------------------------------------- */
        // ignore: use_build_context_synchronously
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => InitPage(),
        //   ),
        // );
        //**-------------------------------------------- */
      }
    }
  }

  loginWithFaceBook() async {
    LoginResult loginResult = await FacebookAuth.instance.login();
    //?--------------------------
    //FacebookAuth.instance.logOut(); //! para salir del log in
    //?---------------------------
    if (loginResult.status == LoginStatus.success) {
      //Map<String, dynamic> userData = await FacebookAuth.instance.getUserData();
      AccessToken? accessToken = loginResult.accessToken;
      OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken!.token);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        UserModel? userModel =
            await firestoreService.getUser(userCredential.user!.email!);
        if (userModel == null) {
          UserModel model = UserModel(
            email: userCredential.user!.email!,
            name: userCredential.user!.displayName!,
            phone: "",
            role: "client",
          );
          String value = await firestoreService.registerUser(model);
          if (value.isNotEmpty) {
            SPGlobal().name = userCredential.user!.displayName!;
            SPGlobal().mail = userCredential.user!.email!;
            SPGlobal().phone = "";
            SPGlobal().isLogin = true;
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const InitPage(),
                ),
                (route) => false);

            //**---------------------------------------- */
            // ignore: use_build_context_synchronously
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => InitPage(),
            //   ),
            // );
            //**---------------------------------------- */
          }
        } else {
          SPGlobal().name = userModel.name;
          SPGlobal().mail = userModel.email;
          SPGlobal().phone = userModel.phone;
          SPGlobal().isLogin = true;
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const InitPage(),
              ),
              (route) => false);
          //**------------------------------------------- */
          // ignore: use_build_context_synchronously
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => InitPage(),
          //   ),
          // );
          //**------------------------------------------ */
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
          //!Formulario
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _loginFormKey,
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
                      H4(text: "Iniciar Sesión"),
                      // spacing4Height,
                      // H5(
                      //   text: "Ingresa tus credenciales",
                      //   color: BrandColor.primaryFontColor.withOpacity(0.8),
                      // ),
                      spacing20Height,
                      CommonInputWidget(
                        label: "Correo Electrónico",
                        hintText: "Tu correo electónico",
                        icon: AssetData.iconMail,
                        controller: _emailController,
                        inputType: InputTypeEnum.email,
                      ),
                      spacing20Height,
                      CommonPasswordWidget(
                        controller: _passwordController,
                      ),
                      spacing30Height,
                      CommonButtonWidget(
                        color: BrandColor.secondaryColor,
                        text: "Iniciar Sesión",
                        onPressed: () {
                          login();
                        },
                      ),
                      spacing16Height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          H5(
                            text: "Aún no tienes una cuenta?",
                            color:
                                BrandColor.primaryFontColor.withOpacity(0.70),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: H5(
                              text: "  Regístrate",
                              fontWeight: FontWeight.w700,
                              color: BrandColor.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      spacing30Height,
                      CommonButtonWidget(
                        text: "Iniciar Sesión con Google",
                        color: const Color(0xffEA4335),
                        icon: AssetData.iconGoogle,
                        onPressed: () {
                          loginWithGoogle();
                        },
                      ),
                      spacing20Height,
                      CommonButtonWidget(
                        text: "Iniciar Sesión con FaceBook",
                        color: const Color(0xff0A82ED),
                        icon: AssetData.iconFaceBook,
                        onPressed: () {
                          loginWithFaceBook();
                        },
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
