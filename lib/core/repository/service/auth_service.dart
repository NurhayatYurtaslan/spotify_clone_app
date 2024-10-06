import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/core/repository/model/auth/signin/signin_request_model.dart';
import 'package:spotify_clone_app/core/repository/model/auth/signup/signup_request_model.dart';
import 'package:spotify_clone_app/core/repository/model/auth/user/user_response_model.dart';

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
          "name":signUpRequestModel.name,
          "email":signUpRequestModel.email,
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
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // Kullanıcı giriş yapma işlemini iptal etti.
      throw Exception("Login with Goggle has been canceled");
    }

    final googleAuth = await googleUser.authentication;

    if (googleAuth.idToken == null && googleAuth.accessToken == null) {
      // Tokenlar alınamadı
      throw Exception("Incorrect action taken");
    }

    final cred = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(cred);

    return userCredential.user;
  } catch (e) {
    // Hata durumunda kullanıcıya bilgi verin ve SignInPage'e geri dönün
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ),
    );
    
    // Geri dönme işlemi
    // ignore: use_build_context_synchronously
    context.router.push(const SigninViewRoute());
  }
  return null;
}


  // Kullanıcının çıkış yapmasını sağlayan fonksiyon.
  Future signOut() async {
    await _auth.signOut();
  }

// Kullanıcının giriş yapıp yapmadığını kontrol eden fonksiyon.
  Future<bool> isSignedIn() async {
    final User? user = _auth.currentUser;
    return user != null;
  }

  // Mevcut kullanıcının bilgilerini döndüren fonksiyon.
  Future<User?> getUser() async {
    return _auth.currentUser;
  }

  // Mevcut kullanıcının detaylı bilgilerini Firestore'dan alıp döndüren fonksiyon.
  Future<UserResponseModel> getUserDetail() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      throw Exception("User is null");
    }

// Firestore'dan kullanıcının detaylı bilgilerini alır.
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("users").doc(user.uid).get();

// Alınan bilgileri UserResponseModel nesnesine dönüştürür ve döndürür.
    return UserResponseModel.fromDocumentSnapshot(documentSnapshot);
  }
}