import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/Features/homescreen.dart';
import 'package:tej_mart/Features/init_screen.dart';
import 'package:tej_mart/constants/sizes.dart';
import 'package:tej_mart/providers/customer_provider.dart';
import 'package:tej_mart/services/auth_service.dart';
import 'package:tej_mart/widgets/bottombar.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    getUserData();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    Future.delayed(const Duration(seconds: 3), () {
      goToScreen();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  getUserData() async {
    await UserAuthService().getUserDataForLogin(context: context);
  }

  goToScreen() {
    final user = Provider.of<CustomerProvider>(context, listen: false).user;
    print("user is ${user.token}");
    user.token.isNotEmpty
        ? Get.to(() => const MyBottomBar())
        : Get.to(() => const MyInitScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RotationTransition(
              turns: _controller,
              child: Image.asset('assets/newlogo.png'),
            ),
          ),
          Image.asset(
            "assets/textlogo.png",
            width: getWidth(0.8, context),
          ),
        ],
      ),
    );
  }
}
