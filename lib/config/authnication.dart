import 'package:firebase_auth/firebase_auth.dart';

class authnicationfirebase {

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