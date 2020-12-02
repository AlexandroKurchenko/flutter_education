

class UserLogin {
  String fullName;
  String email;
  String password;

  UserLogin(this.fullName, this.email, this.password);

  UserLogin.forSignUp(_email, _password) {
    this.email = _email;
    this.password = _password;
  }

  UserLogin.forSignIn(_fullName, _email, _password) {
    this.fullName = _fullName;
    this.email = _email;
    this.password = _password;
  }

  bool isSignInInputDataValid() {
    if (fullName != null && email != null && password != null) {
      return true;
    }
    return false;
  }
}
