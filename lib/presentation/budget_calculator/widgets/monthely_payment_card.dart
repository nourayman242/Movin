import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_bloc.dart';
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_state.dart';

class MonthlyPaymentCard extends StatelessWidget {
  const MonthlyPaymentCard({Key? key}) : super(key: key);

  String _formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanCalcBloc, LoanCalcState>(
      buildWhen: (previous, current) =>
          previous.monthlyPayment != current.monthlyPayment ||
          previous.loanAmount != current.loanAmount ||
          previous.downPaymentAmount != current.downPaymentAmount,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primaryNavy,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(AppSpacing.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Monthly Payment',
                  style: AppTextStyles.subHeading.copyWith(color: AppColors.white)),
              const SizedBox(height: 10),
              Text(
                _formatCurrency(state.monthlyPayment),
                style: TextStyle(
                  fontSize: 40,
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('per month',
                  style: AppTextStyles.smallText.copyWith(color: AppColors.white)),
              const SizedBox(height: AppSpacing.large),
              Row(
                children: [
                  _infoBox('Loan Amount', _formatCurrency(state.loanAmount)),
                  const SizedBox(width: AppSpacing.medium),
                  _infoBox('Down Payment', _formatCurrency(state.downPaymentAmount)),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _infoBox(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.navyLight,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: AppTextStyles.subHeading.copyWith(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTextStyles.heading.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}