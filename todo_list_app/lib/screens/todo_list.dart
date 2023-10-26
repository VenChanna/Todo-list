import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/colors.dart';
import 'package:todo_list_app/controllers/todo_controller.dart';
import 'package:todo_list_app/widgets/list_view_items.dart';
import 'package:todo_list_app/widgets/search_bar.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TodoList extends StatelessWidget {
  String taskText = "";
  TodoList({super.key});

  final TodoController todoController = Get.put(TodoController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGray,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: secondary,
      title: const Center(
        child: Text(
          "To-Do List",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          SearchBarX(),
          _visibleTaskText(),
          _invisibleTaskText(),
          ListViewItems(),
        ],
      ),
    );
  }

  Widget _visibleTaskText() {
    return Obx(() {
      return Visibility(
        visible: todoController.tasks.isNotEmpty,
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          child: const Text(
            'All Todos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    });
  }

  Widget _invisibleTaskText() {
    return Obx(() {
      return Visibility(
        visible: todoController.tasks.isEmpty,
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          child: const Text(
            'No result. Create a new one instead.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    });
  }

  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      color: secondary,
      shape: const CircularNotchedRectangle(),
      child: Container(height: 30.0),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: primary,
      onPressed: () {
        showCreateTaskDialog();
      },
      tooltip: "Add Todo List",
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  void showCreateTaskDialog() {
    Get.dialog(
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: _buildCreateTaskDialogContent(),
        ),
      ),
    );
  }

  Widget _buildCreateTaskDialogContent() {
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
                "Create new task",
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
                    content: const Text("Please add a New Task.",
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
                textEditingController.clear();
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
                  textEditingController.clear();
                } else {
                  todoController.addTask(textEditingController.text);
                  textEditingController.clear();
                  Get.back();
                }
              }
            },
            child: const Text(
              'Save',
            ),
          ),
        ),
      ],
    );
  }
}
