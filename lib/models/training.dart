import 'package:gymapp/models/exercise.dart';

class Training{
  final String title;
  final DateTime date;
  final List<Exercise> exercises;

  Training({required this.title, required this.date, List<Exercise>? exercises})
    : exercises = exercises ?? [];

}