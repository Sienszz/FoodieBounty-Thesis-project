import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  Future<bool> getUserRole(String email) async {
    try {
      // Reference to the Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('customers');

      // Query for documents where the 'email' field matches the provided email
      var querySnapshot = await collectionRef.where('email', isEqualTo: email).get();

      // Check if any matching document was found
      if (querySnapshot.docs.isNotEmpty) {

        return true; // Assuming 'buyer' is a field in your user document
      } else {
        // No document found with the specified email
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

