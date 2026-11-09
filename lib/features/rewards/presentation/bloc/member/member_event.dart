part of 'member_bloc.dart';

sealed class MemberEvent extends Equatable {
  const MemberEvent();

  @override
  List<Object?> get props => [];
}

/// Start (or restart, after an error) following the member record.
final class MemberStarted extends MemberEvent {
  const MemberStarted();
}
