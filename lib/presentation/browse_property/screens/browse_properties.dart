import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/api_services/property_services.dart';
import 'package:movin/data/repositories/property_repository_impl.dart';
import 'package:movin/domain/repositories/property_repository.dart';
import 'package:movin/presentation/Property_detials/screens/property_detials.dart';
import 'package:movin/presentation/browse_property/widgets/browse_property_card.dart';
import 'package:movin/presentation/browse_property/widgets/browser_property_viewmodel.dart';
import 'package:movin/presentation/browse_property/widgets/dummy_properties.dart';
import 'package:movin/presentation/browse_property/widgets/search_widget.dart';

class BrowsePropertiesScreen extends StatefulWidget {
  final String type; // rent, sale, commercial, investment

  const BrowsePropertiesScreen({required this.type, super.key});

  @override
  State<BrowsePropertiesScreen> createState() => _BrowsePropertiesScreenState();
}

class _BrowsePropertiesScreenState extends State<BrowsePropertiesScreen> {
  String searchQuery = "";
  late BrowseViewModel vm;

  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
    });
  }

  void navigateToDetails(property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PropertyDetailsScreen(property: property),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    vm = BrowseViewModel(context.read<PropertyRepository>());
    //PropertyRepositoryImpl(PropertyService(Dio())));

    vm.load(widget.type.toLowerCase());
    //[0].toUpperCase() + widget.type.substring(1));
  }

  @override
  Widget build(BuildContext context) {
    // final filtered = dummyProperties.where((property) {
    //   final matchesType =
    //       property.listingType.toLowerCase() == widget.type.toLowerCase();

    //   final matchesSearch = property.location.toLowerCase().contains(
    //     searchQuery,
    //   );

    //   return matchesType && matchesSearch;
    // }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Browse Properties"),
        backgroundColor: AppColors.white,
        leading: BackButton(color: AppColors.navyDark),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchHeader(onSearchChanged: _onSearchChanged),

            const SizedBox(height: 10),

            // Expanded(
            //   child: filtered.isEmpty
            //       ? const Center(
            //           child: Text(
            //             "No properties found",
            //             style: TextStyle(color: Colors.grey),
            //           ),
            //         )
            //       : ListView.builder(
            //           itemCount: filtered.length,
            //           itemBuilder: (context, index) {
            //             final property = filtered[index];
            //             return BrowsePropertyCard(
            //               property: property,
            //               onTap: () => navigateToDetails(property),
            //             );
            //           },
            //         ),
            // ),
            AnimatedBuilder(
              animation: vm,
              builder: (context, _) {
                if (vm.isLoading) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.navyDark,));
                }

                final filtered = vm.properties.where((property) {
                  return property.location.toLowerCase().contains(searchQuery);
                }).toList();
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "${filtered.length} properties found",

                    style: AppTextStyles.label,
                  ),
                );

                return Expanded(
                  child: filtered.isEmpty
                      ? const Center(child: Text("No properties found"))
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:movin/presentation/browse_property/widgets/search_property_viewmodel.dart';
// import 'package:provider/provider.dart';
// import 'package:movin/app_theme.dart';
// import 'package:movin/presentation/Property_detials/screens/property_detials.dart';
// import 'package:movin/presentation/browse_property/widgets/browse_property_card.dart';
// import 'package:movin/presentation/browse_property/widgets/search_widget.dart';

// class BrowsePropertiesScreen extends StatefulWidget {
//   final String type; // rent, sale, commercial, investment

//   const BrowsePropertiesScreen({required this.type, super.key});

//   @override
//   State<BrowsePropertiesScreen> createState() => _BrowsePropertiesScreenState();
// }

// class _BrowsePropertiesScreenState extends State<BrowsePropertiesScreen> {
//   String searchQuery = "";

//   void _onSearchChanged(String value) {
//     searchQuery = value;

//     /// call backend search
//     context.read<SearchPropertyViewModel>().search(value);
//   }

//   void navigateToDetails(property) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => PropertyDetailsScreen(property: property),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final vm = context.watch<SearchPropertyViewModel>();

//     /// filter by listing type
//     final filtered = vm.properties.where((property) {
//       return property.location.toLowerCase() == widget.type.toLowerCase();
//     }).toList();

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         title: const Text("Browse Properties"),
//         backgroundColor: AppColors.white,
//         leading: BackButton(color: AppColors.navyDark),
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
//               child: vm.isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : filtered.isEmpty
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
