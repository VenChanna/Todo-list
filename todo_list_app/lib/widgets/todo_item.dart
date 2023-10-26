import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/controllers/todo_controller.dart';
import 'package:todo_list_app/constants/colors.dart';
import 'package:todo_list_app/models/todo_model.dart';

// ignore: must_be_immutable
class TodoItemX extends StatelessWidget {
  final ToDoModel todo;
  String taskText = "";
  TodoItemX({Key? key, required this.todo}) : super(key: key);

  final TodoController todoController = Get.put(TodoController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: ListTile(
          onTap: () {
            if (todo.id != null) {
              todoController.updateTask(todo.id!, !todo.isDone);
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
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
                decoration: todo.isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: _icons()),
    );
  }

  Widget _icons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.edit),
            onPressed: () => {editDialog()},
          ),
        ),
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
            onPressed: () => {
              if (todo.id != null) {todoController.deleteTask(todo.id!)}
            },
          ),
        ),
      ],
    );
  }

  void editDialog() {
    Get.dialog(
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: _buildEditTaskDialogContent(),
        ),
      ),
    );
  }

  Widget _buildEditTaskDialogContent() {
    textEditingController.text = todo.todoText!;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              const Text(
                "Update task",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: textEditingController,
                keyboardType: TextInputType.multiline,
                cursorColor: Colors.grey,
                maxLines: null,
                onChanged: (text) {
                  taskText = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  hintText: "Todo task",
                  hintStyle: const TextStyle(color: gray9c),
                ),
              ),
              const SizedBox(height: 20),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
              backgroundColor: gray9c,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancel',
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
              backgroundColor: primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              if (taskText.isEmpty) {
                Get.dialog(
                  AlertDialog(
                    content: const Text("Please write something.",
                        style: TextStyle(color: Colors.red)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              } else {
                var check = todoController.checkExistingTask(taskText);
                if (check) {
                  Get.dialog(
                    AlertDialog(
                      content: const Text("Task is already exist.",
                          style: TextStyle(color: Colors.red)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                } else {
                  todoController.editTask(todo.id!, taskText);
                  textEditingController.clear();
                  Get.back();
                }
              }
            },
            child: const Text(
              'Update',
            ),
          ),
        ),
      ],
    );
  }
}
