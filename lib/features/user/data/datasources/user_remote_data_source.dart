import 'package:advance_login_mock/core/error/exceptions.dart';
import 'package:advance_login_mock/features/auth/data/model/user_model.dart';
import 'package:advance_login_mock/features/auth/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRemoteDataSource {
  const UserRemoteDataSource();

  Stream<List<LocalUserModel>> getSingleUser();

  Stream<List<LocalUserModel>> getAllUsers(LocalUser user);
}

/* -------------------------------------------------------------------------- */

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  const UserRemoteDataSourceImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  @override
  Stream<List<LocalUserModel>> getAllUsers(LocalUser user) {
    try {
      final userCollection = _firestore.collection("users");
      return userCollection.snapshots().map((querySnapshot) => querySnapshot
          .docs
          .map((snap) => LocalUserModel.fromSnapshot(snap))
          .toList());
    } on FirebaseException catch (e) {
      return Stream.error(
        ServerException(
          message: e.message ?? 'Unknown error occurred',
          statusCode: e.code,
        ),
      );
    } catch (e) {
      return Stream.error(
        ServerException(
          message: e.toString(),
          statusCode: '500',
        ),
      );
    }
  }

  @override
  Stream<List<LocalUserModel>> getSingleUser() {
    try {
      final userCollection = _firestore
          .collection("users")
          .where("uid", isEqualTo: _auth.currentUser!.uid)
          .limit(1);
      return userCollection.snapshots().map((querySnapshot) => querySnapshot
          .docs
          .map((e) => LocalUserModel.fromSnapshot(e))
          .toList());
    } on FirebaseException catch (e) {
      return Stream.error(
        ServerException(
          message: e.message ?? 'Unknown error occurred',
          statusCode: e.code,
        ),
      );
    } catch (e) {
      return Stream.error(
        ServerException(
          message: e.toString(),
          statusCode: '500',
        ),
      );
    }
  }
}
