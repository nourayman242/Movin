import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/settings/managers/settings_bloc/settings_bloc.dart';
import 'package:movin/presentation/settings/managers/settings_bloc/settings_events.dart';
import 'package:movin/presentation/settings/widgets/account_settings_card.dart';
import 'package:movin/presentation/settings/widgets/language_card.dart';
import 'package:movin/presentation/settings/widgets/logout_button.dart';
import 'package:movin/presentation/settings/widgets/notification_card.dart';
import 'package:movin/presentation/settings/widgets/privacy_card.dart';
import 'package:movin/presentation/settings/widgets/version_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(LoadSettings());
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: AppColors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Column(
            children: [
              LanguageCard(),
              AppWidgets.verticalSpace(AppSpacing.medium),
              NotificationCard(),
              AppWidgets.verticalSpace(AppSpacing.medium),
              AccountSettingsCard(),
              AppWidgets.verticalSpace(AppSpacing.medium),
              PrivacyLegalCard(),
              AppWidgets.verticalSpace(AppSpacing.large),
              LogoutButton(),
              AppWidgets.verticalSpace(AppSpacing.small),
              VersionText(),
            ],
          ),
        ),
      );
  }
}
