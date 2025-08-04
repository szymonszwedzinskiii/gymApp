import 'package:flutter/material.dart';
import 'package:gymapp/models/exercise.dart';
import 'package:gymapp/models/series.dart';

class EditSeriesPage extends StatefulWidget{
  final Exercise exercise;
  final int index;
  const EditSeriesPage({Key? key, required this.exercise, required this.index}) : super(key:key);

  @override
  _EditSeriesPageState createState() => _EditSeriesPageState();
}

class _EditSeriesPageState extends State<EditSeriesPage>{
  final _formKey = GlobalKey<FormState>();
  final _repsController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose(){
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _submit(Exercise ex,int index){
    if(_formKey.currentState!.validate()){
      final reps = int.tryParse(_repsController.text) ?? ex.series[index].reps;
      final weight = double.tryParse(_weightController.text) ?? ex.series[index].weight;
      Navigator.pop(context, Series(reps: reps, weight: weight));
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Edytuj serię")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _repsController,
                decoration: InputDecoration(labelText: widget.exercise.series[widget.index].reps.toString()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: widget.exercise.series[widget.index].weight.toString()),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () =>  _submit(widget.exercise, widget.index),
                child: Text("Zapisz serię"),
              ),
            ],
          ),
        ),
      ),
    );
}
}