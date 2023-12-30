import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tej_mart/Features/init_screen.dart';
import 'package:tej_mart/Features/sign_up.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tej_mart/constants/images_link.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:tej_mart/services/auth_service.dart';
import 'package:tej_mart/widgets/auth_custom_button.dart';
import 'package:tej_mart/widgets/custom_button.dart';
import 'package:tej_mart/widgets/cutsom_textfield.dart';
import 'package:tej_mart/widgets/loader.dart';

class MySignInScreen extends StatefulWidget {
  static const routeName = '/signIn';
  const MySignInScreen({super.key});

  @override
  State<MySignInScreen> createState() => _MySignInScreenState();
}

class _MySignInScreenState extends State<MySignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  bool isSignIn = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signIn() async {
    setState(() {
      isSignIn = true;
    });
    await UserAuthService().signInUser(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
    setState(() {
      isSignIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(signin_back),
                    fit: BoxFit.cover),
                color: white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 100.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(15),
                  Text(
                    "Welcome back!",
                    style: GoogleFonts.montserrat().copyWith(
                        color: Colors.indigo.shade900,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Gap(40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MyCustomTextField(
                          focusNode: emailNode,
                          textEditingController: _emailController,
                          inputType: TextInputType.emailAddress,
                          hintText: "Enter your email",
                          labelText: "Email",
                          fun: (p0) {
                            FocusScope.of(context).requestFocus(passwordNode);
                          },
                        ),
                        Gap(25),
                        MyCustomTextField(
                          focusNode: passwordNode,
                          textEditingController: _passwordController,
                          hintText: "Enter your password",
                          labelText: "Password",
                          isPassword: true,
                          fun: (p0) {},
                        ),
                        Gap(25),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              signIn();
                            }
                          },
                          child: MyAuthCustomButton(
                              color: blue,
                              widget: isSignIn
                                  ? MyLoader(color: white)
                                  : Text(
                                      "Login",
                                      style: textStyle()
                                          .copyWith(color: white, fontSize: 15),
                                    ),
                              textColor: white,
                              borderColor: blue),
                        ),
                        Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.montserrat()
                                  .copyWith(color: black, fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    MySignUpScreen.routeName, (route) => false);
                              },
                              child: Text(
                                " SignUp",
                                style: GoogleFonts.montserrat().copyWith(
                                    color: blue,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                    fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        Gap(50),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
