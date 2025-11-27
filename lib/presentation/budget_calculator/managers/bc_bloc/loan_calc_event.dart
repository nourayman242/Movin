import 'package:equatable/equatable.dart';

class LoanCalcEvent extends Equatable {
  const LoanCalcEvent();

  @override
  List<Object> get props => [];
}
// 4 Events for updating loan parameters (inputs to the calculator)

class PropertyPriceChanged extends LoanCalcEvent {
  final double propertyPrice;
  const PropertyPriceChanged(this.propertyPrice);
  @override
  List<Object> get props => [propertyPrice];
}

class DownPaymentChanged extends LoanCalcEvent {
  final double downPayment;
  const DownPaymentChanged(this.downPayment);
  @override
  List<Object> get props => [downPayment];
}
class InterestRateChanged extends LoanCalcEvent {
  final double interestRate;
  const InterestRateChanged(this.interestRate);
  @override
  List<Object> get props => [interestRate];
}
class LoanTermYearsChanged extends LoanCalcEvent {
  final int loanTermYears;
  const LoanTermYearsChanged(this.loanTermYears);
  @override
  List<Object> get props => [loanTermYears];
}
