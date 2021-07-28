import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class TaskStatus {
  final int taskID;
  final Status status;

  TaskStatus(this.taskID, this.status);

  // These methods are required for the @JsonSerializable
  factory TaskStatus.fromJson(Map<String, dynamic> json) => _$TaskStatusFromJson(json);
  Map<String, dynamic> toJson() => _$TaskStatusToJson(this);
}

@JsonSerializable()
class ChecklistProgress {
  final List<TaskStatus> taskStatuses;

  ChecklistProgress(List<TaskStatus> taskStatuses): 
    taskStatuses = List.from(taskStatuses);

  // These methods are required for the @JsonSerializable
  factory ChecklistProgress.fromJson(Map<String, dynamic> json) => _$ChecklistProgressFromJson(json);
  Map<String, dynamic> toJson() => _$ChecklistProgressToJson(this);

  @override
  String toString() {
    return taskStatuses.toString();
  }

  Status status(int taskID) {
    return taskStatuses.firstWhere((taskStatus) => taskStatus.taskID == taskID, orElse: () => null)?.status ?? Status.notStarted;
  }
}

enum Status { notStarted, inProgress, pendingVerification, completed }

extension StatusAvatar on Status {
  Color get color {
    switch (this) {
      case Status.notStarted:
        return Colors.red;
      case Status.inProgress:
        return Colors.orange;
      case Status.pendingVerification:
        return Colors.purple;
      case Status.completed:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget avatar(double radius) {
    switch (this) {
      case Status.inProgress:
        return CircleAvatar(
          radius: radius,
          backgroundColor: this.color,
          child: Icon(Icons.more_horiz, color: Colors.white)
        );
      case Status.pendingVerification:
        return CircleAvatar(
          radius: radius,
          backgroundColor: this.color,
          child: Icon(Icons.more_horiz, color: Colors.white)
        );
      case Status.completed:
        return CircleAvatar(
          radius: radius,
          backgroundColor: this.color,
          child: Icon(Icons.check, color: Colors.white)
        );
      default:
        return CircleAvatar(
          radius: radius,
          backgroundColor: Colors.grey,
          child: CircleAvatar(radius: radius / 3, backgroundColor: Colors.grey.shade50)
        );
    }
  }
}

@JsonSerializable()
class Task {
  final int id;
  final String title;
  final String text;
  final bool verificationRequired;
  final String location;
  final String office;
  final String pocName;
  final String pocPhoneNumber;
  final String pocEmail;

  Task({@required this.id, @required this.title, @required this.text, this.verificationRequired = false, this.location = "1234 Main St", this.office = "Finance", this.pocName = "Joan Moneybags", this.pocPhoneNumber = "123-456-7890", this.pocEmail = "joan@finance.mil"});

  // These methods are required for the @JsonSerializable
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

@JsonSerializable()
class Category {
  final int id;
  final String title;
  final List<Task> tasks;

  Category({@required this.id, @required this.tasks, @required this.title});

  // These methods are required for the @JsonSerializable
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Checklist extends Object {
  final List<Category> categories;

  Checklist({@required this.categories});

  // These methods are required for the @JsonSerializable
  factory Checklist.fromJson(Map<String, dynamic> json) =>
      _$ChecklistFromJson(json);
  Map<String, dynamic> toJson() => _$ChecklistToJson(this);
}
