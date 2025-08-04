import 'package:flutter/material.dart';
import 'package:gymapp/pages/edit_series_page.dart';
import '../models/exercise.dart';
import '../models/series.dart';
import 'add_series_page.dart';

class ExercisePage extends StatefulWidget{
    final Exercise exercise;

  const ExercisePage({Key? key, required this.exercise}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage>{
  late List<Series> seriesList;

@override
  void initState(){
    super.initState();
    seriesList = List.from(widget.exercise.series);
  }

  void _addSeries() async{
        final newSeries = await Navigator.push<Series>(
        context,
        MaterialPageRoute(builder: (_) => AddSeriesPage()),
      );

      if(newSeries != null){
        setState(() {
          widget.exercise.series.add(newSeries);
        });
      }
  }
  
  void _deleteSeries(int index){
    setState(() {
      widget.exercise.series.removeAt(index);
    });
  }
  
 void _editSeries(int index) async {
    final updated = await Navigator.push<Series>(
      context,
      MaterialPageRoute(
        builder: (_) => EditSeriesPage(
          exercise: widget.exercise,
          index: index,
        ),
      ),
    );

    if (updated != null) {
      setState(() {
        widget.exercise.series[index] = updated;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Cwiczenie: ${widget.exercise.name}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.exercise.series.isEmpty
                ? Center(child: Text("Obecnie nie masz zadnej serii, dodaj serie"))
                : ListView.builder(
                  itemCount: widget.exercise.series.length,
                  itemBuilder:(context, index) {
                    final series = widget.exercise.series[index];
                    return ListTile(
                      title: Text('Seria ${index+1} - ${series.reps} - ${series.weight} kg'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editSeries(index),
                              
                          ),
                          IconButton(
                            onPressed: () { _deleteSeries(index); },
                            icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _addSeries,
              icon: Icon(Icons.add),
              label: Text("Dodaj Serie"),
            ),
          ),
        ],

      ),
    );
  }
}