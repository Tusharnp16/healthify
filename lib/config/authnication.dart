import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthify/login.dart';
import 'package:healthify/navigation_menu.dart';
import 'package:healthify/splash_screen.dart';

class authnicationfirebase {

  final deviceStorage = GetStorage();


  void onReady(){
    screenRedirect();
  }

  void screenRedirect() async{

    deviceStorage.writeIfNull('IsFirstTime', true);
    deviceStorage.read('IsFirstTime') != true ? Get.offAll(() => const loginscreen()) : Get.offAll(()=> const NavigationMenu());



}


  final auth = FirebaseAuth.instance;

  Future<UserCredential> registewithemailandpassword(String email,String password) async {

    try{
      return await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      throw FirebaseAuthException(code: "Authnication Error");
    }catch(e){
      throw "Check  Your INternet Connection";
    }
  }
  Future<Map<String, dynamic>?> getUserData(String email) async {
    // Implement logic to fetch user data from your backend (Firestore in this case)
    final userCollection = FirebaseFirestore.instance.collection('huser');
    final docSnapshot = await userCollection.where('Email', isEqualTo: email).get();

    if (docSnapshot.docs.isNotEmpty) {
      final userData = docSnapshot.docs.first.data();
      return userData;
    } else {
      return null;  // No user found with the provided email
    }
  }
  Future<UserCredential> loginwithemailandpassword(String email,String password) async {
    try{
      return await auth.signInWithEmailAndPassword(email: email, password: password);
      }on FirebaseAuthException catch(e){
      throw FirebaseAuthException(code: "Authnication Error");
    }catch(e){
      throw "Check  Your INternet Connection";
      }
    }
}