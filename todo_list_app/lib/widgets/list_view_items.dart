import 'package:flutter/material.dart';
import 'package:todo_list_app/models/TodoModel.dart';
import 'package:todo_list_app/widgets/todo_item.dart';

class ListViewItems extends StatelessWidget {
  ListViewItems({super.key});

  final todoList = ToDoModel.todoList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: const Text(
              'All Todos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          for (ToDoModel todoItem in todoList)
            TodoItemX(todo: todoItem),
        ],
      ),
    );
  }
}
