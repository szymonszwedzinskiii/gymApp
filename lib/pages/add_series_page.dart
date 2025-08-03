import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../models/series.dart';

class AddSeriesPage extends StatefulWidget {
  @override
  _AddSeriesPageState createState() => _AddSeriesPageState();
}

class _AddSeriesPageState extends State<AddSeriesPage> {
  final _formKey = GlobalKey<FormState>();
  final _repsController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose(){
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _submit() {
    if(_formKey.currentState!.validate()){
      final reps = int.tryParse(_repsController.text) ?? 0;
      final weight = double.tryParse(_weightController.text) ?? 0.0;
      Navigator.pop(context, Series(reps: reps, weight: weight));
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Dodaj serię")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _repsController,
                decoration: InputDecoration(labelText: "Ilość powtórzeń"),
                keyboardType: TextInputType.number,
                validator: (val){
                  if(val == null || val.isEmpty){
                    return "Podaj ilość powtórzeń";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: "Ciężar"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (val){
                  if(val == null || val.isEmpty){
                    return "Podaj ciężar";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text("Zapisz serię"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}