import 'package:timevisualer/core/model/task_model.dart';

class UserService {
  List<TaskModel> tasks = [];

  TaskModel getTask(String taskName) {
    for (TaskModel taskModel in this.tasks) {
      if (taskModel.name == taskName) {
        return taskModel;
      }
    }
    return null;
  }

  void createTask(
    String taskName,
    List<int> dPerWeek,
    List<DateTime> time,
    bool repeatOccurrence,
  ) {
    if (this.getTask(taskName) == null) {
      this.tasks.add(TaskModel(taskName));
    }
    TaskModel taskk = this.getTask(taskName);
    taskk.createOccurence(dPerWeek, time, repeatOccurrence);
  }
}
