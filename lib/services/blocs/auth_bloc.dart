import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:AMP/services/api.dart';

/// events!
abstract class AuthEvent {}
class AuthRequested extends AuthEvent {}
class AuthLogIn extends AuthEvent {}
class AuthLogOut extends AuthEvent {}

/// states!
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}
class AuthInitial extends AuthState {}
class AuthLoadInProgress extends AuthState {}
class AuthLoaded extends AuthState {
  final bool isLoggedIn;

  AuthLoaded(this.isLoggedIn);

  @override
  List<Object> get props => [isLoggedIn];
}

/// mapping events to states!
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    final storage = new FlutterSecureStorage();
    if (event is AuthRequested) {
      yield AuthLoadInProgress();
      final token = await storage.read(key: "accessToken");
      API.accessToken = token;
      yield AuthLoaded(token != null);
    } else if (event is AuthLogIn) {
      yield AuthLoaded(true);
    } else if (event is AuthLogOut) {
      yield AuthLoaded(false);
    }
  }
}
