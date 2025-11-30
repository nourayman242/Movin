import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_bloc.dart';
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_state.dart';

class PaymentBreakdownCard extends StatelessWidget {
  const PaymentBreakdownCard({Key? key}) : super(key: key);

  String _formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanCalcBloc, LoanCalcState>(
      buildWhen: (prev, curr) =>
          prev.totalPayment != curr.totalPayment ||
          prev.totalInterest != curr.totalInterest ||
          prev.noOfPayments != curr.noOfPayments,
      builder: (context, state) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payment Breakdown', style: AppTextStyles.heading),
                const SizedBox(height: AppSpacing.medium),
                _breakdownRow(
                  icon: Icons.attach_money,
                  color: Colors.blue.shade300,
                  label: 'Total Payment',
                  value: _formatCurrency(state.totalPayment),
                ),
                const SizedBox(height: AppSpacing.medium),
                _breakdownRow(
                  icon: Icons.percent,
                  color: Colors.orange.shade300,
                  label: 'Total Interest',
                  value: _formatCurrency(state.totalInterest),
                ),
                const SizedBox(height: AppSpacing.medium),
                _breakdownRow(
                  icon: Icons.calendar_today,
                  color: Colors.green.shade300,
                  label: 'Number of Payments',
                  value: '${state.noOfPayments} months',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _breakdownRow({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: AppTextStyles.subHeading)),
        Text(
          value,
          style: AppTextStyles.label,
        )
      ],
    );
  }
}