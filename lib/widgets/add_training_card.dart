import 'package:flutter/material.dart';
import '../pages/new_training_title_page.dart';

class AddTraining extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NewTrainingTitlePage()),
        );
      },
      child: Card(
        child: ListTile(
          title: Text("New Workout"),
        ),
      ),
    );
  }
}