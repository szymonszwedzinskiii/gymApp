import 'package:flutter/material.dart';
import 'package:gymapp/models/training.dart';
import 'package:gymapp/models/user.dart';
import 'package:gymapp/pages/exercise_card.dart';
import 'package:gymapp/pages/training_card.dart';
import 'package:gymapp/widgets/add_training_card.dart';
import 'package:gymapp/pages/login_page.dart';

class HomePage extends StatefulWidget {
  final List<Training>? trainingList;
  final User? user;
  HomePage({Key? key, this.user, this.trainingList }) :super(key:key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Training> _trainingList;
  User? _user;
  int _selectedIndex = 0;
  bool get isLoggedIn => _user != null;

  @override
  void initState(){
    super.initState();
    _trainingList = widget.trainingList ?? [];
    _user = widget.user ?? null;
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if(isLoggedIn) ...[
              AddTraining(),
              Expanded(
                child: _trainingList.isEmpty
                ? Center(child: Text("Brak Ćwiczeń"))
                : ListView.builder(
                  itemCount: _trainingList.length,
                  itemBuilder: (context,index){
                    final t = _trainingList[index];
                    return TrainingCard(training: t, 
                    onTap: (){
                      
                    },);
                }),
              )
            ] else ...[
            IconButton(
              icon: Icon(Icons.login),
              onPressed: () async {
                final result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginPage()),);
                if (result != null && result is Map){
                  setState(() {
                    _trainingList = result['trainingList'];
                    _user = result['user'];
                  });
                }
              },
            ),
            ],

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}