// lib/Service/User_Auth/AuthService.dart
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:japan_study/database/RudDatabase.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  auth.User? get currentUser => _auth.currentUser;

  Future<auth.UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final auth.UserCredential userCredential = await _auth
          .signInWithCredential(credential);

      if (userCredential.user != null) {
        // ✅ 통합 로직: RudDatabase를 통해 계정 정보만 동기화 [cite: 2026-01-22]
        await RudDatabase().saveAccount(
          userCredential.user!,
          "Test-Device-001",
        );
      }
      return userCredential;
    } catch (e) {
      print("RUD: 로그인 실패 - $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    RudDatabase().saveInitialize();
  }
}
