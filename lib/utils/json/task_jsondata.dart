class TaskData {
  int userTodoListId;
  String userTodoListTitle;
  String userTodoListDesc;
  String userTodoListCompleted;
  DateTime userTodoListLastUpdate;
  int userId;
  int userTodoTypeId;
  String userTodoTypeName;

  TaskData({
    required this.userTodoListId,
    required this.userTodoListTitle,
    required this.userTodoListDesc,
    required this.userTodoListCompleted,
    required this.userTodoListLastUpdate,
    required this.userId,
    required this.userTodoTypeId,
    required this.userTodoTypeName,
  });

  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      userTodoListId: json['user_todo_list_id'],
      userTodoListTitle: json['user_todo_list_title'],
      userTodoListDesc: json['user_todo_list_desc'],
      userTodoListCompleted: json['user_todo_list_completed'],
      userTodoListLastUpdate: DateTime.parse(json['user_todo_list_last_update']),
      userId: json['user_id'],
      userTodoTypeId: json['user_todo_type_id'],
      userTodoTypeName: json['user_todo_type_name'],
    );
  }
}

