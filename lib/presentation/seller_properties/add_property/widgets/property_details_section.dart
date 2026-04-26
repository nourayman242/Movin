// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../add_property_viewmodel.dart';
// import 'package:movin/app_theme.dart';

// class PropertyDetailsSection extends StatelessWidget {
//   const PropertyDetailsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final vm = context.watch<AddPropertyViewModel>();
//     final t = vm.selectedType;

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Property Details',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),

//           // Residential types: bedrooms + bathrooms
//           if (t == PropertyType.apartment ||
//               t == PropertyType.villa ||
//               t == PropertyType.townhouse ||
//               t == PropertyType.penthouse) ...[
//             Row(
//               children: [
//                 Text(
//                   'Number of Bedrooms *',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey.shade700,
//                   ),
//                 ),
//                 Spacer(),
//                 Text(
//                   'Number of Bathrooms *',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey.shade700,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: vm.bedroomsController,
//                     keyboardType: TextInputType.number,
//                     decoration: AppInputDecoration.rounded(hintText: 'e.g,3'),
//                     onChanged: (_) => vm.notifyListeners(),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: TextFormField(
//                     controller: vm.bathroomsController,
//                     keyboardType: TextInputType.number,
//                     decoration: AppInputDecoration.rounded(hintText: 'e.g,2'),
//                     onChanged: (_) => vm.notifyListeners(),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             if(t == PropertyType.villa) ...[
//                Text(
//               'Number Of Floors*',
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey.shade700,
//               ),
//             ),
//             TextFormField(
//               controller: vm.numOfFloorController,
//               keyboardType: TextInputType.number,
//               decoration: AppInputDecoration.rounded(hintText: 'e.g,5'),
//               onChanged: (_) => vm.notifyListeners(),
//             ),
//             const SizedBox(height: 12),
//             ],
//             if (t != PropertyType.villa) ...[
//             Text(
//               'Floor Number *',
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey.shade700,
//               ),
//             ),
//             TextFormField(
//               controller: vm.floorController,
//               keyboardType: TextInputType.number,
//               decoration: AppInputDecoration.rounded(hintText: 'e.g,5'),
//               onChanged: (_) => vm.notifyListeners(),
//             ),
//             ],

//             const SizedBox(height: 12),

//             if (t == PropertyType.villa) ...[
//               Text(
//                 'Land Area (sqft) *',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey.shade700,
//                 ),
//               ),
//               TextFormField(
//                 controller: vm.landAreaController,
//                 keyboardType: TextInputType.number,
//                 decoration: AppInputDecoration.rounded(hintText: 'e.g,4000'),
//                 onChanged: (_) => vm.notifyListeners(),
//               ),
//               const SizedBox(height: 12),
//             ],
//             if (t == PropertyType.apartment ) ...[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Elevator Available',
//                           style: TextStyle(color: Colors.black87),
//                         ),
//                         Text(
//                           'Does the building have an elevator?',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Switch(
//                     inactiveThumbColor: AppColors.white,
//                     inactiveTrackColor: const Color.fromARGB(
//                       255,
//                       228,
//                       226,
//                       226,
//                     ),
//                     activeColor: AppColors.gold,
//                     value: vm.elevator,
//                     onChanged: (v) => vm.setElevator(v),
//                   ),
//                 ],
//               ),
//             ],
//             if (t == PropertyType.villa) ...[
//               const SizedBox(height: 12),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Garden Available',
//                           style: TextStyle(color: Colors.black87),
//                         ),
//                         Text(
//                           'Does the villa have a garden?',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Switch(
//                     inactiveThumbColor: AppColors.white,
//                     inactiveTrackColor: const Color.fromARGB(
//                       255,
//                       228,
//                       226,
//                       226,
//                     ),
//                     activeColor: AppColors.gold,
//                     value: vm.garden,
//                     onChanged: (v) => vm.setGarden(v),
//                   ),
//                 ],
//               ),
//             ],
//             if (t == PropertyType.villa) ...[
//               const SizedBox(height: 12),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Parking Available',
//                           style: TextStyle(color: Colors.black87),
//                         ),
//                         Text(
//                           'Does the villa have parking space?',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Switch(
//                     inactiveThumbColor: AppColors.white,
//                     inactiveTrackColor: const Color.fromARGB(
//                       255,
//                       228,
//                       226,
//                       226,
//                     ),
//                     activeColor: AppColors.gold,
//                     value: vm.parking,
//                     onChanged: (v) => vm.setParking(v),
//                   ),
//                 ],
//               ),
//             ],
//           ],

//           // Office
//           if (t == PropertyType.office) ...[
//             Text(
//                 'office Size (sqft) *',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey.shade700,
//                 ),
//               ),
//             TextFormField(
//               controller: vm.officeSizeController,
//               decoration: AppInputDecoration.rounded(
//                 hintText: 'e.g,2500 *',
//               ),
//               onChanged: (_) => vm.notifyListeners(),
//             ),
//             const SizedBox(height: 12),
//             Text(
//                 'Floor Number *',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey.shade700,
//                 ),
//               ),
//             TextFormField(
//               controller: vm.floorController,
//               keyboardType: TextInputType.number,
//               decoration: AppInputDecoration.rounded(
//                 hintText: 'e.g,5',
//               ),
//               onChanged: (_) => vm.notifyListeners(),
//             ),
//              Row(
//               children: [
//                 Text(
//                   'Number of Work Rooms *',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey.shade700,
//                   ),
//                 ),
//                 Spacer(),
//                 Text(
//                   'Meeting Rooms *',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey.shade700,
//                   ),
//                 ),
//               ],
//             ),
//              Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: vm.workroomsController,
//                     keyboardType: TextInputType.number,
//                     decoration: AppInputDecoration.rounded(hintText: 'e.g,8'),
//                     onChanged: (_) => vm.notifyListeners(),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: TextFormField(
//                     controller: vm.meetingroomsController,
//                     keyboardType: TextInputType.number,
//                     decoration: AppInputDecoration.rounded(hintText: 'e.g,3'),
//                     onChanged: (_) => vm.notifyListeners(),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Text(
//                 'Parking Spaces *',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey.shade700,
//                 ),
//               ),
//             TextFormField(
//               controller: vm.officParkingController,
//               decoration: AppInputDecoration.rounded(
//                 hintText: 'e.g,10*',
//               ),
//               onChanged: (_) => vm.notifyListeners(),
//             ),
//           ],

//           // Penthouse extras
//           if (t == PropertyType.penthouse) ...[
//             const SizedBox(height: 12),
//             Text(
//               'Terrace Area (sqft) *',
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey.shade700,
//               ),
//             ),
//             TextFormField(
//               controller: vm.terraceController,
//               keyboardType: TextInputType.number,
//               decoration: AppInputDecoration.rounded(
//                 hintText: 'e.g,1500',
//               ),
//               onChanged: (_) => vm.notifyListeners(),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../add_property_viewmodel.dart';
import 'package:movin/app_theme.dart';

class PropertyDetailsSection extends StatelessWidget {
  const PropertyDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddPropertyViewModel>();
    final t = vm.selectedType;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12.r),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Property Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),

          SizedBox(height: 10.h),

          /// ================= Residential =================
          if (t == PropertyType.apartment ||
              t == PropertyType.villa ||
              t == PropertyType.townhouse ||
              t == PropertyType.penthouse) ...[
            /// Labels row
            Row(
              children: [
                Expanded(
                  child: Text('Number of Bedrooms *', style: _labelStyle()),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text('Number of Bathrooms *', style: _labelStyle()),
                ),
              ],
            ),

            SizedBox(height: 6.h),

            /// Inputs row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: vm.bedroomsController,
                    keyboardType: TextInputType.number,
                    decoration: AppInputDecoration.rounded(hintText: 'e.g, 3'),
                    onChanged: (_) => vm.notifyListeners(),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextFormField(
                    controller: vm.bathroomsController,
                    keyboardType: TextInputType.number,
                    decoration: AppInputDecoration.rounded(hintText: 'e.g, 2'),
                    onChanged: (_) => vm.notifyListeners(),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            /// Floors
            if (t == PropertyType.villa) ...[
              Text('Number Of Floors*', style: _labelStyle()),
              SizedBox(height: 6.h),
              TextFormField(
                controller: vm.numOfFloorController,
                keyboardType: TextInputType.number,
                decoration: AppInputDecoration.rounded(hintText: 'e.g, 5'),
                onChanged: (_) => vm.notifyListeners(),
              ),
            ] else ...[
              Text('Floor Number*', style: _labelStyle()),
              SizedBox(height: 6.h),
              TextFormField(
                controller: vm.floorController,
                keyboardType: TextInputType.number,
                decoration: AppInputDecoration.rounded(hintText: 'e.g, 5'),
                onChanged: (_) => vm.notifyListeners(),
              ),
            ],

            SizedBox(height: 12.h),

            /// Land area
            if (t == PropertyType.villa) ...[
              Text('Land Area (m²) *', style: _labelStyle()),
              SizedBox(height: 6.h),
              TextFormField(
                controller: vm.landAreaController,
                keyboardType: TextInputType.number,
                decoration: AppInputDecoration.rounded(hintText: 'e.g, 4000'),
                onChanged: (_) => vm.notifyListeners(),
              ),
            ],

            SizedBox(height: 12.h),

            /// Switches
            if (t == PropertyType.apartment)
              _switchTile(
                title: 'Elevator Available',
                subtitle: 'Does the building have an elevator?',
                value: vm.elevator,
                onChanged: vm.setElevator,
              ),

            if (t == PropertyType.villa) ...[
              _switchTile(
                title: 'Garden Available',
                subtitle: 'Does the villa have a garden?',
                value: vm.garden,
                onChanged: vm.setGarden,
              ),
              SizedBox(height: 8.h),
              _switchTile(
                title: 'Parking Available',
                subtitle: 'Does the villa have parking space?',
                value: vm.parking,
                onChanged: vm.setParking,
              ),
            ],
          ],

          /// ================= Office =================
          if (t == PropertyType.office) ...[
            Text('Office Size (m²) *', style: _labelStyle()),
            SizedBox(height: 6.h),
            TextFormField(
              controller: vm.officeSizeController,
              keyboardType: TextInputType.number,
              decoration: AppInputDecoration.rounded(hintText: 'e.g, 2500'),
              onChanged: (_) => vm.notifyListeners(),
            ),

            SizedBox(height: 12.h),

            Text('Floor Number*', style: _labelStyle()),
            SizedBox(height: 6.h),
            TextFormField(
              controller: vm.floorController,
              keyboardType: TextInputType.number,
              decoration: AppInputDecoration.rounded(hintText: 'e.g, 5'),
              onChanged: (_) => vm.notifyListeners(),
            ),

            SizedBox(height: 12.h),

            /// Labels
            Row(
              children: [
                Expanded(
                  child: Text('Number of Work Rooms*', style: _labelStyle()),
                ),
                SizedBox(width: 12.w),
                Expanded(child: Text('Meeting Rooms*', style: _labelStyle())),
              ],
            ),

            SizedBox(height: 6.h),

            /// Inputs
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: vm.workroomsController,
                    keyboardType: TextInputType.number,
                    decoration: AppInputDecoration.rounded(hintText: 'e.g, 8'),
                    onChanged: (_) => vm.notifyListeners(),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextFormField(
                    controller: vm.meetingroomsController,
                    keyboardType: TextInputType.number,
                    decoration: AppInputDecoration.rounded(hintText: 'e.g, 3'),
                    onChanged: (_) => vm.notifyListeners(),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            /// Parking
            Text('Parking Spaces*', style: _labelStyle()),
            SizedBox(height: 6.h),
            TextFormField(
              controller: vm.officParkingController,
              keyboardType: TextInputType.number,
              decoration: AppInputDecoration.rounded(hintText: 'e.g, 10'),
              onChanged: (_) => vm.notifyListeners(),
            ),
          ],

          /// ================= Penthouse =================
          if (t == PropertyType.penthouse) ...[
            //SizedBox(height: 12.h),
            Text('Terrace Area (m²) *', style: _labelStyle()),
            SizedBox(height: 6.h),
            TextFormField(
              controller: vm.terraceController,
              keyboardType: TextInputType.number,
              decoration: AppInputDecoration.rounded(hintText: 'e.g, 1500'),
              onChanged: (_) => vm.notifyListeners(),
            ),
          ],
        ],
      ),
    );
  }

  /// ---------- Helpers ----------
  TextStyle _labelStyle() => TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade700,
  );

  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 14.sp)),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          activeColor: AppColors.gold,
          inactiveThumbColor: AppColors.white,
          inactiveTrackColor: Colors.grey.shade300,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
