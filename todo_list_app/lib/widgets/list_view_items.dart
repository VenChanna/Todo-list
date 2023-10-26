import 'package:flutter/material.dart';
import 'package:todo_list_app/controllers/todo_controller.dart';
import 'package:todo_list_app/widgets/todo_item.dart';
import 'package:get/get.dart';

class ListViewItems extends StatelessWidget {
  ListViewItems({super.key});

  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: todoController.tasks.length,
          itemBuilder: ((context, index) {
            return TodoItemX(
              todo: todoController.tasks[index],
            );
          }),
        ),
      ),
    );
  }
}
