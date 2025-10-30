import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Đăng ký email/password
  Future<User?> signUp(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credential.user;
  }

  // Đăng nhập email/password
  Future<User?> signIn(String email, String password) async {
    final credential =
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  // Đăng xuất
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Lấy user hiện tại
  User? get currentUser => _auth.currentUser;
}
