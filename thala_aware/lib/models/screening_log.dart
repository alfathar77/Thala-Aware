class ScreeningLog {
  final int? id;
  final String username; // <-- Data Baru
  final String date;
  final String location;
  final String result;
  final String notes;

  ScreeningLog({
    this.id,
    required this.username, // <-- Wajib diisi
    required this.date,
    required this.location,
    required this.result,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username, // <-- Masukkan ke map
      'date': date,
      'location': location,
      'result': result,
      'notes': notes,
    };
  }

  factory ScreeningLog.fromMap(Map<String, dynamic> map) {
    return ScreeningLog(
      id: map['id'] != null ? int.tryParse(map['id'].toString()) : null,
      username: map['username']?.toString() ?? 'Tanpa Nama', // <-- Ambil dari map
      date: map['date']?.toString() ?? '',
      location: map['location']?.toString() ?? '',
      result: map['result']?.toString() ?? '',
      notes: map['notes']?.toString() ?? '',
    );
  }
}