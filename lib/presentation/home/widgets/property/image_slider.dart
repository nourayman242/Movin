import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_bloc.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_event.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_state.dart';
import 'package:movin/presentation/home/widgets/shared/circle_button.dart';


class PropertyImageSlider extends StatelessWidget {
  final PageController controller;
 final PropertyEntity property;

  const PropertyImageSlider({
    super.key,
    required this.controller,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 320.h,
          width: double.infinity,
          child: PageView(
            controller: controller,
            children:  [
              Image(
                image: NetworkImage(property.images.first),
                //AssetImage('assets/images/villa2.webp')
                fit: BoxFit.cover,
              ),
              Image(
                image: AssetImage('assets/images/villa2.webp'),
                fit: BoxFit.cover,
              ),
              Image(
                image: AssetImage('assets/images/villa3.jpg'),
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: CircleButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          top: 40,
          right: 16,
          child: Row(
            children: [
              CircleButton(icon: Icons.share, onTap: () {}),
              SizedBox(width: 10.w),


               BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  final isFav = state.isFavorite(property.id);

                  return CircleButton(
                    icon: isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : null,
                    onTap: () {
                      context
                          .read<FavoriteBloc>()
                          .add(FavoriteToggle(property.id));
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          top: 130,
          child: CircleButton(
            icon: Icons.arrow_back_ios_rounded,
            onTap: () {
              if (controller.hasClients && controller.page! > 0) {
                controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ),
        Positioned(
          right: 10,
          top: 130,
          child: CircleButton(
            icon: Icons.arrow_forward_ios_rounded,
            onTap: () {
              if (controller.hasClients && controller.page! < 2) {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
