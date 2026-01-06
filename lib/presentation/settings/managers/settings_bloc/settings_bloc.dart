import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/data/data_source/local/auth_local_services.dart';
import 'package:movin/data/data_source/local/settings_local_services.dart';
import 'package:movin/presentation/settings/managers/settings_bloc/settings_events.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/presentation/settings/managers/settings_bloc/settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsLocalService localService;
  final AuthLocalService authLocalService; 
  SettingsBloc(this.localService , this.authLocalService)
      : super(
          const SettingsState(
            language: 'en',
            pushNotifications: true,
            emailNotifications: false,
            propertyAlerts: true,
          ),
        ) {
    on<ChangeLanguage>((event, emit)  async{
      emit(state.copyWith(language: event.language));
      await localService.saveLanguage(event.language);
    });

    on<TogglePushNotifications>((event, emit) async {
  final newValue = !state.pushNotifications;
  emit(state.copyWith(pushNotifications: newValue));
  await localService.savePush(newValue);
});

on<ToggleEmailNotifications>((event, emit) async {
  final newValue = !state.emailNotifications;
  emit(state.copyWith(emailNotifications: newValue));
  await localService.saveEmail(newValue);
});

on<TogglePropertyAlerts>((event, emit) async {
  final newValue = !state.propertyAlerts;
  emit(state.copyWith(propertyAlerts: newValue));
  await localService.saveAlerts(newValue);
});


    on<LoadSettings>((event, emit) async {
  final language = await localService.getLanguage();
  final push = await localService.getPush();
  final email = await localService.getEmail();
  final alerts = await localService.getAlerts();

  emit(
    state.copyWith(
      language: language,
      pushNotifications: push,
      emailNotifications: email,
      propertyAlerts: alerts,
    ),
  );
});


    on<LogoutRequested>((event, emit)async {
      await AuthLocalService.clearAll();

    });
  }
}
