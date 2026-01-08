class SettingsState {
  final String language;
  final bool pushNotifications;
  final bool emailNotifications;
  final bool propertyAlerts;

  const SettingsState({
    required this.language,
    required this.pushNotifications,
    required this.emailNotifications,
    required this.propertyAlerts,
  });

  SettingsState copyWith({
    String? language,
    bool? pushNotifications,
    bool? emailNotifications,
    bool? propertyAlerts,
  }) {
    return SettingsState(
      language: language ?? this.language,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      propertyAlerts: propertyAlerts ?? this.propertyAlerts,
    );
  }
}
