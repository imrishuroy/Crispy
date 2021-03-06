import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/contants/paths.dart';
import '/models/failure.dart';
import '/repository/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository? _authRepository;

  LoginCubit({@required AuthRepository? authRepository})
      : _authRepository = authRepository,
        super(LoginState.initial());
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection(Paths.users);

  void loginWithPhone() async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      print('Phone number ------------- ${state.phoneNumber}');
      if (state.phoneNumber != null && state.countryCode != null) {
        await _authRepository?.signInWithPhoneNumber(
            phoneNo: '${state.countryCode}${state.phoneNumber!}');
        emit(state.copyWith(status: LoginStatus.succuss));
      } else {
        emit(state.copyWith(status: LoginStatus.error));
      }
    } catch (error) {
      print('Error in sign with phone $error');
    }
  }

  void phoneNumberChanged(String value) async {
    emit(state.copyWith(phoneNumber: value, status: LoginStatus.initial));
  }

  void otp(String value) async {
    emit(state.copyWith(otp: value, status: LoginStatus.initial));
  }

  void googleLogin() async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      final user = await _authRepository!.signInWithGoogle();

      if (user != null) {
        final doc = await usersRef.doc(user.uid).get();
        if (!doc.exists) {
          usersRef.doc(user.uid).set(user.toMap());
        }
      }

      emit(state.copyWith(status: LoginStatus.succuss));
    } on Failure catch (error) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          failure: Failure(message: error.message),
        ),
      );
    }
  }

  void appleLogin() async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      final user = await _authRepository!.signInWithApple();
      if (user != null) {
        final doc = await usersRef.doc(user.uid).get();
        if (!doc.exists) {
          usersRef.doc(user.uid).set(user.toMap());
        }
      }

      emit(state.copyWith(status: LoginStatus.succuss));
    } on Failure catch (error) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          failure: Failure(message: error.message),
        ),
      );
    }
  }
}
