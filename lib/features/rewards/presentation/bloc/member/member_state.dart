part of 'member_bloc.dart';

@freezed
abstract class MemberState with _$MemberState {
  const factory MemberState({
    @Default(PageStatus.initial) PageStatus status,

    /// Kept while reloading, so the header never flickers empty.
    Member? member,
    Failure? failure,
  }) = _MemberState;
}
