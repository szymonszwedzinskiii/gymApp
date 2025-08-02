import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Workout Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white
      ),
      home: HomePage(),
    );
  }
}

// // class WorkoutCard extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context){
// //     return Card(
// //       child: ListTile(
// //         title: Text("Todays Workout"),
// //         subtitle: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text("Push Day", style: TextStyle(fontWeight: FontWeight.bold)),
// //             Text(" 1 o bac"),
// //             SizedBox(height: 60),
// //             Icon(Icons.bar_chart),
// //           ],
// //         ),
// //         trailing: Icon(Icons.chevron_right),
// //       )
// //     );
// //   }

// // }

// class AddTraining extends StatelessWidget {
//   @override
//   Widget build(BuildContext context){
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => NewTrainingTitlePage()),
//         );
//       },
//       child: Card(
//       child: ListTile(
//         title: Text("New Workout"),
        
//       )
//     )
//     );
//   }

// }

// class NewTrainingPage extends StatefulWidget{
// @override
// _NewTrainingPageState createState() => _NewTrainingPageState();

// }

// class _NewTrainingPageState extends State<NewTrainingPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _trainingNameController = TextEditingController();
//   final _setsCounterController = TextEditingController();
//   final _repsCounterController = TextEditingController();
//   final _weightController = TextEditingController();
  
//   @override
//   void dispose(){
//     _trainingNameController.dispose();
//     super.dispose();

//   }

//   void _submitForm(){
//     if(_formKey.currentState!.validate()){
//       final trainingName = _trainingNameController.text;
//       final setsCounter = _setsCounterController.text;
//       final repsCounter = _repsCounterController.text;
//       final weight = _weightController.text;
//       print("Zapisano trening: $trainingName");
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => TrainingDetailsPage(
//           trainingName: trainingName,
//           setsCounter: setsCounter,
//           repsCounter:repsCounter,
//           weight:weight
//           )
//         ),
//       );
//     }
//   }
  
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(title: Text("Dodaj Trening")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 32),

//               TextFormField(
//                 controller: _trainingNameController,
//                 decoration: InputDecoration(
//                   labelText: "Nazwa Cwiczenia",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator:  (value){
//                   if (value == null || value.isEmpty){
//                     return " To Pole nie moze byc puste";
//                   }
//                   return null;
//                 }
//               ),
//               SizedBox(height: 64),
//               TextFormField(
//                 controller: _setsCounterController,
//                 decoration: InputDecoration(
//                   labelText: "Która seria",
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.digitsOnly,
//                 ],
//                 validator: (value){
//                   if (value == null ||value.isEmpty){
//                     return "To pole nie moze byc puste";
//                   }
//                   return null;
//                 }
//               ),
//               SizedBox(height: 64),
//               TextFormField(
//                 controller: _repsCounterController,
//                 decoration: InputDecoration(
//                   labelText: "Ilość powtórzeń",
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.digitsOnly,
//                 ],
//                 validator: (value){
//                   if (value == null ||value.isEmpty){
//                     return "To pole nie moze byc puste";
//                   }
//                   return null;
//                 }
//               ),
//               SizedBox(height: 64),
//               TextFormField(
//                 controller: _weightController,
//                 decoration: InputDecoration(
//                   labelText: "Cięźar",
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
//                 ],
//                 validator: (value){
//                   if (value == null ||value.isEmpty){
//                     return "To pole nie moze byc puste";
//                   }
//                   return null;
//                 }
//               ),
//               SizedBox(height: 16),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _submitForm,
//                   child: Text('Zapisz ćwiczenie'),
//               ),
//               ),
//             ],
//           )
//          )
//       )

//     );
//   }

// }

// class NewTrainingTitlePage extends StatelessWidget{

//   final TextEditingController _titleController = TextEditingController();

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(title: Text("Nowy Trening")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _titleController,
//               decoration: InputDecoration(
//                 labelText: "Nazwa trenigu",
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(onPressed: (){
//               final title = _titleController.text.trim();
//               if(title.isNotEmpty){
//                 Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => TrainingDetailsPage(title:title),
//                 ),
//                 );
//               }
//             }
            
//             , child: Text("Dalej"),
//             )
//           ],
//         )
//         ),
//     );
//   }
// }

// class TrainingDetailsPage extends StatelessWidget{
//   final String title;

//   const TrainingDetailsPage({required this.title});
  
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(title:Text(title)),
//       body: Center(
//         child: ElevatedButton(onPressed: (){
//           Navigator.push(context,
//           MaterialPageRoute(builder: (context) => NewTrainingPage()
//           ),
//           );
//         },
//          child: Text("Dodaj Ćwiczenie"),
//          ),
//       ),
//     );
//   }

// }