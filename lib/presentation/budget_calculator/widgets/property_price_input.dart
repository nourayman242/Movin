import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_bloc.dart';
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_event.dart';

class PropertyPriceInput extends StatefulWidget {
  const PropertyPriceInput({super.key});

  @override
  State<PropertyPriceInput> createState() => _PropertyPriceInputState();
}

class _PropertyPriceInputState extends State<PropertyPriceInput> {
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final loanPrice = context
        .read<LoanCalcBloc>()
        .state
        .loan
        .propertyPrice
        .toInt();
    _controller = TextEditingController(
      text: loanPrice > 0 ? loanPrice.toString() : '',
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // update text controller
    final loanPrice = context
        .read<LoanCalcBloc>()
        .state
        .loan
        .propertyPrice
        .toInt();

    if (loanPrice > 0) {
      _controller.text = loanPrice.toString();
    } else {
      _controller.text = '';
    }
    // if (_controller.text != loanPrice.toString()) {
    //   _controller.text = loanPrice.toString();
    // }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      final parsed = double.tryParse(value.replaceAll(',', '')) ?? 0.0;
      final double clamped = parsed.clamp(0, double.infinity);

      context.read<LoanCalcBloc>().add(PropertyPriceChanged(clamped));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Property Price', style: AppTextStyles.label),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: AppInputDecoration.rounded(
            hintText: 'Enter property price',
            prefixIcon: Icons.attach_money,
          ),
          onChanged: _onChanged,
          onEditingComplete: () {
            _debounce?.cancel();
            final parsed =
                double.tryParse(_controller.text.replaceAll(',', '')) ?? 0.0;
            context.read<LoanCalcBloc>().add(
              PropertyPriceChanged(parsed.clamp(0, double.infinity)),
            );
            // hide keyboard
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }
}
