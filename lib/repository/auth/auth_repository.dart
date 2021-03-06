import 'package:cloud_firestore/cloud_firestore.dart';
import '/contants/paths.dart';
import '/models/appuser.dart';
import '/models/failure.dart';
import 'base_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection(Paths.users);

  AppUser? _appUser(User? user) {
    if (user == null) return null;
    return AppUser(
      uid: user.uid,
      name: user.displayName,
      imageUrl: user.photoURL,
      about: '',
      email: user.email,
    );
  }

  @override
  Stream<AppUser?> get onAuthChanges =>
      _firebaseAuth.userChanges().map((user) => _appUser(user));

  @override
  Future<AppUser?> get currentUser async => _appUser(_firebaseAuth.currentUser);

  String? get userId => _firebaseAuth.currentUser?.uid;

  String? get userImage => _firebaseAuth.currentUser?.photoURL;

  @override
  Future<AppUser?> signInWithGoogle() async {
    try {
// Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // final user = await _userRef.doc(userCredential.user?.uid).get();

      // print('User Exists ---- ${user.exists}');

      // if (!user.exists) {
      //   _userRef.doc(userCredential.user?.uid).set({
      //     'name': userCredential.user?.displayName ?? '',
      //     'imageUrl': userCredential.user?.photoURL,
      //     'about': '',
      //     'email': userCredential.user?.email ?? ''
      //   });
      // }

      return _appUser(userCredential.user);
    } on FirebaseAuthException catch (error) {
      print(error.toString());
      throw Failure(code: error.code, message: error.message!);
    } on PlatformException catch (error) {
      print(error.toString());
      throw Failure(code: error.code, message: error.message!);
    } catch (error) {
      throw const Failure(message: 'Something went wrong.Try again');
    }
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<AppUser?> signInWithApple() async {
    try {
// To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      // return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return _appUser(userCredential.user);
    } on FirebaseAuthException catch (error) {
      print(error.toString());
      throw Failure(code: error.code, message: error.message!);
    } on PlatformException catch (error) {
      print(error.toString());
      throw Failure(code: error.code, message: error.message!);
    } catch (error) {
      throw const Failure(message: 'Something went wrong.Try again');
    }
  }

  @override
  Future<AppUser?> signInWithPhoneNumber({required String phoneNo}) async {
    // AppUser? _appUser;
    late UserCredential? userCredential;
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential

          userCredential = await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
            throw Failure(code: e.code, message: e.message!);
          } else {
            throw Failure(code: e.code, message: e.message!);
          }
        },
        codeSent: (String? verificationId, int? resendToken) {
          print('VerificationID - $verificationId');
          print('Resend Token- $resendToken');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('codeAutoRetrievalTimeout VerificationID $verificationId');
        },
      );
      return _appUser(userCredential != null ? userCredential!.user : null);
    } on PlatformException catch (error) {
      print(error.toString());
      throw Failure(code: error.code, message: error.message!);
    } on FirebaseAuthException catch (error) {
      print(error.toString());
      throw Failure(code: error.code, message: error.message!);
    } catch (error) {
      print('Error in sign in with phone no ${error.toString()}');
      rethrow;
    }
  }

  Future<bool> verifyOtp(
      {required String otp, required String verificationId}) async {
    try {
      PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);

      print('Sms Code ------------ ${authCredential.smsCode}');
      if (authCredential.smsCode != null) {
        return true;
      }
      return false;
    } catch (error) {
      print('Error in verify otp ${error.toString()}');
      rethrow;
    }
  }

  Future<AppUser?> getUser(String? userId) async {
    AppUser? appUser;
    try {
      final user = await _userRef.doc(userId).get();
      final userData = user.data() as Map<String, dynamic>?;
      if (userData != null) {
        appUser = AppUser.fromMap(userData);
      }
      return appUser;
    } catch (error) {
      print('Error getting getUser ${error.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }
}
