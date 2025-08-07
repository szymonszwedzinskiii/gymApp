import 'package:flutter/material.dart';
import 'package:gymapp/models/training.dart';

class TrainingCard extends StatelessWidget{
  final Training training;
  final VoidCallback? onTap;

  const TrainingCard({Key? key, required this.training, this.onTap}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(training.title),
        subtitle: Text(training.exercises.first.toString()),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      )
    );
  }
}