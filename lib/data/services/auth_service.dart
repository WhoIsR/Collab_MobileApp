/// Service untuk autentikasi pengguna.
/// TODO: Implementasi login/register dengan Supabase/Firebase.
class AuthService {
  /// Login dengan email dan password
  Future<void> signIn({required String email, required String password}) async {
    // TODO: Implementasi login
  }

  /// Register pengguna baru
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    // TODO: Implementasi register
  }

  /// Logout pengguna
  Future<void> signOut() async {
    // TODO: Implementasi logout
  }

  /// Cek status login
  bool get isLoggedIn {
    // TODO: Implementasi cek status
    return false;
  }
}
