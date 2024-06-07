class TaskEditJsonData {
  final String userTodoListId;
  final String userTodoListTitle;
  final String userTodoListDesc;
  final String userTodoListCompleted;
  final String userId;

  TaskEditJsonData({
    required this.userTodoListId,
    required this.userTodoListTitle,
    required this.userTodoListDesc,
    required this.userTodoListCompleted,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_todo_list_id': userTodoListId,
      'user_todo_list_title': userTodoListTitle,
      'user_todo_list_desc': userTodoListDesc,
      'user_todo_list_completed': userTodoListCompleted,
      'user_id': userId,
    };
  }
}
