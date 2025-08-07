import 'package:flutter/services.dart';
import 'package:gymapp/models/exercise.dart';
import 'package:gymapp/models/series.dart';
import 'package:gymapp/models/training.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'gym_tracker.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    // Użytkownicy
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT
      )
    ''');

    // Treningi przypisane do użytkownika
    await db.execute('''
      CREATE TABLE trainings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        title TEXT,
        date TEXT,
        FOREIGN KEY(user_id) REFERENCES users(id)
      )
    ''');

    // Ćwiczenia przypisane do treningu
    await db.execute('''
      CREATE TABLE exercises (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        training_id INTEGER,
        name TEXT,
        FOREIGN KEY (training_id) REFERENCES trainings(id)
      )
    ''');

    // Serie przypisane do ćwiczenia
    await db.execute('''
      CREATE TABLE series (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        exercise_id INTEGER,
        reps INTEGER,
        weight REAL,
        FOREIGN KEY (exercise_id) REFERENCES exercises(id) 
      )
    ''');
  }

  // Przykładowe metody (możesz rozbudować)
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  Future<bool> userExists(String email) async{
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email]
    );
    return results.isNotEmpty;
  }

  Future<int> insertTraining(String title, DateTime date, int userId) async {
    final db = await database;

    return await db.insert(
      'trainings',
      {
        'title': title,
        'date': date.toIso8601String(),
        'user_id': userId,
      },
    );
  }

  Future<int> insertExercise(String exercise_name, int training_id) async {
    final db = await database;

    return await db.insert(
      'exercises',
      {
        'name': exercise_name,
        'training_id': training_id,
      },
    );
  }

  Future<int> insertSeries(int reps, double weight, int exercise_id) async {
    final db = await database;

    return await db.insert(
      'series',
      {
        'reps': reps,
        'weight': weight,
        'exercise_id': exercise_id
      },
    );
  }

  Future<List<Training>> getTrainingsByUser(String email) async {
    final db = await database;
    final trainingMaps = await db.query(
      'trainings',
      where: 'email = ?',
      whereArgs: [email],
    );
  
    List<Training> trainings = [];

    for (var trainingMap in trainingMaps){
      final trainingId = trainingMap['id'] as int;

      final exerciseMaps = await db.query(
      'exercises',
      where: 'training_id = ?',
      whereArgs: [trainingId],
      );

      List<Exercise> exercises =[];

      for (var exerciseMap in exerciseMaps){
        final exerciseId = exerciseMap['id'] as int;

        final seriesMaps = await db.query(
          'series',
          where: 'exercise_id = ?',
          whereArgs: [exerciseId],
        );

        List<Series> seriesList = seriesMaps.map((s){
          return Series(
            reps: s['reps'] as int,
            weight: (s['weight'] as num).toDouble()
          );
        }).toList();

        exercises.add(
          Exercise(
            name: exerciseMap['name'] as String,
            series: seriesList,
          ),
        );
      }

      trainings.add(
        Training(
          title: trainingMap['title'] as String,
          date: DateTime.parse(trainingMap['date'] as String),
          exercises: exercises    
        ),
      );
    }
    return trainings;

    }
  // DELETING DATA FROM DB

  Future<void> deleteTraining(int trainingId) async{
    final db = await database;

    final exerciseMaps = await db.query(
      'exercises',
      where: 'training_id = ?',
      whereArgs: [trainingId],
    );
    for (final exercise in exerciseMaps){
      final exerciseId = exercise['id'] as int;
      await deleteSeries(exerciseId);
    }

  }

  Future<int> deleteSeries(int exerciseId) async{
    final db = await database;

    return await db.delete(
      'series',
      where: 'exercise_id = ?',
      whereArgs: [exerciseId],
    );

  }

  Future<int> deleteExercise(int trainingId) async{
    final db = await database;
    return await db.delete(
      'exercises',
      where: 'training_id = ?',
      whereArgs: [trainingId],
    );
  }

}