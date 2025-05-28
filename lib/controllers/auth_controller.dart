import 'package:local_auth/local_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();

  var isBiometricSupported = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkDeviceSupport();
  }

  void checkDeviceSupport() async {
    bool supported = await auth.isDeviceSupported();
    isBiometricSupported.value = supported;
    print("Biometric support: $supported");
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      if (!canCheckBiometrics) return false;

      bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to login',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      return authenticated;
    } catch (e) {
      print("Biometric auth error: $e");
      return false;
    }
  }
}
