import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/constants/colors.dart';
import 'package:todo_list_app/controllers/todo_controller.dart';

class SearchBarX extends StatelessWidget {
  SearchBarX({super.key});

  final TodoController todoController = Get.put(TodoController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          _searchBox(),
        ],
      ),
    );
  }

  Widget _searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        onChanged: (value) {
          todoController.searchQuery.value = value;
          todoController.searchTasks();
        },
        cursorColor: Colors.grey,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: gray9c,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: gray9c)),
      ),
    );
  }
}
