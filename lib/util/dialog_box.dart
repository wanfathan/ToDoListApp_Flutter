import 'package:flutter/material.dart';
import 'package:todolist/util/my_button.dart';

class Dialogbox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  Dialogbox({super.key,
   required this.controller,
   required this.onSave,
   required this.onCancel,
   });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey.shade100,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
        //Get user input                                                                     
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add a new task", ),   
          ),
        //button -> save + cancel
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
        MyButton(text: "Save", onPressed: onSave),

        const SizedBox(width: 8),
        MyButton(text: "Cancel", onPressed: onCancel),
        ],
        )
        ])
      ),
    );
  }
}