part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  const UserState({
    this.authStatus = StateStatus.init,
    this.status = StateStatus.init,
    this.user,
  });

  factory UserState.logout() => UserState(
    authStatus: StateStatus.failed,
    status: StateStatus.init,
  );

  final StateStatus authStatus;
  final StateStatus status;
  final UserModel? user;

  UserState copyWith({
    StateStatus? authStatus,
    StateStatus? status,
    UserModel? user,
  }) {
    return UserState(
      authStatus: authStatus ?? this.authStatus,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        authStatus,
        status,
        user,
      ];
}
