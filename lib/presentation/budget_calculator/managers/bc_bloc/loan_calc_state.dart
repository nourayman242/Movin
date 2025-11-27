import 'package:equatable/equatable.dart';
import 'package:movin/domain/entities/loan_model.dart';
import 'dart:math';

class LoanCalcState extends Equatable {
  final LoanModel loan;
  final double downPaymentAmount;
  final double loanAmount;
  final double monthlyPayment;
  final double totalInterest;
  final double totalPayment;
  final int noOfPayments;

  const LoanCalcState({
    required this.loan,
    required this.downPaymentAmount,
    required this.loanAmount,
    required this.monthlyPayment,
    required this.totalInterest,
    required this.totalPayment,
    required this.noOfPayments,
  });

  //initial
  factory LoanCalcState.initial() {
    final loan = LoanModel(
      propertyPrice: 0.0,
      downPayment: 0.0,
      interestRate: 0.0,
      loanTermYears: 5,
    );

    return LoanCalcState._calculate(loan);
  }

  //calculated outputs
  factory LoanCalcState._calculate(LoanModel loan) {
    final downPaymentAmount = loan.propertyPrice * loan.downPayment / 100;
    final loanAmount = loan.propertyPrice - downPaymentAmount;
    final monthlyInterestRate = loan.interestRate / 100 / 12;
    final numberOfPayments = loan.loanTermYears * 12;

    // initialize outputs with safe defaults
    double monthlyPayment = 0.0;
    double totalPayment = 0.0;
    double totalInterest = 0.0;

    if (numberOfPayments > 0 && loanAmount > 0) {
      if (monthlyInterestRate == 0) {
        monthlyPayment = loanAmount / numberOfPayments;
      } else {
        // amortization formula
        final num factor = pow(1 + monthlyInterestRate, numberOfPayments);
        // guard denominator (factor - 1) in case of numeric edge cases
        final double denom = factor - 1;
        if (denom != 0) {
          monthlyPayment = loanAmount * (monthlyInterestRate * factor) / denom;
        } else {
          monthlyPayment = 0.0;
        }
      }

      if (!monthlyPayment.isFinite) monthlyPayment = 0.0;

      totalPayment = monthlyPayment * numberOfPayments;
      totalInterest = totalPayment - loanAmount;
      if (!totalPayment.isFinite) totalPayment = 0.0;
      if (!totalInterest.isFinite) totalInterest = 0.0;
    }
    // else {
    //   monthlyPayment = 0.0;
    //   totalPayment = 0.0;
    //   totalInterest = 0.0;
    // }

    return LoanCalcState(
      loan: loan,
      downPaymentAmount: downPaymentAmount,
      loanAmount: loanAmount,
      monthlyPayment: monthlyPayment,
      totalPayment: totalPayment,
      totalInterest: totalInterest,
      noOfPayments: numberOfPayments,
    );
  }
  // copy with creates a new instance with updated values
  LoanCalcState copyWith({LoanModel? loan}) {
    return LoanCalcState._calculate(loan ?? this.loan);
  }

  // Equatable props to compare instances
  @override
  List<Object?> get props => [
    loan,
    downPaymentAmount,
    loanAmount,
    monthlyPayment,
    totalInterest,
    totalPayment,
    noOfPayments,
  ];
}
