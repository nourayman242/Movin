// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movin/app_theme.dart';
// import 'package:movin/presentation/settings/managers/settings_bloc/settings_bloc.dart';
// import 'package:movin/presentation/settings/managers/settings_bloc/settings_events.dart';
// import 'package:movin/presentation/settings/managers/settings_bloc/settings_state.dart';

// class NotificationCard extends StatelessWidget {
//   const NotificationCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       color: AppColors.white,
//       child: BlocBuilder<SettingsBloc, SettingsState>(
//         builder: (context, state) {
//           return Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFFFF7E5),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.notifications,
//                       color: Color(0xFFFFC107),
//                       size: 24,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Notifications',
//                         style: AppTextStyles.label.copyWith(
//                           color: AppColors.primary,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         'Manage your notification preferences',
//                         style: AppTextStyles.smallText.copyWith(
//                           color: AppColors.grey,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               SwitchListTile(
//                 title: const Text('Push Notifications'),
//                 value: state.pushNotifications,
//                 activeColor: AppColors.navyDark,
//                 inactiveThumbColor: AppColors.white,
//                 inactiveTrackColor: AppColors.grey,
//                 onChanged: (_) {
//                   context.read<SettingsBloc>().add(TogglePushNotifications());
//                 },
//               ),
//               SwitchListTile(
//                 title: const Text('Email Notifications'),
//                 value: state.emailNotifications,
//                 activeColor: AppColors.navyDark,
//                 inactiveThumbColor: AppColors.white,
//                 inactiveTrackColor: AppColors.grey,
//                 onChanged: (_) {
//                   context.read<SettingsBloc>().add(ToggleEmailNotifications());
//                 },
//               ),
//               SwitchListTile(
//                 title: const Text('Property Alerts'),
//                 value: state.propertyAlerts,
//                 activeColor: AppColors.navyDark,
//                 inactiveThumbColor: AppColors.white,
//                 inactiveTrackColor: AppColors.grey,
//                 onChanged: (_) {
//                   context.read<SettingsBloc>().add(TogglePropertyAlerts());
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/settings/managers/settings_bloc/settings_bloc.dart';
import 'package:movin/presentation/settings/managers/settings_bloc/settings_events.dart';
import 'package:movin/presentation/settings/managers/settings_bloc/settings_state.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium + 4),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7E5),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFFF7E5),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Color(0xFFFFC107),

                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications',
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.primary,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Manage your notification preferences',
                          style: AppTextStyles.smallText.copyWith(
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                SwitchListTile(
                  title: const Text('Push Notifications'),
                  value: state.pushNotifications,
                  activeColor: AppColors.gold,
                  inactiveThumbColor: AppColors.white,
                  inactiveTrackColor: Color(0xFFFFF7E5),
                  onChanged: (_) {
                    context.read<SettingsBloc>().add(TogglePushNotifications());
                  },
                ),
                SwitchListTile(
                  title: const Text('Email Notifications'),
                  value: state.emailNotifications,
                  activeColor: AppColors.gold,
                  inactiveThumbColor: AppColors.white,
                  inactiveTrackColor: Color(0xFFFFF7E5),
                  onChanged: (_) {
                    context.read<SettingsBloc>().add(
                      ToggleEmailNotifications(),
                    );
                  },
                ),
                SwitchListTile(
                  title: const Text('Property Alerts'),
                  value: state.propertyAlerts,
                  activeColor: AppColors.gold,
                  inactiveThumbColor: AppColors.white,
                  inactiveTrackColor: Color(0xFFFFF7E5),
                  onChanged: (_) {
                    context.read<SettingsBloc>().add(TogglePropertyAlerts());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
