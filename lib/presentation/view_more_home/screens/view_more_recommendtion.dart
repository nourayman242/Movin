import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/api_services/property_services.dart';
import 'package:movin/data/repositories/property_repository_impl.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/Property_detials/screens/property_detials.dart';
import 'package:movin/presentation/browse_property/widgets/browse_property_card.dart';
import 'package:movin/presentation/browse_property/widgets/search_property_viewmodel.dart';
import 'package:movin/presentation/browse_property/widgets/search_widget.dart';
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';

class ViewMoreRecommendtion extends StatefulWidget {
  const ViewMoreRecommendtion({super.key});

  @override
  State<ViewMoreRecommendtion> createState() => _ViewMoreRecommendtionState();
}

class _ViewMoreRecommendtionState extends State<ViewMoreRecommendtion> {
  String searchQuery = "";
  late SearchPropertyViewModel vm;

  Timer? _debounce;

  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
    });

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      vm.search(value);
    });
  }

  void navigateToDetails(PropertyEntity property) {
   Navigator.push(
 context,
 MaterialPageRoute(
   builder: (_) => BlocProvider.value(
     value: getIt<PropertyCubit>(),
     child: PropertyDetailsScreen(propertyId: property.id),
   ),
 ),
);
  }

  @override
  void initState() {
    super.initState();
    context.read<PropertyCubit>().loadRecommendedProperties();
    vm = SearchPropertyViewModel(
      PropertyRepositoryImpl(PropertyService(Dio())),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Recommended", style: TextStyle(color: AppColors.navyDark)),
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchHeader(onSearchChanged: _onSearchChanged),

            const SizedBox(height: 10),

            BlocBuilder<PropertyCubit, PropertyState>(
              builder: (context, state) {
                final cubit = context.read<PropertyCubit>();
                final bool isSearching = searchQuery.isNotEmpty;

                final properties = isSearching
                    ? vm.properties
                    : cubit.recommendedProperties;

                if (vm.isLoading || cubit.loadingRecommended) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.navyDark),
                  );
                }

                if (properties.isEmpty) {
                  return const Center(child: Text("No properties found"));
                }

                return AnimatedBuilder(
                  animation: vm,
                  builder: (context, _) {
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              "${properties.length} properties found",
                              style: AppTextStyles.label,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: properties.length,
                              itemBuilder: (context, index) {
                                final property = properties[index];

                                return BrowsePropertyCard(
                                  property: property,
                                  onTap: () => navigateToDetails(property),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
