import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tej_mart/Features/init_screen.dart';
import 'package:tej_mart/Features/signin.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:tej_mart/services/auth_service.dart';
import 'package:tej_mart/widgets/auth_custom_button.dart';
import 'package:tej_mart/widgets/custom_button.dart';
import 'package:tej_mart/widgets/cutsom_textfield.dart';
import 'package:tej_mart/widgets/loader.dart';

class MySignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  const MySignUpScreen({super.key});

  @override
  State<MySignUpScreen> createState() => _MySignUpScreenState();
}

class _MySignUpScreenState extends State<MySignUpScreen> {
  final _signFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool isSignUp = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signUp() async {
    setState(() {
      isSignUp = true;
    });
    await UserAuthService().signUpUser(
        email: _emailController.text,
        name: _nameController.text,
        password: _passwordController.text,
        context: context);
    setState(() {
      isSignUp = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, MyInitScreen.routeName, (route) => false);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(30),
              Text(
                "Sign Up",
                style: GoogleFonts.montserrat().copyWith(
                    color: blue, fontSize: 27, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.montserrat()
                        .copyWith(color: black, fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, MySignInScreen.routeName, (route) => false);
                    },
                    child: Text(
                      " Login",
                      style: GoogleFonts.montserrat().copyWith(
                          color: blue,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
              Gap(40),
              Form(
                key: _signFormKey,
                child: Column(
                  children: [
                    MyCustomTextField(
                      textEditingController: _nameController,
                      hintText: "Enter your name",
                      labelText: "Name",
                      focusNode: nameFocus,
                      fun: (p0) {
                        FocusScope.of(context).requestFocus(emailFocus);
                      },
                    ),
                    Gap(25),
                    MyCustomTextField(
                      textEditingController: _emailController,
                      hintText: "Enter your email",
                      labelText: "Email",
                      focusNode: emailFocus,
                      fun: (p0) {
                        FocusScope.of(context).requestFocus(passwordFocus);
                      },
                    ),
                    Gap(25),
                    MyCustomTextField(
                      textEditingController: _passwordController,
                      hintText: "Enter your password",
                      labelText: "Password",
                      isPassword: true,
                      focusNode: passwordFocus,
                    ),
                    Gap(35),
                    GestureDetector(
                      onTap: () {
                        if (_signFormKey.currentState!.validate()) {
                          signUp();
                        }
                      },
                      child: MyAuthCustomButton(
                          color: blue,
                          widget: isSignUp
                              ? MyLoader(color: white)
                              : Text(
                                  "Sign Up",
                                  style: textStyle()
                                      .copyWith(color: white, fontSize: 15),
                                ),
                          textColor: white,
                          borderColor: blue),
                    ),
                    Gap(15),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "By signing up, you are agreeing to our ",
                  style: GoogleFonts.montserrat().copyWith(color: black),
                  children: [
                    TextSpan(
                      text: "Terms of Service ",
                      style: GoogleFonts.montserrat(
                          color: blue, fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: "and ",
                      style: GoogleFonts.montserrat().copyWith(color: black),
                    ),
                    TextSpan(
                      text: "Privacy Policy.",
                      style: GoogleFonts.montserrat(
                          color: blue, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
