
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/Property_detials/screens/property_detials.dart';
import 'package:movin/presentation/browse_property/widgets/browse_property_card.dart';
import 'package:movin/presentation/browse_property/widgets/search_widget.dart';
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';

class ViewMoreRecommendtion extends StatefulWidget {
  const ViewMoreRecommendtion({super.key});

  @override
  State<ViewMoreRecommendtion> createState() => _ViewMoreRecommendtionState();
}

class _ViewMoreRecommendtionState extends State<ViewMoreRecommendtion> {
  String searchQuery = "";

  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
    });
  }

  void navigateToDetails(PropertyEntity property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PropertyDetailsScreen(propertyId: property.id),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<PropertyCubit>().loadRecommendedProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "Recommended",
          style: TextStyle(color: AppColors.navyDark),
        ),
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

                if (cubit.loadingRecommended) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.navyDark,
                      ),
                    ),
                  );
                }

                final properties = cubit.recommendedProperties;

                /// SEARCH FILTER
                final filtered = properties.where((property) {
                  return property.location.toLowerCase().contains(searchQuery);
                }).toList();

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          "${filtered.length} properties found",
                          style: AppTextStyles.label,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Expanded(
                        child: filtered.isEmpty
                            ? const Center(
                                child: Text(
                                  "No properties found",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : ListView.builder(
                                itemCount: filtered.length,
                                itemBuilder: (context, index) {
                                  final property = filtered[index];

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
            ),
          ],
        ),
      ),
    );
  }
}
