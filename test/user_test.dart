import 'package:test/test.dart';
import 'package:first_task/models/user.dart';
import 'package:first_task/services/mock_service.dart';

void main() {
  group('User Model Tests', () {
    test('fromJson and toJson roundtrip works correctly', () {
      final json = {
        'id': '123',
        'email': 't@example.com',
        'displayName': 'Tester',
        'age': 20,
        'isActive': true,
        'status': 'active',
      };

      final user = User.fromJson(json);

      expect(user.id, '123');
      expect(user.email, 't@example.com');
      expect(user.displayName, 'Tester');
      expect(user.age, 20);
      expect(user.isActive, true);
      expect(user.status, UserStatus.active);

      final roundTrip = user.toJson();

      expect(roundTrip['id'], '123');
      expect(roundTrip['email'], 't@example.com');
      expect(roundTrip['displayName'], 'Tester');
      expect(roundTrip['age'], 20);
      expect(roundTrip['isActive'], true);
      expect(roundTrip['status'], 'active');
    });

    test('fromJson handles missing optional fields safely', () {
      final json = {
        'id': '1',
        'email': 'no-name@example.com',
        'age': 18,
        'isActive': false,
      };

      final user = User.fromJson(json);

      expect(user.displayName, null);
      expect(user.status, UserStatus.inactive);
    });

    test('copyWith only updates provided fields', () {
      final original = User(
        id: 'x',
        email: 'x@x.com',
        displayName: 'X',
        age: 10,
        isActive: false,
        status: UserStatus.inactive,
      );

      final updated = original.copyWith(
        age: 11,
        isActive: true,
        status: UserStatus.active,
      );

      expect(updated.id, 'x');
      expect(updated.email, 'x@x.com');
      expect(updated.age, 11);
      expect(updated.isActive, true);
      expect(updated.status, UserStatus.active);
    });
  });

  group('MockUserService Tests', () {
    final service = MockUserService();

    test('fetchUsers returns list of users when successful', () async {
      final users = await service.fetchUsers();

      expect(users.isNotEmpty, true);
      expect(users.length >= 3, true);
      expect(users.first, isA<User>());
    });

    test('fetchUsers throws exception when shouldFail is true', () async {
      expect(
        () => service.fetchUsers(shouldFail: true),
        throwsA(isA<Exception>()),
      );
    });

    test('filterActiveUsers returns only active users', () async {
      final users = await service.fetchUsers();
      final activeUsers = service.filterActiveUsers(users);

      expect(activeUsers.every((u) => u.isActive), true);
    });

    test('sortByAge sorts users in ascending order', () async {
      final users = await service.fetchUsers();
      final sorted = service.sortByAge(users);

      for (int i = 0; i < sorted.length - 1; i++) {
        expect(sorted[i].age <= sorted[i + 1].age, true);
      }
    });
  });
}
