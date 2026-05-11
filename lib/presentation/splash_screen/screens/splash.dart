
import 'package:flutter/material.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';

import '../../../data/data_source/local/token_cache.dart';

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
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final token = await SharedHelper.getToken();
    final refresh = await SharedHelper.getRefreshToken();

    TokenCache.accessToken = token;
    TokenCache.refreshToken = refresh;
    //final loggedIn = await SharedHelper.isLoggedIn();
    final onboardingSeen = await SharedHelper.isOnboardingSeen();




    // first time
    if (!onboardingSeen) {
      Navigator.pushReplacementNamed(context, '/onboarding');
      return;
    }

      // not logged in
//kan kda
    // if (token == null || token.isEmpty) {

    final isLoggedIn = await SharedHelper.isLoggedIn();
    if (!isLoggedIn || token == null || token.isEmpty) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    final role = await SharedHelper.getUserRole();

    if (role == 'buyer') {
      Navigator.pushReplacementNamed(context, '/buyerhome');
    } else if (role == 'seller') {
      Navigator.pushReplacementNamed(context, '/sellerhome');
    } else {
      Navigator.pushReplacementNamed(context, '/role');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/splashscreen.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}