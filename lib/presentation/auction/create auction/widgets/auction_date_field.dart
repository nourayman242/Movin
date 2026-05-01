import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/app_theme.dart';

class AuctionDateField extends StatefulWidget {
  final String label;
  final String hint;
  final String subtitle;
  final Function(DateTime) onChanged;

  const AuctionDateField({
    super.key,
    required this.label,
    required this.hint,
    required this.subtitle,
    required this.onChanged,
  });

  @override
  State<AuctionDateField> createState() => _AuctionDateFieldState();
}

class _AuctionDateFieldState extends State<AuctionDateField> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _pickDateTime() async {
    // final date = await showDatePicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime.now(),
    //   lastDate: DateTime(2100),
    // );
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.gold),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (date == null) return;

    // final time = await showTimePicker(
    //   context: context,
    //   initialTime: TimeOfDay.now(),
    // );
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.gold,
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
            timePickerTheme: TimePickerThemeData(
              dialBackgroundColor: Colors.grey.shade100,
              hourMinuteTextColor: Colors.black,
              dialHandColor:AppColors.gold,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time == null) return;

    final result = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    _controller.text =
        "${date.day}/${date.month}/${date.year}  ${time.format(context)}";

    widget.onChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${widget.label} *"),
        SizedBox(height: 6.h),

        TextField(
          controller: _controller,
          readOnly: true,
          onTap: _pickDateTime,
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixIcon: const Icon(Icons.calendar_today),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        SizedBox(height: 4.h),
        Text(
          widget.subtitle,
          style: TextStyle(fontSize: 11.sp, color: Colors.grey),
        ),
      ],
    );
  }
}
