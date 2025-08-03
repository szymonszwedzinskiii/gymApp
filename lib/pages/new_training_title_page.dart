import 'package:flutter/material.dart';
import 'package:gymapp/models/training.dart';
import 'training_details_page.dart';
import '../models/training.dart';

class NewTrainingTitlePage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Nowy Trening")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Nazwa treningu",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                if(title.isNotEmpty){
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => TrainingDetailsPage(title: title),
                    ),
                  );
                }
              },
              child: Text("Dalej"),
            )
          ],
        ),
      ),
    );
  }
}