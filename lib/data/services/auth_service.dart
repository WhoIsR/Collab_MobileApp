import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login dengan Email & Password
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'user-not-found':
          message = 'Email tidak terdaftar.';
          break;
        case 'wrong-password':
          message = 'Password salah.';
          break;
        case 'invalid-email':
          message = 'Format email tidak valid.';
          break;
        case 'user-disabled':
          message = 'Akun ini telah dinonaktifkan.';
          break;
        default:
          message = 'Gagal login. Periksa koneksi atau coba lagi.';
      }
      throw message;
    } catch (e) {
      throw "Terjadi kesalahan pada sistem: $e";
    }
  }

  // SignUp / Register Baru
  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'Password terlalu lemah.';
      } else if (e.code == 'email-already-in-use') {
        throw 'Email sudah terdaftar.';
      }
      throw e.message ?? "Gagal registrasi.";
    } catch (e) {
      throw "Terjadi kesalahan: $e";
    }
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Cek User yang sedang login
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
