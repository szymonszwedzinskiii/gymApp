import 'package:flutter/material.dart';
import 'ExercisePage.dart';
import '../models/exercise.dart';
import 'new_training_page.dart';
import 'add_series_page.dart';
import '../models/series.dart';
import '../models/training.dart';
import 'exercise_card.dart';

class TrainingDetailsPage extends StatefulWidget {
  final String title;

  const TrainingDetailsPage({Key? key, required this.title}) : super(key: key);

  @override
  _TrainingDetailsPageState createState() => _TrainingDetailsPageState();
}

class _TrainingDetailsPageState extends State<TrainingDetailsPage> {
  List<Exercise> exercises = [];
  late Training training;

  @override 
  void initState(){
    super.initState();
    training = Training(title: widget.title, date: DateTime.now(), exercises: []);
  }
  
  void _addExercise() async {
    final newExercise = await Navigator.push<Exercise>(
      context,
      MaterialPageRoute(builder: (context) => NewTrainingPage()),
    );

    if (newExercise != null) {
      setState(() {
        // exercises.add(newExercise);
        training.exercises.add(newExercise);
      });
    }
  }

  void _addSeries(int exerciseIndex) async {
      final newSeries = await Navigator.push<Series>(
        context,
        MaterialPageRoute(builder: (_) => AddSeriesPage()),
      );

      if(newSeries != null){
        setState(() {
          training.exercises[exerciseIndex].series.add(newSeries);
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: training.exercises.isEmpty
                ? Center(child: Text("Brak ćwiczeń"))
                : ListView.builder(
                    itemCount: training.exercises.length,
                    itemBuilder: (context, index) {
                      final e = training.exercises[index];
                      return ExerciseCard(
                        exercise: e,
                          onTap: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (_) => ExercisePage(exercise: e)),
                            );
                          },
                        );
                    },
                  ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _addExercise,
              icon: Icon(Icons.add),
              label: Text("Dodaj Ćwiczenie"),
            ),
          ),
        ],
      ),
    );
  }
}
