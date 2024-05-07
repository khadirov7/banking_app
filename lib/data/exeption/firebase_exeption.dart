class SingUpWithEmailAndPasswordFailure implements Exception{
  final String message;

  SingUpWithEmailAndPasswordFailure([
    this.message='An unknown exception occurred.',
  ]);


  factory SingUpWithEmailAndPasswordFailure.fromCode(String code){
    switch(code){
      case "invalid-email":
        return SingUpWithEmailAndPasswordFailure("Email is not valid or badly formatted");

      case "user-disabled":
        return SingUpWithEmailAndPasswordFailure("This user has been disabled.Please contact support for help");

      case "email-already-in-user":
        return  SingUpWithEmailAndPasswordFailure(
            "An account already exists for that email"
        );

      case "operation-not-allowed":
        return  SingUpWithEmailAndPasswordFailure(
            "Operation is not allowed"
        );

      case "weak-password":
        return  SingUpWithEmailAndPasswordFailure(
            "Please enter a strong password"
        );
      default:return SingUpWithEmailAndPasswordFailure();
    }

  }
}

class LogInWithEmailAndPasswordFailure implements Exception{
  final String message;

  LogInWithEmailAndPasswordFailure([
    this.message='An unknown exception occurred.',
  ]);


  factory LogInWithEmailAndPasswordFailure.fromCode(String code){
    switch(code){
      case "invalid-email":
        return LogInWithEmailAndPasswordFailure("Email is not valid or badly formatted");

      case "user-disabled":
        return LogInWithEmailAndPasswordFailure("This user has been disabled.Please contact support for help");

      case "email-already-in-user":
        return  LogInWithEmailAndPasswordFailure(
            "An account already exists for that email"
        );

      case "operation-not-allowed":
        return  LogInWithEmailAndPasswordFailure(
            "Operation is not allowed"
        );
      case "user-not-found":
        return LogInWithEmailAndPasswordFailure("User is not found,please create an account");
      case "weak-password":
        return  LogInWithEmailAndPasswordFailure(
            "Please enter a strong password"
        );
      default:return LogInWithEmailAndPasswordFailure();
    }

  }
}


class LogInWithGoogleFailure implements Exception{
  final String message;

  LogInWithGoogleFailure([
    this.message='An unknown exception occurred.',
  ]);

  factory LogInWithGoogleFailure.fromCode(String code){
    switch(code){
      case "account-exists-with-different-credential":
        return LogInWithGoogleFailure("Account exists with different credential");

      case "invalid-email":
        return LogInWithGoogleFailure("Email is not valid or badly formatted");

      case "user-disabled":
        return LogInWithGoogleFailure("This user has been disabled.Please contact support for help");

      case "user-not-found":
        return LogInWithGoogleFailure("Email is not found,please create an account");

      case "wrong-password":
        return LogInWithGoogleFailure("Incorrect password, please try again");

      case "invalid-verification-code":
        return  LogInWithGoogleFailure(
            "The credential verification code received is invalid"
        );
      case "invalid-verification-id":
        return  LogInWithGoogleFailure(
            "The credential verification ID received is invalid"
        );
      case "operation-not-allowed":
        return  LogInWithGoogleFailure(
            "Operation is not allowed"
        );
      default:return LogInWithGoogleFailure();
    }

  }
}

class LogOuteFailure implements Exception{}