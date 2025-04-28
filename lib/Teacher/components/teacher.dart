class Teacher {
  final String name;
  final String qualification;
  final String email;

  Teacher({
    required this.name, 
    required this.qualification,
    required this.email
    });

  // Convert Firestore data (Map) to a Teacher object
  factory Teacher.fromMap(Map<String, dynamic> data) {
    return Teacher(
      name: data['Name'] ?? 'Unknown',
      qualification: data['Qualification'] ?? 'Unknown',
      email: data['Email'] ?? 'Unknown',
    );
  }
}
