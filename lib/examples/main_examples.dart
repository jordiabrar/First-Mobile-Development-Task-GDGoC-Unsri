import 'dart:convert';
import '../models/user.dart';
import '../services/mock_service.dart';

Future<void> main() async {
  final service = MockUserService();

  print('Fetching users...\n');

  try {
    final users = await service.fetchUsers();
    print('Users fetched successfully!\n');

    _printUsers(users);

    _demoFiltering(service, users);
    _demoSorting(service, users);
    _demoJsonParsing();
    _demoCopyWith();
    await _demoErrorHandling(service);
  } catch (e) {
    print('Unexpected error: ${_cleanError(e)}');
  }
}

/* ---------------------------- Helper Sections ---------------------------- */

void _printUsers(List<User> users) {
  print('All Users:');
  for (final user in users) {
    print(user);
  }
  print('');
}

void _demoFiltering(MockUserService service, List<User> users) {
  print('-- Active users (filter) --');
  final activeUsers = service.filterActiveUsers(users);
  for (final user in activeUsers) {
    print(user);
  }
  print('');
}

void _demoSorting(MockUserService service, List<User> users) {
  print('-- Users sorted by age (ascending) --');
  final sortedUsers = service.sortByAge(users);
  for (final user in sortedUsers) {
    print(user);
  }
  print('');
}

void _demoJsonParsing() {
  print('Parsed from JSON:');

  final jsonMap = {
    'id': '99',
    'email': 'json@example.com',
    'displayName': 'John',
    'age': 30,
    'isActive': true,
    'status': 'active',
  };

  // Decode JSON Map to User
  final user = User.fromJson(jsonMap);
  print(user);

  // Encode back to JSON string
  final jsonString = jsonEncode(user.toJson());
  print('\nSerialized to JSON string:');
  print(jsonString);

  // Null safety demo
  print('\nNull safety demo:');
  final safeName = user.displayName ?? 'No Name';
  print('displayName: $safeName');
  print('length: ${user.displayName?.length}');
  print('');
}

void _demoCopyWith() {
  print('CopyWith result:');

  final original = User(
    id: '100',
    email: 'copy@example.com',
    displayName: 'Original',
    age: 28,
    isActive: true,
    status: UserStatus.active,
  );

  final modified = original.copyWith(displayName: 'Modified');

  print('Original : $original');
  print('Modified : $modified');
  print('');
}

Future<void> _demoErrorHandling(MockUserService service) async {
  print('Simulate error (shouldFail = true)');

  try {
    await service.fetchUsers(shouldFail: true);
  } catch (e) {
    print('Error occurred: ${_cleanError(e)}');
  }

  print('');
}

/* ---------------------------- Utility ---------------------------- */

String _cleanError(Object e) {
  final message = e.toString();
  return message.replaceFirst('Exception: ', '');
}
