import 'package:flutter/material.dart';
import 'package:todolist/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/util/dialog_box.dart';
import 'package:todolist/util/todo_tile.dart';

class HomePage extends StatefulWidget{
  const HomePage ({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  
  @override
  void initState() {
    // First time creating app this help create default data
    if (_myBox.get("TODOLIST")== null ){
      db.createInitialData();
    }else{
      //if already exist data
      db.loadData();
    }

    super.initState();
  }
  //text controller
  final _controller = TextEditingController();

  // method : Checkbox was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updataDataBase();
  }

  //save new task

  void saveNewTask() {
    setState((){
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }     

  //create a new task 
  void createNewTask(){
    showDialog(
      context: context,
     builder: (context){
      return Dialogbox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
        );
     });
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updataDataBase();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar:AppBar(
        centerTitle: true, 
        title: Text('Regimen Vitae by Aan'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon( Icons.add),
      ),

      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder:(context, index){
          return ToDoTile(
            taskName: db.toDoList[index][0], 
            taskCompleted: db.toDoList[index][1], 
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            );
        },
      )
    );
  }
}