class TaskEditJsonData {
  final int? userTodoListId;
  final String? userTodoListTitle;
  final String? userTodoListDesc;
  final String? userTodoListCompleted;
  final DateTime? userTodoListLastUpdate;
  final int? userId;
  final int? userTodoTypeId;
  final String? userTodoTypeName;

  TaskEditJsonData({
    this.userTodoListId,
    this.userTodoListTitle,
    this.userTodoListDesc,
    this.userTodoListCompleted,
    this.userTodoListLastUpdate,
    this.userId,
    this.userTodoTypeId,
    this.userTodoTypeName,
  });

  TaskEditJsonData copyWith({
    int? userTodoListId,
    String? userTodoListTitle,
    String? userTodoListDesc,
    String? userTodoListCompleted,
    DateTime? userTodoListLastUpdate,
    int? userId,
    int? userTodoTypeId,
    String? userTodoTypeName,
  }) =>
      TaskEditJsonData(
        userTodoListId: userTodoListId ?? this.userTodoListId,
        userTodoListTitle: userTodoListTitle ?? this.userTodoListTitle,
        userTodoListDesc: userTodoListDesc ?? this.userTodoListDesc,
        userTodoListCompleted:
            userTodoListCompleted ?? this.userTodoListCompleted,
        userTodoListLastUpdate:
            userTodoListLastUpdate ?? this.userTodoListLastUpdate,
        userId: userId ?? this.userId,
        userTodoTypeId: userTodoTypeId ?? this.userTodoTypeId,
        userTodoTypeName: userTodoTypeName ?? this.userTodoTypeName,
      );

  factory TaskEditJsonData.fromJson(Map<String, dynamic> json) {
    return TaskEditJsonData(
      userTodoListId: json['user_todo_list_id'],
      userTodoListTitle: json['user_todo_list_title'],
      userTodoListDesc: json['user_todo_list_desc'],
      userTodoListCompleted: json['user_todo_list_completed'],
      userTodoListLastUpdate: json['user_todo_list_last_update'] != null
          ? DateTime.parse(json['user_todo_list_last_update'])
          : null,
      userId: json['user_id'],
      userTodoTypeId: json['user_todo_type_id'],
      userTodoTypeName: json['user_todo_type_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_todo_list_id': userTodoListId,
      'user_todo_list_title': userTodoListTitle,
      'user_todo_list_desc': userTodoListDesc,
      'user_todo_list_completed': userTodoListCompleted,
      'user_todo_list_last_update': userTodoListLastUpdate?.toIso8601String(),
      'user_id': userId,
      'user_todo_type_id': userTodoTypeId,
      'user_todo_type_name': userTodoTypeName,
    };
  }
}
