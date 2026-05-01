// import 'package:flutter/material.dart';
// import 'package:movin/app_theme.dart';
// import 'package:movin/domain/entities/property_model.dart';
// import 'package:movin/presentation/Property_detials/screens/property_detials.dart';
// import 'package:movin/presentation/browse_property/widgets/browse_property_card.dart';
// import 'package:movin/presentation/browse_property/widgets/dummy_properties.dart';
// import 'package:movin/presentation/browse_property/widgets/search_widget.dart';

// class ViewMoreHome extends StatefulWidget {
//   // final String type; // rent, sale,
//   const ViewMoreHome({super.key});

//   @override
//   State<ViewMoreHome> createState() => _ViewMoreHomeState();
// }

// class _ViewMoreHomeState extends State<ViewMoreHome> {
//   String searchQuery = "";

//   void _onSearchChanged(String value) {
//     setState(() {
//       searchQuery = value.toLowerCase();
//     });
//   }

//   // void toggleFavorite(PropertyModel property) {
//   //   setState(() {
//   //     property.isfavorite = !property.isfavorite;
//   //   });
//   // }

//   void navigateToDetails(PropertyModel property) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PropertyDetailsScreen(propertyId:property.id.toString()),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     //final filtered = dummyProperties;
//     // .where(
//     //   (property) => property.tag.toLowerCase() == widget.type.toLowerCase(),
//     // )
//     // .toList();
//     final filtered = dummyProperties.where((property) {
//       final matchesSearch = property.location.toLowerCase().contains(
//         searchQuery,
//       );

//       return matchesSearch;
//     }).toList();
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         title: Text(
//           "Browse Properties",
//           style: TextStyle(color: AppColors.navyDark),
//         ),
//         backgroundColor: AppColors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // go back
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SearchHeader(onSearchChanged: _onSearchChanged),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 14),
//               child: Text(
//                 "${filtered.length} properties found",
//                 style: AppTextStyles.label,
//               ),
//             ),

//             const SizedBox(height: 10),
//             Expanded(
//               child: filtered.isEmpty
//                   ? const Center(
//                       child: Text(
//                         "No properties found",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: filtered.length,
//                       itemBuilder: (context, index) {
//                         final property = filtered[index];
//                         return BrowsePropertyCard(
//                           property: property,
//                           onTap: () => navigateToDetails(property),
//                           // onFavoriteToggle: () => toggleFavorite(property),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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

class ViewMoreListing extends StatefulWidget {
  const ViewMoreListing({super.key});

  @override
  State<ViewMoreListing> createState() => _ViewMoreListingState();
}

class _ViewMoreListingState extends State<ViewMoreListing> {
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
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<PropertyCubit>().loadRecentProperties();
    vm = SearchPropertyViewModel(
      PropertyRepositoryImpl(PropertyService(Dio())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "Recent Listings",
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

                // if (cubit.loadingRecent) {
                //   return const Expanded(
                //     child: Center(
                //       child: CircularProgressIndicator(
                //         color: AppColors.navyDark,
                //       ),
                //     ),
                //   );
                // }

                // final properties = cubit.recentProperties;

                // /// SEARCH FILTER
                // final filtered = properties.where((property) {
                //   return property.location.toLowerCase().contains(searchQuery);
                // }).toList();

                return AnimatedBuilder(
                  animation: vm,
                  builder: (context, _) {
                    final bool isSearching = searchQuery.isNotEmpty;

                    final properties = isSearching
                        ? vm.properties
                        : cubit.recentProperties;

                    if (vm.isLoading || cubit.loadingRecent) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.navyDark,
                        ),
                      );
                    }

                    if (properties.isEmpty) {
                      return const Center(child: Text("No properties found"));
                    }
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
