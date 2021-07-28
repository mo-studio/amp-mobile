// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskStatus _$TaskStatusFromJson(Map<String, dynamic> json) {
  return TaskStatus(
    json['taskID'] as int,
    _$enumDecodeNullable(_$StatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$TaskStatusToJson(TaskStatus instance) =>
    <String, dynamic>{
      'taskID': instance.taskID,
      'status': _$StatusEnumMap[instance.status],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$StatusEnumMap = {
  Status.notStarted: 'notStarted',
  Status.inProgress: 'inProgress',
  Status.pendingVerification: 'pendingVerification',
  Status.completed: 'completed',
};

ChecklistProgress _$ChecklistProgressFromJson(Map<String, dynamic> json) {
  return ChecklistProgress(
    (json['taskStatuses'] as List)
        ?.map((e) =>
            e == null ? null : TaskStatus.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChecklistProgressToJson(ChecklistProgress instance) =>
    <String, dynamic>{
      'taskStatuses': instance.taskStatuses,
    };

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    id: json['id'] as int,
    title: json['title'] as String,
    text: json['text'] as String,
    verificationRequired: json['verificationRequired'] as bool,
    location: json['location'] as String,
    office: json['office'] as String,
    pocName: json['pocName'] as String,
    pocPhoneNumber: json['pocPhoneNumber'] as String,
    pocEmail: json['pocEmail'] as String,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'verificationRequired': instance.verificationRequired,
      'location': instance.location,
      'office': instance.office,
      'pocName': instance.pocName,
      'pocPhoneNumber': instance.pocPhoneNumber,
      'pocEmail': instance.pocEmail,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    id: json['id'] as int,
    tasks: (json['tasks'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tasks': instance.tasks,
    };

Checklist _$ChecklistFromJson(Map<String, dynamic> json) {
  return Checklist(
    categories: (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChecklistToJson(Checklist instance) => <String, dynamic>{
      'categories': instance.categories,
    };
