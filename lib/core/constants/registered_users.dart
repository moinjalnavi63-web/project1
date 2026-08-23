class RegisteredUser {
  final String name;
  final String email;
  final String password;
  final String role;
  final String identifier;
  final String mobile;
  final String route;

  const RegisteredUser({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.identifier,
    required this.mobile,
    required this.route,
  });
}

class RegisteredUsers {
  static final List<RegisteredUser> users = [];

  static void addUser({
    required String name,
    required String email,
    required String password,
    required String role,
    required String identifier,
    required String mobile,
    required String route,
  }) {
    users.removeWhere(
          (user) => user.email.toLowerCase() == email.toLowerCase(),
    );

    users.add(
      RegisteredUser(
        name: name,
        email: email,
        password: password,
        role: role,
        identifier: identifier,
        mobile: mobile,
        route: route,
      ),
    );
  }

  static RegisteredUser? findUser({
    required String email,
    required String password,
  }) {
    try {
      return users.firstWhere(
            (user) =>
        user.email.toLowerCase() == email.toLowerCase() &&
            user.password == password,
      );
    } catch (_) {
      return null;
    }
  }

  static RegisteredUser? findByEmail(String email) {
    try {
      return users.firstWhere(
            (user) =>
        user.email.toLowerCase() == email.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}