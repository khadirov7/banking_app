import 'package:flutter/foundation.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
class BiometricAuthService {
  static LocalAuthentication auth = LocalAuthentication();

  static Future<bool> canAuthenticated() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (canAuthenticate) {
      List<BiometricType> types = await auth.getAvailableBiometrics();
      if (types.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  static Future<bool> authenticate() async {
    try {
      debugPrint("AAA");
      debugPrint("AAaaa${await auth.authenticate(
          localizedReason:"Barmoq izini faollashtirish",
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            sensitiveTransaction: false,
            stickyAuth: true,
            biometricOnly: true,
          ))}");
      return await auth.authenticate(
          localizedReason:"Barmoq izini faollashtirish",
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            stickyAuth: true,
            biometricOnly: true,
          ));
    }
    catch (e) {
      return false;
    }
  }
}