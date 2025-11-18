import 'package:flutter/material.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    bool onboardingSeen = await SharedHelper.isOnboardingSeen();
    bool isLoggedIn = await SharedHelper.isLoggedIn();
    String? userRole = await SharedHelper.getUserRole();

    //onboarding check
    if (!mounted) return;
    if (!onboardingSeen) {
      Navigator.pushReplacementNamed(context, '/onboarding');
      return;
    }

    //logging in check
    if (!mounted) return;
    if (!isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    //check role
    if (!mounted) return;
    if (userRole == null) {
      Navigator.pushReplacementNamed(context, '/role');
      return;
    }

    //buyer or seller ?
    if (userRole == 'buyer') {
      Navigator.pushReplacementNamed(context, '/buyerhome');
    } else if (userRole == 'seller') {
      Navigator.pushReplacementNamed(context, '/sellerhome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF1A2332),
      body: Image.asset(
        'assets/images/splashscreen.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
