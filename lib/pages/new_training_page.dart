import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymapp/models/exercise.dart';
import 'training_details_page.dart';

class NewTrainingPage extends StatefulWidget {
  @override
  _NewTrainingPageState createState() => _NewTrainingPageState();
}

class _NewTrainingPageState extends State<NewTrainingPage> {
  final _formKey = GlobalKey<FormState>();
  final _trainingNameController = TextEditingController();
  final _setsCounterController = TextEditingController();
  final _repsCounterController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose(){
    _trainingNameController.dispose();
    _setsCounterController.dispose();
    _repsCounterController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _submitForm(){
    if(_formKey.currentState!.validate()){
      final newExercise = Exercise(name: _trainingNameController.text
      );
      Navigator.pop(context, newExercise);
          
      
    }
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dodaj Ćwiczenie")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _trainingNameController,
                decoration: InputDecoration(
                  labelText: "Nazwa Ćwiczenia",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "To pole nie może być puste";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _setsCounterController,
                decoration: InputDecoration(
                  labelText: "Seria",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "To pole nie może być puste";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _repsCounterController,
                decoration: InputDecoration(
                  labelText: "Ilość powtórzeń",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "To pole nie może być puste";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: "Ciężar",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "To pole nie może być puste";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Zapisz ćwiczenie"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}