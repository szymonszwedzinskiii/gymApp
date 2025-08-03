import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseCard extends StatelessWidget{
  final Exercise exercise;
  final VoidCallback? onTap;

  const ExerciseCard({Key? key, required this.exercise, this.onTap}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(exercise.name),
        subtitle: Text(exercise.formattedSeries()),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      )
    );
  }
}