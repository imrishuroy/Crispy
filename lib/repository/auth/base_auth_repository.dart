import '/models/appuser.dart';

abstract class BaseAuthRepository {
  Future<AppUser?> signInWithGoogle();
  Future<AppUser?> signInWithPhoneNumber({required String phoneNo});
  Future<AppUser?> get currentUser;
  Stream<AppUser?> get onAuthChanges;
  Future<void> signOut();
}
