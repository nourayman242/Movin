import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/domain/repositories/role_repository.dart';
import 'package:movin/presentation/role_selection/manager/role_bloc/role_event.dart';
import 'package:movin/presentation/role_selection/manager/role_bloc/role_state.dart';
import 'package:movin/core/errors/failure.dart';

@injectable
class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final RoleRepository repo;

  RoleBloc(this.repo) : super(RoleInitial()) {
    on<ChooseRoleEvent>(_chooseRole);
  }

  Future<void> _chooseRole(
    ChooseRoleEvent event,
    Emitter<RoleState> emit,
  ) async {
    emit(RoleLoading());

    try {
      await repo.chooseRole(event.role);
      await SharedHelper.setUserRole(event.role);
      emit(RoleSuccess(event.role));
      // } catch (e) {
      //   emit(RoleError('Failed to choose role'));
      // }
    } catch (e) {
      // print('ROLE ERROR => $e');
      // emit(RoleError(e.toString()));
      if (e is Failure) {
        emit(RoleError(e.message));
      } else {
        emit(RoleError('Unknown error occurred'));
      }
    }
  }
}
