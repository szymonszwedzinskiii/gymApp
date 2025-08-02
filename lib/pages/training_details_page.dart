// import 'package:flutter/material.dart';
// import 'new_training_page.dart';
// import 'package:gymapp/models/exercise.dart';

// class TrainingDetailsPage extends StatefulWidget {
//   final String title;

//   const TrainingDetailsPage({required this.title});

//   @override
//   _TrainingDetailsPageState createState() => _TrainingDetailsPageState();
// }

// class _TrainingDetailsPageState extends State<TrainingDetailsPage> {
//   // Tutaj możesz trzymać listę ćwiczeń (np. List<Exercise>)
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.title)),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.push(context,
//               MaterialPageRoute(builder: (context) => NewTrainingPage()),
//             );
//           },
//           child: Text("Dodaj Ćwiczenie"),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/exercise.dart';
import 'new_training_page.dart';
import 'add_series_page.dart';

class TrainingDetailsPage extends StatefulWidget {
  final String title;

  const TrainingDetailsPage({Key? key, required this.title}) : super(key: key);

  @override
  _TrainingDetailsPageState createState() => _TrainingDetailsPageState();
}

class _TrainingDetailsPageState extends State<TrainingDetailsPage> {
  List<Exercise> exercises = [];

  void _addExercise() async {
    final newExercise = await Navigator.push<Exercise>(
      context,
      MaterialPageRoute(builder: (context) => NewTrainingPage()),
    );

    if (newExercise != null) {
      setState(() {
        exercises.add(newExercise);
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
          exercises[exerciseIndex].series.add(newSeries);
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
            child: exercises.isEmpty
                ? Center(child: Text("Brak ćwiczeń"))
                : ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final e = exercises[index];
                      return ListTile(
                        title: Text(e.name),
                       subtitle: Text('Liczba serii: ${e.series.length}'),
                        onTap: () => _addSeries(index),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: _addExercise,
              child: Icon(Icons.add),
              tooltip: "Dodaj Ćwiczenie",
            ),
          ),
        ],
      ),
    );
  }
}
