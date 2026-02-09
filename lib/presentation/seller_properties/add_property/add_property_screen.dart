// import 'package:flutter/material.dart';
// import 'package:movin/presentation/seller_properties/add_property/widgets/success_dialog.dart';
// import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';
// import 'package:provider/provider.dart';
// import 'add_property_viewmodel.dart';
// import 'widgets/property_type_selector.dart';
// import 'widgets/basic_info_section.dart';
// import 'widgets/property_details_section.dart';
// import 'widgets/images_section.dart';
// import 'widgets/description_section.dart';
// import 'package:movin/app_theme.dart';

// class AddPropertyScreen extends StatelessWidget {
//   const AddPropertyScreen({super.key});

//   Future<void> _onPreview(BuildContext context) async {
//     final vm = context.read<AddPropertyViewModel>();
//     if (!vm.isFormValid) return;

//     await showDialog(
//       context: context,
//       builder: (ctx) => SuccessDialog(
//         onDone: () {
//           Navigator.of(ctx).pop();
//           // after dialog closes, reset form
//           vm.reset();
//         },
//       ),
//     );
//   }
//   // Future<void> _onPreview(BuildContext context) async {
//   //   final vm = context.read<AddPropertyViewModel>();
//   //   final cubit = context.read<PropertyCubit>();

//   //   await cubit.addProperty(vm: vm);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return ChangeNotifierProvider(
//       create: (_) => AddPropertyViewModel(),
//       builder: (context, _) {
//         final vm = context.watch<AddPropertyViewModel>();
//         return Scaffold(
//           backgroundColor: AppColors.background,
//           appBar: AppBar(
//             backgroundColor: AppColors.white,
//             elevation: 0,
//             leadingWidth: 90,
//             toolbarHeight: 70,
//             leading: Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: InkWell(
//                 onTap: () => Navigator.of(context).maybePop(),
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     color: Colors.white70,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.arrow_back, color: Colors.black54),
//                 ),
//               ),
//             ),
//             title: const Text(
//               'Add Property',
//               style: TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             centerTitle: false,
//             bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(0),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16.0,
//                   vertical: 8,
//                 ),
//                 child: Text(
//                   'List your property for sale or rent',
//                   style: TextStyle(color: Colors.black54.withOpacity(0.8)),
//                 ),
//               ),
//             ),
//           ),
//           body: GestureDetector(
//             onTap: () => FocusScope.of(context).unfocus(),
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.only(bottom: 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const SizedBox(height: 8),
//                   const PropertyTypeSelector(),
//                   const SizedBox(height: 12),
//                   if (!vm.isTypeSelected)
//                     // Container(
//                     //   margin: const EdgeInsets.symmetric(horizontal: 16),
//                     //   padding: const EdgeInsets.all(14),
//                     //   decoration: BoxDecoration(
//                     //     color: AppColors.white,
//                     //     borderRadius: BorderRadius.circular(14),
//                     //     boxShadow: [
//                     //       BoxShadow(
//                     //         color: Colors.black.withOpacity(0.04),
//                     //         blurRadius: 12,
//                     //       ),
//                     //     ],
//                     //   ),
//                     //   child: SizedBox(
//                     //     height: 140,
//                     //     child: Column(
//                     //       mainAxisAlignment: MainAxisAlignment.center,
//                     //       children: const [
//                     //         Icon(Icons.add, size: 36, color: AppColors.gold),
//                     //         SizedBox(height: 8),
//                     //         Text(
//                     //           'List Your Property',
//                     //           style: TextStyle(fontWeight: FontWeight.bold),
//                     //         ),
//                     //         SizedBox(height: 6),
//                     //         Text(
//                     //           '''Fill in the details about your property. All listings are reviewed by our admin team before being published to ensure quality and accuracy.''',
//                     //           textAlign: TextAlign.center,
//                     //           style: TextStyle(color: Colors.black54),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ),
//                     Container(
//                       margin: EdgeInsets.symmetric(
//                         horizontal: screenWidth * 0.04,
//                       ),
//                       padding: EdgeInsets.all(screenWidth * 0.035),
//                       decoration: BoxDecoration(
//                         color: AppColors.white,
//                         borderRadius: BorderRadius.circular(
//                           screenWidth * 0.035,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.04),
//                             blurRadius: 12,
//                           ),
//                         ],
//                       ),
//                       child: SizedBox(
//                         height: screenHeight * 0.18,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.add,
//                               size: screenWidth * 0.09,
//                               color: AppColors.gold,
//                             ),
//                             SizedBox(height: screenHeight * 0.01),
//                             Text(
//                               'List Your Property',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: screenWidth * 0.045,
//                               ),
//                             ),
//                             SizedBox(height: screenHeight * 0.008),
//                             Text(
//                               'Fill in the details about your property. All listings are reviewed by our admin team before being published to ensure quality and accuracy.',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: screenWidth * 0.035,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                   if (vm.isTypeSelected) ...[
//                     const SizedBox(height: 12),
//                     const BasicInfoSection(),
//                     const SizedBox(height: 12),
//                     const PropertyDetailsSection(),
//                     const SizedBox(height: 12),
//                     const ImagesSection(),
//                     const SizedBox(height: 12),
//                     const DescriptionSection(),
//                     const SizedBox(height: 18),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               style: OutlinedButton.styleFrom(
//                                 backgroundColor: AppColors.white,
//                                 side: const BorderSide(color: Colors.white70),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 14,
//                                 ),
//                               ),
//                               onPressed: () => vm.reset(),
//                               child: const Text(
//                                 'Cancel',
//                                 style: TextStyle(color: Colors.black87),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 14),
//                           Expanded(
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: vm.isFormValid
//                                     ? AppColors.gold
//                                     : Colors.grey.shade300,
//                                 foregroundColor: vm.isFormValid
//                                     ? Colors.black
//                                     : Colors.black38,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 14,
//                                 ),
//                               ),
//                               onPressed:vm.isFormValid
//                                   ? () => _onPreview(context)
//                                   : null,
//                               // onPressed: vm.isFormValid
//                               //     ? () {
//                               //         final entity = vm.toEntity();
//                               //         context.read<PropertyCubit>().create(
//                               //           entity,
//                               //         );
//                               //       }
//                               //     : null,

//                               child: const Text(
//                                 'Send To Admin',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:movin/app_theme.dart';
import 'package:movin/presentation/seller_properties/add_property/add_property_viewmodel.dart';
import 'package:movin/presentation/seller_properties/add_property/widgets/property_type_selector.dart';
import 'package:movin/presentation/seller_properties/add_property/widgets/basic_info_section.dart';
import 'package:movin/presentation/seller_properties/add_property/widgets/property_details_section.dart';
import 'package:movin/presentation/seller_properties/add_property/widgets/images_section.dart';
import 'package:movin/presentation/seller_properties/add_property/widgets/description_section.dart';
import 'package:movin/presentation/seller_properties/add_property/widgets/success_dialog.dart';

import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';

class AddPropertyScreen extends StatelessWidget {
  const AddPropertyScreen({super.key});

  void _submit(BuildContext context) {
    final vm = context.read<AddPropertyViewModel>();

    if (!vm.isFormValid) return;

    context.read<PropertyCubit>().addProperty(vm: vm);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_) => AddPropertyViewModel(),
      child: BlocListener<PropertyCubit, PropertyState>(
        listener: (context, state) {
          if (state is PropertySuccess) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => SuccessDialog(
                onDone: () {
                  Navigator.pop(context);
                  context.read<AddPropertyViewModel>().reset();
                },
              ),
            );
          }

          if (state is PropertyError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Consumer<AddPropertyViewModel>(
          builder: (context, vm, _) {
            return Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                backgroundColor: AppColors.white,
                elevation: 0,
                leadingWidth: 90,
                toolbarHeight: 70,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).maybePop(),
                    borderRadius: BorderRadius.circular(12),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white70,
                      child: Icon(Icons.arrow_back, color: Colors.black54),
                    ),
                  ),
                ),
                title: const Text(
                  'Add Property',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              body: Stack(
                children: [
                  GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 8),
                          const PropertyTypeSelector(),
                          const SizedBox(height: 12),

                          if (!vm.isTypeSelected)
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                              ),
                              padding: EdgeInsets.all(screenWidth * 0.035),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(
                                  screenWidth * 0.035,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                height: screenHeight * 0.18,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: screenWidth * 0.09,
                                      color: AppColors.gold,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'List Your Property',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'Fill in the details about your property. All listings are reviewed by admin before publishing.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          if (vm.isTypeSelected) ...[
                            const BasicInfoSection(),
                            const PropertyDetailsSection(),
                            const ImagesSection(),
                            const DescriptionSection(),
                            const SizedBox(height: 18),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                side: const BorderSide(color: Colors.white70),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              onPressed: () => vm.reset(),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: vm.isFormValid
                                            ? AppColors.gold
                                            : Colors.grey.shade300,
                                        foregroundColor: vm.isFormValid
                                            ? Colors.black
                                            : Colors.black38,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                      ),
                                      onPressed: vm.isFormValid
                                          ? () => _submit(context)
                                          : null,
                                      child: const Text(
                                        'Send To Admin',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (context.watch<PropertyCubit>().state is PropertyLoading)
                    Container(
                      color: Colors.black26,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
