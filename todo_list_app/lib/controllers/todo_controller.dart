import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/models/todo_model.dart';

class TodoController extends GetxController {
  final FirebaseFirestore firebaseService = FirebaseFirestore.instance;
  final RxList<ToDoModel> tasks = <ToDoModel>[].obs;
  final RxString searchQuery = ''.obs;

  void fetchTasks() {
    firebaseService.collection('tasks').snapshots().listen((querySnapshot) {
      tasks.value = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return ToDoModel(
            id: doc.id, todoText: data['todoText'], isDone: data['isDone']);
      }).toList();
    });
  }

  void addTask(String todoText) {
    firebaseService
        .collection('tasks')
        .add({'todoText': todoText, 'isDone': false});
  }

  void updateTask(String id, bool isDone) {
    firebaseService.collection('tasks').doc(id).update({'isDone': isDone});
  }

  void deleteTask(String id) {
    firebaseService.collection('tasks').doc(id).delete();
  }

  void editTask(String id, String todoText) {
    firebaseService.collection('tasks').doc(id).update({'todoText': todoText});
  }

  void searchTasks() {
    if (searchQuery.isEmpty) {
      fetchTasks();
    } else {
      tasks.value = tasks
          .where((task) => task.todoText!
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
      
    }
  }

  bool checkExistingTask(String todoText) {
    return tasks
        .any((task) => task.todoText?.toLowerCase() == todoText.toLowerCase());
  }

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }
}
