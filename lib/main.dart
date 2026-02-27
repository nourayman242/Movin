import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movin/data/models/property_model.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_bloc.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_event.dart';

import 'package:movin/presentation/home/managers/mode_service.dart';
import 'package:movin/presentation/home/screens/buyer_home_screen.dart';
import 'package:movin/presentation/home/screens/home.dart';
import 'package:movin/presentation/login/cubit/forget_pass_cubit.dart';

import 'package:movin/presentation/login/screens/forgot_password_page.dart';
import 'package:movin/presentation/login/screens/login_screen.dart';
import 'package:movin/presentation/onboarding/screens/onboarding.dart';
import 'package:movin/presentation/role_selection/screens/role_selection.dart';
import 'package:movin/presentation/seller_properties/add_property/add_property_screen.dart';
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';
import 'package:movin/presentation/seller_properties/edit%20_property/edit_property_screen.dart';
import 'package:movin/presentation/seller_properties/saller%20home/seller_home_screen.dart';
import 'package:movin/presentation/settings/managers/settings_bloc/settings_bloc.dart';
import 'package:movin/presentation/settings/managers/settings_bloc/settings_events.dart';
import 'package:movin/presentation/splash_screen/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ModeService.loadUserMode();
  await Hive.initFlutter();
  await setUpServiceLocator();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<FavoriteBloc>()..add(FavoriteLoad()),
          ),
          BlocProvider(
            create: (_) => getIt<SettingsBloc>()..add(LoadSettings()),
          ),
        ],
        child: const Movin(),
      ),
    ),
  );
}

class Movin extends StatelessWidget {
  const Movin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ← now MaterialApp is the direct root
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      routes: {
        '/onboarding': (_) => const OnboardingScreen(),
        '/login': (_) => const LoginScreen(),
        '/role': (_) => const RoleSelection(),
        '/buyerhome': (_) => const BuyerHome(),
        '/sellerhome': (_) => BlocProvider(
          create: (_) => getIt<PropertyCubit>(),
          child: const SellerHome(),
        ),
        '/forgotpassword': (_) => BlocProvider(
          create: (_) => getIt<ForgotPasswordCubit>(),
          child: const ForgotPasswordPage(),
        ),
        '/home': (_) => const HomePage(),
        '/addproperty': (_) => BlocProvider(
          create: (_) => getIt<PropertyCubit>(),
          child: const AddPropertyScreen(),
        ),
        '/edit-property': (context) {
          final property =
              ModalRoute.of(context)!.settings.arguments as PropertyModel;
          return BlocProvider(
            create: (_) => getIt<PropertyCubit>(),
            child: EditPropertyScreen(property: property),
          );
        },
      },
    );
  }
}
