class TaskAddJsonData {
  final int userTodoTypeId;
  final String userTodoListTitle;
  final String userTodoListDesc;
  final bool userTodoListCompleted;
  final int userId;

  TaskAddJsonData({
    required this.userTodoTypeId,
    required this.userTodoListTitle,
    required this.userTodoListDesc,
    required this.userTodoListCompleted,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_todo_type_id': userTodoTypeId,
      'user_todo_list_title': userTodoListTitle,
      'user_todo_list_desc': userTodoListDesc,
      'user_todo_list_completed':
          userTodoListCompleted.toString(), // หรือจะใช้เป็น `true` หรือ `false`
      'user_id': userId,
    };
  }
}
