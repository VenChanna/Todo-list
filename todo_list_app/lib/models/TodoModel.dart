
class ToDoModel {
  String? id;
  String? todoText;
  bool isDone;

  ToDoModel({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDoModel> todoList() {
    return [
      ToDoModel(id: "01", todoText: "Wake up at 6:00am", isDone: true),
      ToDoModel(id: "01", todoText: "Do exercise", isDone: true),
      ToDoModel(id: "01", todoText: "Go to cafe shop", isDone: false),
      ToDoModel(id: "01", todoText: "Do assignment", isDone: false),
      ToDoModel(id: "01", todoText: "Go shopping", isDone: false),
      ToDoModel(id: "01", todoText: "Cook some meals", isDone: false),
    ];
  }
}
