enum UserStatus { active, inactive, banned }

class User {
  final String id;
  final String email;
  final String? displayName;
  final int age;
  final bool isActive;
  final UserStatus status;

  const User({
    required this.id,
    required this.email,
    this.displayName,
    required this.age,
    required this.isActive,
    required this.status,
  })  : assert(id != ''),
        assert(email != ''),
        assert(age >= 0);

  /* ---------------------------- Computed Properties ---------------------------- */

  bool get isAdult => age >= 18;

  bool get isBanned => status == UserStatus.banned;

  String get safeDisplayName =>
      (displayName == null || displayName!.isEmpty) ? 'No Name' : displayName!;

  /* ---------------------------- JSON Parsing ---------------------------- */

  factory User.fromJson(Map<String, dynamic> json) {
    final id = _parseString(json['id']);
    final email = _parseString(json['email']);
    final displayName = _parseNullableString(json['displayName']);
    final age = _parseInt(json['age']);
    final isActive = _parseBool(json['isActive']);

    final status = _parseStatus(
      json['status'],
      fallbackIsActive: isActive,
    );

    return User(
      id: id,
      email: email,
      displayName: displayName,
      age: age,
      isActive: isActive,
      status: status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'age': age,
      'isActive': isActive,
      'status': status.name,
    };
  }

  /* ---------------------------- copyWith ---------------------------- */

  User copyWith({
    String? id,
    String? email,
    String? displayName,
    int? age,
    bool? isActive,
    UserStatus? status,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      age: age ?? this.age,
      isActive: isActive ?? this.isActive,
      status: status ?? this.status,
    );
  }

  /* ---------------------------- Equality ---------------------------- */

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.email == email &&
        other.displayName == displayName &&
        other.age == age &&
        other.isActive == isActive &&
        other.status == status;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      email,
      displayName,
      age,
      isActive,
      status,
    );
  }

  /* ---------------------------- String Representation ---------------------------- */

  @override
  String toString() {
    return 'User('
        'id: $id, '
        'email: $email, '
        'displayName: $displayName, '
        'age: $age, '
        'isActive: $isActive, '
        'status: ${status.name}'
        ')';
  }

  /* ---------------------------- Private Helpers ---------------------------- */

  static String _parseString(dynamic value) {
    if (value is String && value.isNotEmpty) return value;
    return '';
  }

  static String? _parseNullableString(dynamic value) {
    if (value is String && value.isNotEmpty) return value;
    return null;
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true';
    }
    return false;
  }

  static UserStatus _parseStatus(
    dynamic value, {
    required bool fallbackIsActive,
  }) {
    if (value is String) {
      for (final s in UserStatus.values) {
        if (s.name == value) return s;
      }
    }

    return fallbackIsActive ? UserStatus.active : UserStatus.inactive;
  }
}
