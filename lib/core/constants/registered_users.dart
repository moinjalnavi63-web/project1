
class RegisteredUser {
  final String name;
  final String email;
  final String password;
  final String role;
  final String identifier;
  final String mobile;
  final String route;
  final String busNo;
  final String stop;

  const RegisteredUser({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.identifier,
    required this.mobile,
    required this.route,
    this.busNo = '',
    this.stop = '',
  });
}

class RegisteredUsers {
  static final List<RegisteredUser> users = [];

  static bool addUser({
    required String name,
    required String email,
    required String password,
    required String role,
    required String identifier,
    required String mobile,
    required String route,
    String busNo = '',
    String stop = '',
  }) {
    final emailExists = users.any(
          (user) => user.email.toLowerCase() == email.toLowerCase(),
    );

    if (emailExists) {
      return false;
    }

    users.add(
      RegisteredUser(
        name: name,
        email: email,
        password: password,
        role: role,
        identifier: identifier,
        mobile: mobile,
        route: route,
        busNo: busNo,
        stop: stop,
      ),
    );

    return true;
  }

  static RegisteredUser? findUser({
    required String email,
    required String password,
  }) {
    for (final user in users) {
      if (user.email.toLowerCase() == email.toLowerCase() &&
          user.password == password) {
        return user;
      }
    }
    return null;
  }

  static RegisteredUser? findByEmail(String email) {
    for (final user in users) {
      if (user.email.toLowerCase() == email.toLowerCase()) {
        return user;
      }
    }
    return null;
  }
}
