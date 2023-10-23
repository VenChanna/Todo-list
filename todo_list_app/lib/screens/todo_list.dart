import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/colors.dart';
import 'package:todo_list_app/widgets/list_view_items.dart';
import 'package:todo_list_app/widgets/search_bar.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lighGray,
      appBar: AppBar(
        backgroundColor: secondary,
        title: const Center(
          child: Text(
            "Todo List",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            const SearchBarX(),
            ListViewItems(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: secondary,
        shape: const CircularNotchedRectangle(),
        child: Container(height: 30.0),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () {},
        tooltip: "Add Todo List",
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
