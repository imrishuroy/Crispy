part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, succuss, error }

class LoginState extends Equatable {
  final LoginStatus? status;
  final Failure? failure;
  final String? phoneNumber;
  final String? otp;
  final String? countryCode;

  const LoginState({
    required this.status,
    required this.failure,
    required this.phoneNumber,
    required this.otp,
    required this.countryCode,
  });

  factory LoginState.initial() {
    return const LoginState(
      status: LoginStatus.initial,
      failure: Failure(),
      phoneNumber: '',
      otp: '',
      countryCode: '+91',
    );
  }

  @override
  bool? get stringify => true;

  LoginState copyWith({
    LoginStatus? status,
    Failure? failure,
    String? phoneNumber,
    String? otp,
    String? countryCode,
  }) {
    return LoginState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  List<Object?> get props => [status, failure, phoneNumber, otp, countryCode];
}
