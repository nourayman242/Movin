import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/domain/entities/loan_model.dart';
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_event.dart';
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_state.dart';

@injectable
class LoanCalcBloc extends Bloc<LoanCalcEvent, LoanCalcState> {
  LoanCalcBloc() : super(LoanCalcState.initial()){
    on<PropertyPriceChanged>(_onPropertyPriceChanged);
    on<DownPaymentChanged>(_onDownPaymentChanged);
    on<InterestRateChanged>(_onInterestRateChanged);
    on<LoanTermYearsChanged>(_onLoanTermChanged);
  }

  void _onPropertyPriceChanged(
      PropertyPriceChanged event, Emitter<LoanCalcState> emit) {
    final newLoan = LoanModel(
      propertyPrice: event.propertyPrice,
      downPayment: state.loan.downPayment,
      interestRate: state.loan.interestRate,
      loanTermYears: state.loan.loanTermYears,
    );

    emit(state.copyWith(loan: newLoan));
  }
  void _onDownPaymentChanged(
      DownPaymentChanged event, Emitter<LoanCalcState> emit) {
    final newLoan = LoanModel(
      propertyPrice: state.loan.propertyPrice,
      downPayment: event.downPayment,
      interestRate: state.loan.interestRate,
      loanTermYears: state.loan.loanTermYears,
    );

    emit(state.copyWith(loan: newLoan));
  }

  void _onInterestRateChanged(
      InterestRateChanged event, Emitter<LoanCalcState> emit) {
    final newLoan = LoanModel(
      propertyPrice: state.loan.propertyPrice,
      downPayment: state.loan.downPayment,
      interestRate: event.interestRate,
      loanTermYears: state.loan.loanTermYears,
    );

    emit(state.copyWith(loan: newLoan));
  }

  void _onLoanTermChanged(
      LoanTermYearsChanged event, Emitter<LoanCalcState> emit) {
    final newLoan = LoanModel(
      propertyPrice: state.loan.propertyPrice,
      downPayment: state.loan.downPayment,
      interestRate: state.loan.interestRate,
      loanTermYears: event.loanTermYears,
    );

    emit(state.copyWith(loan: newLoan));
  }

  
}
