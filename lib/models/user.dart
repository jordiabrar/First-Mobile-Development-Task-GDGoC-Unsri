// ======================================================
// TODO: USER MODEL
// ======================================================

// 1. Buat class bernama User.

// 2. Tambahkan properti berikut:
//    - String id
//    - String email
//    - String? displayName (nullable)
//    - int age
//    - bool isActive

// 3. Buat constructor dengan required keyword yang tepat.
//    Pastikan null safety diterapkan dengan benar.

// 4. Buat factory constructor:
//    factory User.fromJson(Map<String, dynamic> json)
//
//    Ketentuan:
//    - Parsing semua field
//    - Gunakan operator ?? jika diperlukan
//    - Jangan gunakan forced unwrap (!) tanpa alasan jelas

// 5. Buat method:
//    Map<String, dynamic> toJson()
//
//    Ketentuan:
//    - Semua properti dikembalikan dalam bentuk Map

// 6. Buat method:
//    User copyWith({...})
//
//    Ketentuan:
//    - Semua parameter bersifat optional
//    - Gunakan pola: field ?? this.field

// 7. Tambahkan override toString() untuk debugging (opsional tapi disarankan)
