import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_model.dart';
import 'get-device-token-controller.dart';

class GoogleAuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString imageUrl = ''.obs;
  Rx<User?> user = Rx<User?>(null);

  Future<String> signInWithGoogle() async {
    final GetDeviceTokenController getDeviceTokenController =
        Get.put(GetDeviceTokenController());
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final currentUser = authResult.user;

      if (currentUser != null) {
        name.value = currentUser.displayName ?? '';
        email.value = currentUser.email ?? '';
        imageUrl.value = currentUser.photoURL ?? '';
        user(currentUser);

        if (name.value.contains(" ")) {
          name.value = name.value;
        }

        // Create a UserModel object and initialize it
        UserModel userModel = UserModel(
          uId: currentUser.uid,
          username: currentUser.displayName ?? '',
          email: currentUser.email ?? '',
          phone: currentUser.phoneNumber ?? '',
          userImg: currentUser.photoURL ?? '',
          userDeviceToken: getDeviceTokenController.deviceToken.toString(),
          country: '',
          userAddress: '',
          street: '',
          isAdmin: false,
          isActive: true,
          createdOn: DateTime.now(),
          city: '',
        );

        print('signInWithGoogle succeeded: $currentUser');

        try {
          await FirebaseFirestore.instance // Save user data to Firestore
              .collection('users')
              .doc(currentUser.uid)
              .set(userModel.toMap());
        } catch (error) {
          print('Error saving user data to Firestore: $error');
          Get.snackbar(
            "Error",
            "$error",
            snackPosition: SnackPosition.BOTTOM,
          );
        }

        return '$user';
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
    return '';
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    user(null);
    print("User Signed Out");
  }
}
