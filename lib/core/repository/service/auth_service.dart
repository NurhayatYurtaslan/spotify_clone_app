import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify_clone_app/core/repository/model/auth/signin/signin_request_model.dart';
import 'package:spotify_clone_app/core/repository/model/auth/signup/signup_request_model.dart';

//tüm auth islemleri, kayit ol, giris yap, cikis yap,  giris yaptigin bilgileri var mı kontrol et
class AuthService {
  // FirebaseAuth ve FirebaseFirestore örneklerinin oluşturulması.
  final FirebaseAuth _auth = FirebaseAuth.instance; //baglanıyoruz  auth
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; //baglanıyoruz firestore

  // Kullanıcı kaydı işlemini gerçekleştiren fonksiyon.
  Future signUp(SignUpRequestModel signUpRequestModel) async {
    // Kullanıcının e-posta ve şifre ile Firebase'e kaydını sağlar.
    final UserCredential
        userCredential = // kullanıcının kimlik bilgilerini ve Firebase’e giriş yaparken kullanılan yöntemi içerir.
        await _auth.createUserWithEmailAndPassword(
            email: signUpRequestModel.email,
            password: signUpRequestModel.password);

    // Kayıt işlemi sonrası dönen kullanıcı bilgileri.
    final User? user = userCredential.user;
    if (user == null) {
      throw Exception("User is null");
    }

    // Kullanıcının bilgilerini Firestore'daki "users" koleksiyonuna ekler.
    await _firestore.collection("users").doc(user.uid).set(({
          "name": signUpRequestModel.name,
          "email": signUpRequestModel.email,
        }));

    return signUpRequestModel;
  }

// Kullanıcının e-posta ve şifre ile Firebase'e giriş yapmasını sağlar.
  Future signIn(SignInRequestModel signInRequestModel) async {
    final UserCredential
        userCredential = //kullanıcının kimlik bilgilerini ve Firebase’e giriş yaparken kullanılan yöntemi içerir
        await _auth.signInWithEmailAndPassword(
            email: signInRequestModel.email,
            password: signInRequestModel.password);

    // Giriş işlemi sonrası dönen kullanıcı bilgileri.
    final User? user = userCredential.user;
    if (user == null) {
      throw Exception("User is null");
    }
  }

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

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(cred);

      // Kullanıcı bilgilerini Firestore'a kaydet (isteğe bağlı)
      await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set({
        "name": googleUser.displayName,
        "email": googleUser.email,
      }, SetOptions(merge: true));

      return userCredential.user;
    } catch (e) {
      // Hata yönetimi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }
}
