import 'dart:convert';
import 'dart:io';

import 'package:advance_login_mock/core/enums/update_user.dart';
import 'package:advance_login_mock/core/error/exceptions.dart';
import 'package:advance_login_mock/core/utils/constants.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/auth/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> forgotPassword(String email);

  Future<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });

  Future<void> signOut();
}

/* -------------------------------------------------------------------------- */

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  const AuthRemoteDataSourceImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _auth = auth,
        _firestore = firestore,
        _storage = storage;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? "Error Occured",
        statusCode: e.code,
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: "505",
      );
    }
  }

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;

      if (user == null) {
        throw const ServerException(
          message: 'Please try again later',
          statusCode: 'Unknown Error',
        );
      }

      var userData = await _getUserData(user.uid);
      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }
      await _setUserData(user, email);

      userData = await _getUserData(user.uid);

      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? "Error Occured",
        statusCode: e.code,
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: "505",
      );
    }
  }

  @override
  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final userCred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userCred.user?.updateDisplayName(fullName);
      await userCred.user?.updatePhotoURL(kDefaultAvatar);
      await _setUserData(_auth.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? "Error Occured",
        statusCode: e.code,
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: "505",
      );
    }
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserAction.email:
          await _auth.currentUser?.verifyBeforeUpdateEmail(userData as String);
          await _updateUserData({"email": userData});
        case UpdateUserAction.displayName:
          await _auth.currentUser?.updateDisplayName(userData as String);
          await _updateUserData({"fullName": userData});
        case UpdateUserAction.profilePic:
          final ref =
              _storage.ref().child("profile_pics/${_auth.currentUser?.uid}");

          await ref.putFile(userData as File);
          final url = await ref.getDownloadURL();
          await _auth.currentUser?.updatePhotoURL(url);
          await _updateUserData({'profilePic': url});
        case UpdateUserAction.password:
          if (_auth.currentUser?.email == null) {
            throw const ServerException(
              message: 'User does not exist',
              statusCode: 'Insufficient Permission',
            );
          }
          final newData = jsonDecode(userData as String) as DataMap;
          await _auth.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _auth.currentUser!.email!,
              password: newData['oldPassword'] as String,
            ),
          );
          await _auth.currentUser?.updatePassword(
            newData['newPassword'] as String,
          );
        case UpdateUserAction.bio:
          await _updateUserData({'bio': userData as String});
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? "Error Occured",
        statusCode: e.code,
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: "505",
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? "Error Occured",
        statusCode: e.code,
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: "505",
      );
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return await _firestore.collection("users").doc(uid).get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _firestore.collection("users").doc(user.uid).set(LocalUserModel(
          uid: user.uid,
          email: user.email ?? fallbackEmail,
          fullName: user.displayName ?? "",
          profilePic: user.photoURL ?? "",
          totalFollowers: 0,
          totalFollowing: 0,
          totalPosts: 0,
        ).toMap());
  }

  Future<void> _updateUserData(DataMap data) async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser?.uid)
        .update(data);
  }
}
