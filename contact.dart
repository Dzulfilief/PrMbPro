import 'dart:io';

// --- A. KELAS INDUK (CONTACT) ---
class Contact {
  String name;
  String phone;

  // Constructor
  Contact(this.name, this.phone);

  // Method display (Virtual method yang akan di-override)
  String display() {
    return "$name • $phone";
  }
}

// --- B. KELAS TURUNAN (INHERITANCE) ---

// 1. PersonalContact
class PersonalContact extends Contact {
  DateTime? birthDate; // Properti opsional (?)

  // Constructor dengan Named Parameter untuk opsional
  PersonalContact(String name, String phone, {this.birthDate})
    : super(name, phone);

  @override
  String display() {
    String baseInfo = "[Personal] $name • $phone";
    if (birthDate != null) {
      // Format tanggal manual YYYY-MM-DD agar rapi
      String yyyy = birthDate!.year.toString();
      String mm = birthDate!.month.toString().padLeft(2, '0');
      String dd = birthDate!.day.toString().padLeft(2, '0');
      return "$baseInfo • DOB: $yyyy-$mm-$dd";
    }
    return baseInfo;
  }
}

// 2. BusinessContact
class BusinessContact extends Contact {
  String company;

  BusinessContact(String name, String phone, this.company) : super(name, phone);

  @override
  String display() {
    return "[Business] $name • $phone • $company";
  }
}

// --- MAIN PROGRAM ---
void main() {
  print("Nama : Alief Dzulfikar");
  print("NIM  : 32602300087");
  print("-------------------------------\n");

  // --- C. OBJEK & POLYMORPHISM ---

  // 1. Buat satu variabel bertipe induk (Contact)
  Contact data;

  // 2a. Isi dengan Contact Biasa
  data = Contact("Andi", "081234567890");
  print(data.display());

  // 2b. Isi dengan PersonalContact (Polymorphism: Tipe Contact, Isi Personal)
  data = PersonalContact(
    "Budi",
    "081111111111",
    birthDate: DateTime(2000, 5, 10),
  );
  print(data.display());

  // 2c. Isi dengan BusinessContact (Polymorphism: Tipe Contact, Isi Business)
  data = BusinessContact("Citra", "089876543210", "PT Sinar Jaya");
  print(data.display());
}
