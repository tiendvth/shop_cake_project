import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_google_state.dart';

class LoginGoogleCubit extends Cubit<LoginGoogleState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  LoginGoogleCubit() : super(LoginGoogleInitial());

  void saveTokenToSharedPreferences(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    // Lưu token đăng nhập vào storage hoặc database
    // Ví dụ: SharedPreferences, Firebase, hoặc API của ứng dụng
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      saveTokenToSharedPreferences(googleSignInAuthentication.accessToken!);
      print('Đăng nhập Google thành công: $googleSignInAccount');
      // Lưu token đăng nhập vào storage hoặc database
      // Ví dụ: SharedPreferences, Firebase, hoặc API của ứng dụng
      return googleSignInAccount;
    } catch (error) {
      print('Đăng nhập Google thất bại: $error');
      print('Đăng nhập Google thất bại: $error');
      return null;
    }
  }
}
