import 'package:flutter/material.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/presentation/home/screens/Property_detials/screens/property_detials.dart';
import 'package:movin/presentation/home/screens/buyer_home_screen.dart';
import 'package:movin/presentation/home/screens/seller_home.dart';
import 'package:movin/presentation/login/screens/forgot_password_page.dart';
import 'package:movin/presentation/login/screens/login_screen.dart';
import 'package:movin/presentation/onboarding/screens/onboarding.dart';
import 'package:movin/presentation/role_selection/screens/role_selection.dart';
import 'package:movin/presentation/splash_screen/screens/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  runApp(const Movin());
}

class Movin extends StatelessWidget {
  const Movin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      routes: {
        '/onboarding': (_) => const OnboardingScreen(),
        '/login': (_) => const LoginScreen(),
        '/role': (_) => const RoleSelection(),
        '/buyerhome': (_) => const BuyerHome(),
        '/sellerhome': (_) => const SellerHome(),
        '/forgotpassword': (_) => const ForgotPasswordPage(),
      },
    );
  }
}
