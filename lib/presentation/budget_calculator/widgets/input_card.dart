import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_bloc.dart';
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_event.dart';
import 'package:movin/presentation/budget_calculator/widgets/property_price_input.dart';
import 'package:movin/presentation/budget_calculator/widgets/slider_input.dart';

class InputsCard extends StatelessWidget {
  const InputsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.large,
          horizontal: AppSpacing.medium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Loan Details', style: AppTextStyles.heading),
            const SizedBox(height: AppSpacing.medium),
            PropertyPriceInput(),
            const SizedBox(height: AppSpacing.medium),
            SliderInput(
              label: 'Down Payment',
              min: 0,
              max: 50,
              valueSelector: (state) => state.loan.downPayment,
              valueFormatter: (v) => '${v.toStringAsFixed(0)}%',
              onChanged: (context, v) =>
                  context.read<LoanCalcBloc>().add(DownPaymentChanged(v)),
            ),
            const SizedBox(height: AppSpacing.medium),
            SliderInput(
              label: 'Interest Rate',
              min: 0,
              max: 10,
              valueSelector: (state) => state.loan.interestRate,
              valueFormatter: (v) => '${v.toStringAsFixed(2)}%',
              onChanged: (context, v) =>
                  context.read<LoanCalcBloc>().add(InterestRateChanged(v)),
            ),
            const SizedBox(height: AppSpacing.medium),
            SliderInput(
              label: 'Loan Term',
              min: 5,
              max: 30,
              isInt: true,
              valueSelector: (state) => state.loan.loanTermYears.toDouble(),
              valueFormatter: (v) => '${v.toInt()} years',
              onChanged: (context, v) =>
                  context.read<LoanCalcBloc>().add(LoanTermYearsChanged(v.toInt())),
            ),
          ],
        ),
      ),
    );
  }
}