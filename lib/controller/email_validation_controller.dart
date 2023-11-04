import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class EmailValidationController extends GetxController {
  final FirebaseAuth fireAuth = FirebaseAuth.instance;

  Future<void> sendingEmailVerification(User? currentUser) async {
    if (currentUser != null) {
      if (!currentUser.emailVerified) {
        try {
          await currentUser.sendEmailVerification();
          Get.snackbar('Success', 'Email verification sent to your email');
        } catch (e) {
          Get.snackbar('Error', 'Failed to send email verification');
        }
      }
    }
  }

  Future<User?> refreshEmail(User currentUser) async {
    await currentUser.reload();
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }
}