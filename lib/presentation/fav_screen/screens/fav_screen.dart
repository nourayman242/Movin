import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/presentation/browse_property/widgets/dummy_properties.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_bloc.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_event.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_state.dart';
import 'package:movin/presentation/fav_screen/widgets/fav_card.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        final favIds = state.favorites;

        final savedList = dummyProperties
            .where((p) => favIds.contains(p.id))
            .toList();

        return Scaffold(
          backgroundColor: const Color(0xffF6F7F9),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const BackButton(color: Colors.black),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Saved Properties",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${savedList.length} properties",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<FavoriteBloc>().add(FavoriteClear());
                },
                child: const Text(
                  "Clear All",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: savedList.length,
            itemBuilder: (ctx, index) {
              return FavCard(property: savedList[index]);
            },
          ),
        );

       
      },
    );
  }
}
