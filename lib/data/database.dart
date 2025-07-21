import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {

  List toDoList = [];
//reference our box
  final _myBox = Hive.box('mybox');

//run this method when open the app for the first time

void createInitialData() {
  toDoList = [
    ["Made by yours truely, Aan",false],
    ["21/7/2025",false],
  ];
}

  //load the data from the database
  void loadData() {
      toDoList = _myBox.get("TODOLIST");
  }

  void updataDataBase(){

    _myBox.put("TODOLIST", toDoList);
  }

}
