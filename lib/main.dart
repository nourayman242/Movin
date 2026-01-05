import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';

import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_bloc.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_event.dart';

import 'package:movin/presentation/add_property/add_property_screen.dart';

import 'package:movin/presentation/home/managers/mode_service.dart';
import 'package:movin/presentation/home/screens/buyer_home_screen.dart';
import 'package:movin/presentation/home/screens/home.dart';
import 'package:movin/presentation/saller%20home/seller_home_screen.dart';
import 'package:movin/presentation/login/screens/forgot_password_page.dart';
import 'package:movin/presentation/login/screens/login_screen.dart';
import 'package:movin/presentation/onboarding/screens/onboarding.dart';
import 'package:movin/presentation/role_selection/screens/role_selection.dart';
import 'package:movin/presentation/settings/managers/settings_bloc/settings_bloc.dart';
import 'package:movin/presentation/settings/managers/settings_bloc/settings_events.dart';
import 'package:movin/presentation/splash_screen/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ModeService.loadUserMode();
  await Hive.initFlutter();
  await setUpServiceLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<FavoriteBloc>()..add(FavoriteLoad())),
        BlocProvider(create: (_) => getIt<SettingsBloc>()..add(LoadSettings())),
      ],
      child: Movin(),
    ),
  );
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
        '/home': (_) => const HomePage(),
        '/addproperty': (_) => const AddPropertyScreen(),
      },
    );
  }

  // return MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: const Splash(),
  //   routes: {
  //     '/onboarding': (_) => const OnboardingScreen(),
  //     '/login': (_) => const LoginScreen(),
  //     '/role': (_) => const RoleSelection(),
  //     '/buyerhome': (_) => const BuyerHome(),
  //     '/sellerhome': (_) => const SellerHome(),
  //     '/forgotpassword': (_) => const ForgotPasswordPage(),
  //     '/home':(_)=> const HomePage(),
  //     '/addproperty': (_) => const AddPropertyScreen(),
  //   },

  // );
}
