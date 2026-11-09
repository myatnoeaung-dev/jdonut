import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/bloc/page_status.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/member.dart';
import '../../../domain/usecases/watch_current_member_use_case.dart';

part 'member_bloc.freezed.dart';
part 'member_event.dart';
part 'member_state.dart';

/// The member's tier and points from the local database. Home, Rewards and
/// Settings each use one, so every screen shows the same record.
@injectable
class MemberBloc extends Bloc<MemberEvent, MemberState> {
  MemberBloc(this._watchCurrentMember) : super(const MemberState()) {
    on<MemberStarted>(_onStarted, transformer: restartable());
  }

  final WatchCurrentMemberUseCase _watchCurrentMember;

  Future<void> _onStarted(MemberStarted event, Emitter<MemberState> emit) async {
    emit(state.copyWith(status: PageStatus.loading));
    await emit.forEach(
      _watchCurrentMember(const NoParams()),
      onData: (result) => result.match(
        (failure) => state.copyWith(status: PageStatus.error, failure: failure),
        (member) => state.copyWith(status: PageStatus.success, member: member, failure: null),
      ),
    );
  }
}
