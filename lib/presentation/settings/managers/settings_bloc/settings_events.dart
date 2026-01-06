abstract class SettingsEvent {}

class ChangeLanguage extends SettingsEvent {
  final String language;
  ChangeLanguage(this.language);
}

class TogglePushNotifications extends SettingsEvent {}

class ToggleEmailNotifications extends SettingsEvent {}

class TogglePropertyAlerts extends SettingsEvent {}

class LogoutRequested extends SettingsEvent {}
class LoadSettings extends SettingsEvent {}
