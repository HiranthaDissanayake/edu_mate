import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  static final SQLiteHelper _instance = SQLiteHelper._internal();
  static Database? _database;

  factory SQLiteHelper() => _instance;

  SQLiteHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'edu_mate.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create students table
    await db.execute('''
      CREATE TABLE students(
        id TEXT PRIMARY KEY,
        name TEXT,
        email TEXT,
        grade TEXT,
        subjects TEXT,  // Store as JSON string
        attendance TEXT,  // Store as JSON string
        lastUpdated INTEGER  // Timestamp
      )
    ''');

    // Create teachers table
    await db.execute('''
      CREATE TABLE teachers(
        id TEXT PRIMARY KEY,
        name TEXT,
        email TEXT,
        grades TEXT,  // Store as JSON string
        lastUpdated INTEGER
      )
    ''');

    // Create schedules table
    await db.execute('''
      CREATE TABLE schedules(
        id TEXT PRIMARY KEY,
        scheduleData TEXT,  // Store as JSON string
        lastUpdated INTEGER
      )
    ''');
    
    // Create payment records table
    await db.execute('''
      CREATE TABLE payments(
        id TEXT PRIMARY KEY,
        studentId TEXT,
        month TEXT,
        subject TEXT,
        isPaid INTEGER,  // 0 for false, 1 for true
        paymentDate TEXT,
        lastUpdated INTEGER
      )
    ''');
  }

  // Student operations
  Future<int> insertStudent(Map<String, dynamic> student) async {
    final db = await database;
    return await db.insert(
      'students',
      student,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getStudents() async {
    final db = await database;
    return await db.query('students');
  }

  // Teacher operations
  Future<int> insertTeacher(Map<String, dynamic> teacher) async {
    final db = await database;
    return await db.insert(
      'teachers',
      teacher,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getTeachers() async {
    final db = await database;
    return await db.query('teachers');
  }

  // Schedule operations
  Future<int> insertSchedule(Map<String, dynamic> schedule) async {
    final db = await database;
    return await db.insert(
      'schedules',
      schedule,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getSchedules() async {
    final db = await database;
    return await db.query('schedules');
  }

  // Payment operations
  Future<int> insertPayment(Map<String, dynamic> payment) async {
    final db = await database;
    return await db.insert(
      'payments',
      payment,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getPayments() async {
    final db = await database;
    return await db.query('payments');
  }

  // Clear all data (for testing or logout)
  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('students');
    await db.delete('teachers');
    await db.delete('schedules');
    await db.delete('payments');
  }
}