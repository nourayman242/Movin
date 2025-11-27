import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_bloc.dart';

typedef ValueSelector = double Function(LoanCalcState state);
typedef ValueFormatter = String Function(double value);
typedef SliderChanged = void Function(BuildContext context, double value);

class SliderInput extends StatelessWidget {
  final String label;
  final double min;
  final double max;
  final bool isInt;
  final ValueSelector valueSelector;
  final ValueFormatter valueFormatter;
  final SliderChanged onChanged;

  const SliderInput({
    Key? key,
    required this.label,
    required this.min,
    required this.max,
    this.isInt = false,
    required this.valueSelector,
    required this.valueFormatter,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanCalcBloc, LoanCalcState>(
      buildWhen: (prev, curr) =>
          valueSelector(prev) != valueSelector(curr),
      builder: (context, state) {
        final currentValue = valueSelector(state);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(label, style: AppTextStyles.label),
                const Spacer(),
                Text(valueFormatter(currentValue), style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold)),
              ],
            ),
            Slider(
              min: min,
              max: max,
              divisions: isInt ? (max - min).toInt() : null,
              value: currentValue.clamp(min, max),
              activeColor: AppColors.primaryNavy,
              inactiveColor: Colors.grey.shade300,
              onChanged: (value) => onChanged(context, value),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(isInt ? min.toInt().toString() : min.toStringAsFixed(0)),
                Text(isInt ? max.toInt().toString() : max.toStringAsFixed(0)),
              ],
            )
          ],
        );
      },
    );
  }
}