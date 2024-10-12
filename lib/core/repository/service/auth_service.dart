import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modern_snackbar/modern_snackbar.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/repository/model/auth/signin/signin_request_model.dart';
import 'package:spotify_clone_app/core/repository/model/auth/signup/signup_request_model.dart';

// Tüm auth işlemleri: kayıt ol, giriş yap, çıkış yap, giriş bilgilerini kontrol et
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kullanıcı kaydı işlemini gerçekleştiren fonksiyon.
  Future<void> signUp(SignUpRequestModel signUpRequestModel) async {
    final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: signUpRequestModel.email,
      password: signUpRequestModel.password,
    );

    final User? user = userCredential.user;
    if (user == null) {
      throw Exception("User is null");
    }

    await _firestore.collection("users").doc(user.uid).set({
      "name": signUpRequestModel.name,
      "email": signUpRequestModel.email,
    });
  }

  // Kullanıcının e-posta ve şifre ile giriş yapmasını sağlar.
  Future<void> signIn(SignInRequestModel signInRequestModel) async {
    final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: signInRequestModel.email,
      password: signInRequestModel.password,
    );

    final User? user = userCredential.user;
    if (user == null) {
      throw Exception("User is null");
    }
  }

  // Google ile giriş yapma işlemi.
  Future<User?> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception("Login with Google has been canceled");
      }

      final googleAuth = await googleUser.authentication;

      if (googleAuth.idToken == null && googleAuth.accessToken == null) {
        throw Exception("Failed to obtain access tokens");
      }

      final cred = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(cred);

      // Kullanıcı bilgilerini Firestore'a kaydet (isteğe bağlı)
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "name": googleUser.displayName,
        "email": googleUser.email,
      }, SetOptions(merge: true));

      return userCredential.user;
    } catch (e) {
      // Hata yönetimi
      _handleError(context, e);
      return null;
    }
  }

  // Hata yönetimi ve snackbar gösterimi
  void _handleError(BuildContext context, Object error) {
    String message = error.toString();
    if (context.mounted) {
      ModernSnackbar(
        title: 'Error',
        titleColor: AppColors.errorColor,
        description: message,
        backgroundColor: AppColors.errorColor,
        icon: Icons.error,
      ).show(context);
    }
  }
}