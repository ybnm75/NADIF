import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nadif/modal/user_modal.dart';
import 'package:nadif/screens/otp_screen.dart';
import 'package:nadif/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  //for signIn verification
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  //for Loading verification
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? _userId;

  String get userId => _userId!;

  UserModal? _userModal;
  UserModal get userModal => _userModal!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSign();
  }
// check SignIn Method
  void checkSign() async {
    final SharedPreferences e = await SharedPreferences.getInstance();
    _isSignedIn = e.getBool('is_signedIn') ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedIn",true);
    _isSignedIn = true;
    notifyListeners();
  }

  // SignInMethod

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

//VerifyOtp
  void verifyOtp(
      {required BuildContext context,
        required String userOtp,
        required String verificationId,
        required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential crds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(crds!)).user!;

      if (user != null) {
        _userId = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot fournisseurSnapshot =
    await _firebaseFirestore.collection("fournisseur").doc(_userId).get();

    DocumentSnapshot achteurSnapshot =
    await _firebaseFirestore.collection("achteur").doc(_userId).get();

    if (fournisseurSnapshot.exists || achteurSnapshot.exists) {
      print('User exists');
      return true;
    } else {
      print('New user');
      return false;
    }
  }

  void saveUserDataToFirebase(
      {required BuildContext context,
        required UserModal userModal,
        required Function onSuccess,
        required File profilePic}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // uploading image to firebase storage
      await storeFileToStorage("profilePick/$_userId", profilePic)
          .then((value) {
        userModal.profilePic = value;
        userModal.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      });
      _userModal = userModal;

      // lahn yesra upload to database
      await _firebaseFirestore
          .collection("fournisseur")
          .doc(_userId)
          .set(userModal.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
      await _firebaseFirestore
          .collection("achteur")
          .doc(_userId)
          .set(userModal.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });

    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> getDataFromFirestore() async {
    try {
      final docFournisseur = await _firebaseFirestore
          .collection('fournisseur')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      final docAchteur = await _firebaseFirestore
          .collection('achteur')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();

      if (docFournisseur.exists) {
        _userModal = UserModal(
          name: docFournisseur['name'],
          email: docFournisseur['email'],
          phoneNumber: docFournisseur['phoneNumber'],
          userId: _firebaseAuth.currentUser!.uid,
          profilePic: docFournisseur['profilePic'],
        );
      } else if (docAchteur.exists) {
        _userModal = UserModal(
          name: docAchteur['name'],
          email: docAchteur['email'],
          phoneNumber: docAchteur['phoneNumber'],
          userId: _firebaseAuth.currentUser!.uid,
          profilePic: docAchteur['profilePic'],
        );
      } else {
        // user doesn't exist in either collection
        _userModal = null;
      }
    } catch (e) {
      // handle error
      print(e.toString());
    }
  }
  // Now to store data locally we need the sharedPrefences Package
  Future saveUserDataToSP () async{
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user modal", jsonEncode(userModal.toMap()),);

  }

  Future getDataFromSP () async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString('user modal' ) ?? '';
    _userModal = UserModal.fromMap(jsonDecode(data),);
    _userId = _userModal!.userId;
    notifyListeners();
  }

  Future userSignOut() async{
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isLoading = false;
    notifyListeners();
    s.clear();


  }
}