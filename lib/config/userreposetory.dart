import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthify/config/usermodel.dart';


class UserRepository {

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> saveuserrecord(Usermodel user) async {
    try {
      await db.collection("huser").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw "Error has been occured";
    } catch (e) {
      throw "Error has been occured";
    }
  }

  Future<Usermodel> getuserdetailes(String mobileno) async {
    final snapshot = await db.collection("huser").where(
        "Mobile", isEqualTo: mobileno).get();
    final userdata = snapshot.docs
        .map((e) => Usermodel.fromSnapshot(e))
        .single;
    return userdata;
  }
}