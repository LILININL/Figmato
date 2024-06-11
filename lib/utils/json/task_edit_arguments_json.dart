class TaskEditPageArguments {
  final int taskId;
  final String initialTitle;
  final String initialDesc;
  final bool initialCompleted;

  const TaskEditPageArguments({
    required this.taskId,
    required this.initialTitle,
    required this.initialDesc,
    required this.initialCompleted,
  });
}
