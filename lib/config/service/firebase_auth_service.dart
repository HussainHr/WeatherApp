import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // This function for firebase sign up
  Future<User?> signUp(String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      await user?.updateDisplayName(name);
      await user?.reload();
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    }
    catch (e){
      throw e.toString();
    }
  }

  // This function for firebase login
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw e.toString();
    }
  }

  //This function for logout
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  //Check user login or not
  Future<bool> isLoggedIn() async {
    User? user = _firebaseAuth.currentUser;
    return user != null;
  }
}
