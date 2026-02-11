# 📱First Mobile Development Task

## Model, Service, and Async Programming (Pure Dart)

## Overview

Pada tugas ini Anda akan membangun sebuah **modul Dart sederhana (tanpa Flutter)** yang berfokus pada:

* OOP dan class design
* Null safety
* JSON serialization dan deserialization
* Future dan async/await
* Error handling asynchronous

**Catatan**: Tugas ini menggunakan pure Dart, bukan Flutter.

---

## Learning Objectives

Setelah menyelesaikan tugas ini, mahasiswa mampu:

* Mendesain model Dart dengan null safety yang benar
* Mengimplementasikan `fromJson()` dan `toJson()`
* Menggunakan `copyWith()` dengan pola yang tepat
* Menggunakan `Future`, `async/await`, dan `try-catch`
* Menulis kode modular dengan struktur folder yang rapi

---

## How to Start

1. Fork repository utama.
2. Clone repository hasil fork ke lokal:

   ```bash
   git clone <url-repo-fork>
   cd <repo-folder>
   ```
3. Kerjakan tugas di repository fork Anda.
4. Push hasil akhir ke repository Anda.

---

## Project Structure (Wajib)

Struktur folder tidak boleh diubah:

```
lib/
│
├── models/
│   └── user.dart
│
├── services/
│   └── mock_service.dart
│
└── examples/
    └── main_examples.dart
```

---

## Task Specifications

### 1. `lib/models/user.dart`

Buat class `User` dengan properti minimal:

| Property    | Type    |
| ----------- | ------- |
| id          | String  |
| email       | String  |
| displayName | String? |
| age         | int     |
| isActive    | bool    |

**Wajib mengandung:**

* Constructor dengan `required` pada field yang wajib.
* `factory User.fromJson(Map<String, dynamic> json)` untuk parsing.
* `Map<String, dynamic> toJson()` untuk serialisasi.
* `User copyWith({ ... })` untuk membuat salinan dengan perubahan.
* Null safety yang benar; hindari penggunaan `!` tanpa alasan kuat.

Disarankan: override `toString()` untuk memudahkan debugging.

---

### 2. `lib/services/mock_service.dart`

Buat class `MockUserService`.

**Method wajib:**

```dart
Future<List<User>> fetchUsers({bool shouldFail = false})
```

**Ketentuan:**

* Gunakan `Future.delayed` minimal 1 detik untuk mensimulasikan panggilan jaringan.
* Kembalikan minimal 3 objek `User` dummy saat `shouldFail == false`.
* Jika `shouldFail == true`, lempar `Exception('Failed to fetch users')`.
* Tambahkan komentar singkat bahwa ini simulasi API call.

Contoh tanda tangan yang dianjurkan:

```dart
class MockUserService {
  Future<List<User>> fetchUsers({bool shouldFail = false}) async {
    // ...
  }
}
```

---

### 3. `lib/examples/main_examples.dart`

File ini adalah entry point untuk demonstrasi.

**Harus menampilkan:**

* Penggunaan `async/await` dan pemanggilan `fetchUsers()`.
* Penanganan error dengan `try-catch`.
* Parsing JSON ke objek `User` menggunakan `User.fromJson()`.
* Demonstrasi null safety: penggunaan `??` dan `?.`.
* Demonstrasi `copyWith()` untuk membuat modifikasi pada objek.

**Harus bisa dijalankan dengan:**

```bash
dart run lib/examples/main_examples.dart
```

---

## Cara Menjalankan

Pastikan Dart sudah terinstall:

```bash
dart --version
```

Install dependency (jika ada di `pubspec.yaml`):

```bash
dart pub get
```

Jalankan contoh:

```bash
dart run lib/examples/main_examples.dart
```

---

## Example Expected Output

Contoh output ketika berhasil:

```
Fetching users...
Users fetched successfully!

User(id: 1, email: user1@example.com, displayName: Alice, age: 21, isActive: true)
User(id: 2, email: user2@example.com, displayName: Bob, age: 25, isActive: true)
User(id: 3, email: user3@example.com, displayName: null, age: 19, isActive: false)

Parsed from JSON:
User(id: 99, email: json@example.com, displayName: John, age: 30, isActive: true)

CopyWith result:
User(id: 99, email: json@example.com, displayName: Johnny, age: 30, isActive: true)
```

Jika terjadi error:

```
Fetching users...
Error occurred: Failed to fetch users
```

---

## Grading Rubric

|                                  Criteria | Weight |
| ----------------------------------------: | -----: |
|              Completeness (file & fungsi) |    40% |
| Code Quality (naming, komentar, struktur) |    25% |
|                         Null Safety Usage |    20% |
|                    Async & Error Handling |    15% |

---

## Rules

* Tidak boleh menggunakan Flutter
* Tidak boleh menggunakan package eksternal
* Tidak boleh mengubah struktur folder
* Tidak boleh menyalin pekerjaan mahasiswa lain

---

## Bonus (Optional)

* Tambahkan enum untuk status user
* Tambahkan sorting/filtering sederhana
* Tambahkan unit test sederhana

---

## Deadline

Sesuaikan dengan instruksi dosen.

Contoh:

> Deadline: 18 Februari 2026, 23:59 WIB

---

## Dart Version Requirement

Gunakan:

```
Dart SDK >= 3.0.0
```

---

## Notes

Fokus utama tugas ini adalah:

* Kerapian struktur
* Pemahaman null safety
* Pemahaman async programming
* Clean code

---

Happy Coding Folks! 🚀
