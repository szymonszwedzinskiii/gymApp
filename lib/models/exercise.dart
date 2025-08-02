// import 'package:flutter/material.dart';
class Series {
  final int reps;
  final double weight;
  Series({required this.reps, required this.weight});

}

class Exercise {
  final String name;
  // final String set;
  List<Series> series;
  
  Exercise({
    required this.name,
    // required this.set,
    this.series = const []
  });
}
