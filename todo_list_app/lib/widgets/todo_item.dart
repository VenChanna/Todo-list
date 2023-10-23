import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/colors.dart';
import 'package:todo_list_app/models/TodoModel.dart';

class TodoItemX extends StatelessWidget {
  final ToDoModel todo;
  const TodoItemX({Key? key, required this.todo}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: primary,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: todo.isDone? TextDecoration.lineThrough : null),
        ),
        trailing: 
        // Row(
        //   children: [
        //     Container(
        //       padding: const EdgeInsets.all(0),
        //       height: 35,
        //       width: 35,
        //       decoration: BoxDecoration(
        //         color: Colors.redAccent,
        //         borderRadius: BorderRadius.circular(5),
        //       ),
        //       child: IconButton(
        //         color: Colors.white,
        //         iconSize: 18,
        //         icon: const Icon(Icons.edit),
        //         onPressed: () => {},
        //       ),
        //     ),
            Container(
              padding: const EdgeInsets.all(0),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: const Icon(Icons.delete),
                onPressed: () => {},
              ),
            ),
        //   ],
        // ),
      ),
    );
  }
}
