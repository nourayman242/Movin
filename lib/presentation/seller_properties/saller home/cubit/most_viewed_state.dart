
import 'package:movin/domain/entities/property_entity.dart';

abstract class MostviewedState {}

class MostviewedInitial extends MostviewedState {}

class MostViewedLoading extends MostviewedState {}

class MostViewedLoaded extends MostviewedState {
  final List<PropertyEntity> properties;

  MostViewedLoaded(this.properties);
}

class MostViewedError extends MostviewedState {
  final String message;

  MostViewedError(this.message);
}