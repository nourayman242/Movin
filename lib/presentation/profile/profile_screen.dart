import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';

import 'package:movin/presentation/profile/cubit/profile_cubit.dart';
import 'edit_profile_screen.dart';
import '../../data/models/profile_model.dart';
import 'package:movin/presentation/profile/widget/contact_info_card.dart';
import 'package:movin/presentation/profile/widget/profile_header.dart';
import 'package:movin/presentation/profile/widget/profile_stats.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

 


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.gold,));
          }

          if (state.profile == null) {
            return const Center(child: Text("No Data"));
          }

          final profile = state.profile!;

          return SingleChildScrollView(
            child: Column(
              children: [
                ProfileHeader(
                  profile: profile,
                  onEdit: () async {
                    final updated = await Navigator.push<ProfileModel>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<ProfileCubit>(),
                          child: EditProfileScreen(profile: profile),
                        ),
                      ),
                    );

                    if (updated != null) {
                      context.read<ProfileCubit>().updateProfile(
                        username: updated.name,
                        bio: updated.bio,
                        location: updated.location,
                        phone:updated.phone
                      );
                    }
                  },
                ),
                const SizedBox(height: 24),
                 ProfileStats(profile: state.profile!,),
                
                EditableContactInfoCard(
                  emailController: TextEditingController(text: profile.email),
                  phoneController: TextEditingController(text: profile.phone),
                  locationController: TextEditingController(
                    text: profile.location,
                  ),
                  profile: profile,
                ),
              ],
            ),


          );
        },

      ),
    );
  }
}
