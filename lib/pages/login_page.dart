import 'package:flutter/material.dart';
import 'package:gymapp/models/database_helper.dart';
import 'package:gymapp/models/training.dart';
import 'package:gymapp/models/user.dart';



class LoginPage extends StatefulWidget{

  @override
  _LoginPageState createState() => _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage>{
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  List<Training> trainingList =[];
  User? user = null;

  @override
  void dispose(){
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }


  void _submitForm() async{
     if (_formKey.currentState!.validate()) {
    final email = _emailController.text.trim();
    final name = _usernameController.text.trim();

    final dbHelper = DatabaseHelper();

    bool exists = await dbHelper.userExists(email);
      if (exists){
        trainingList = await DatabaseHelper().getTrainingsByUser(_emailController.text);
        user = await DatabaseHelper().getUser(_emailController.text);

      }
      else{
        final db = await DatabaseHelper().database;
        int userId = await db.insert('users', {
          'name': _usernameController.text,
          'email': _emailController.text
        });
        user = await DatabaseHelper().getUser(_emailController.text);
        print("User $_usernameController.text has been created ");
        trainingList =[];
      }
    }
    Navigator.pop(context, {'trainingList' : trainingList, 'user': user});
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Zaloguj się")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: "Nazwa użytkownika"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Wprowadź nazwę użytkownika';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Wprowadź email';
                  }
                  if (!value.contains('@')) {
                    return 'Email musi zawierać @';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Zaloguj"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  
