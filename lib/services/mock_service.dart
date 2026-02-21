import '../models/user.dart';

/// Custom exception agar lebih clean dibanding throw Exception biasa
class MockUserServiceException implements Exception {
  final String message;

  MockUserServiceException(this.message);

  @override
  String toString() => message;
}

class MockUserService {
  /// Simulasi delay seperti network call
  static const Duration _delay = Duration(seconds: 1);

  /// Fetch users dengan optional error simulation
  Future<List<User>> fetchUsers({bool shouldFail = false}) async {
    await Future.delayed(_delay);

    if (shouldFail) {
      throw MockUserServiceException('Failed to fetch users');
    }

    final users = _generateDummyUsers();

    // Defensive copy supaya tidak bisa dimodifikasi dari luar
    return List<User>.unmodifiable(users);
  }

  /* ---------------------------- Filtering ---------------------------- */

  List<User> filterActiveUsers(List<User> users) {
    return users.where((u) => u.isActive).toList(growable: false);
  }

  List<User> filterByStatus(List<User> users, UserStatus status) {
    return users.where((u) => u.status == status).toList(growable: false);
  }

  List<User> searchByEmail(List<User> users, String keyword) {
    final lower = keyword.toLowerCase();
    return users
        .where((u) => u.email.toLowerCase().contains(lower))
        .toList(growable: false);
  }

  /* ---------------------------- Sorting ---------------------------- */

  List<User> sortByAge(
    List<User> users, {
    bool ascending = true,
  }) {
    final copy = List<User>.from(users);

    copy.sort(
      (a, b) => ascending ? a.age.compareTo(b.age) : b.age.compareTo(a.age),
    );

    return List<User>.unmodifiable(copy);
  }

  List<User> sortByName(
    List<User> users, {
    bool ascending = true,
  }) {
    final copy = List<User>.from(users);

    copy.sort((a, b) {
      final nameA = a.safeDisplayName.toLowerCase();
      final nameB = b.safeDisplayName.toLowerCase();
      return ascending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
    });

    return List<User>.unmodifiable(copy);
  }

  /* ---------------------------- Dummy Data ---------------------------- */

  List<User> _generateDummyUsers() {
    return const [
      User(
        id: '1',
        email: 'user1@example.com',
        displayName: 'Alice',
        age: 21,
        isActive: true,
        status: UserStatus.active,
      ),
      User(
        id: '2',
        email: 'user2@example.com',
        displayName: 'Bob',
        age: 25,
        isActive: true,
        status: UserStatus.active,
      ),
      User(
        id: '3',
        email: 'user3@example.com',
        displayName: null,
        age: 19,
        isActive: false,
        status: UserStatus.inactive,
      ),
      User(
        id: '4',
        email: 'user4@example.com',
        displayName: 'Zara',
        age: 30,
        isActive: true,
        status: UserStatus.active,
      ),
      User(
        id: '5',
        email: 'banned@example.com',
        displayName: 'Eve',
        age: 40,
        isActive: false,
        status: UserStatus.banned,
      ),
    ];
  }
}
