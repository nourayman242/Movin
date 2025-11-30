import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movin/presentation/budget_calculator/widgets/input_card.dart';
import 'package:movin/presentation/budget_calculator/widgets/monthely_payment_card.dart';
import 'package:movin/presentation/budget_calculator/widgets/payment_break_down_card.dart';

class BudgetCalculatorScreen extends StatelessWidget {
  BudgetCalculatorScreen({Key? key}) : super(key: key);

  final LoanCalcBloc bloc = GetIt.instance<LoanCalcBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text('Budget Calculator' , style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          centerTitle: true,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 700) {
              //large -> horizontal
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.large),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: InputsCard()),
                    const SizedBox(width: AppSpacing.large),
                    Expanded(
                      child: Column(
                        children: const [
                          MonthlyPaymentCard(),
                          SizedBox(height: AppSpacing.large),
                          PaymentBreakdownCard(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              //not large like mobile ->vertial
              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    InputsCard(),
                    SizedBox(height: AppSpacing.large),
                    MonthlyPaymentCard(),
                    SizedBox(height: AppSpacing.large),
                    PaymentBreakdownCard(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
