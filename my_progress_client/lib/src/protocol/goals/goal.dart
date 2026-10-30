/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Goal implements _i1.SerializableModel {
  Goal._({
    this.id,
    this.topicId,
    this.subtopicId,
    this.fieldId,
    required this.title,
    this.description,
    required this.targetValue,
    required this.startDate,
    required this.endDate,
    required this.direction,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Goal({
    int? id,
    int? topicId,
    int? subtopicId,
    int? fieldId,
    required String title,
    String? description,
    required double targetValue,
    required DateTime startDate,
    required DateTime endDate,
    required String direction,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _GoalImpl;

  factory Goal.fromJson(Map<String, dynamic> jsonSerialization) {
    return Goal(
      id: jsonSerialization['id'] as int?,
      topicId: jsonSerialization['topicId'] as int?,
      subtopicId: jsonSerialization['subtopicId'] as int?,
      fieldId: jsonSerialization['fieldId'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      targetValue: (jsonSerialization['targetValue'] as num).toDouble(),
      startDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      direction: jsonSerialization['direction'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? topicId;

  int? subtopicId;

  int? fieldId;

  String title;

  String? description;

  double targetValue;

  DateTime startDate;

  DateTime endDate;

  String direction;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Goal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Goal copyWith({
    int? id,
    int? topicId,
    int? subtopicId,
    int? fieldId,
    String? title,
    String? description,
    double? targetValue,
    DateTime? startDate,
    DateTime? endDate,
    String? direction,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Goal',
      if (id != null) 'id': id,
      if (topicId != null) 'topicId': topicId,
      if (subtopicId != null) 'subtopicId': subtopicId,
      if (fieldId != null) 'fieldId': fieldId,
      'title': title,
      if (description != null) 'description': description,
      'targetValue': targetValue,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'direction': direction,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GoalImpl extends Goal {
  _GoalImpl({
    int? id,
    int? topicId,
    int? subtopicId,
    int? fieldId,
    required String title,
    String? description,
    required double targetValue,
    required DateTime startDate,
    required DateTime endDate,
    required String direction,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         topicId: topicId,
         subtopicId: subtopicId,
         fieldId: fieldId,
         title: title,
         description: description,
         targetValue: targetValue,
         startDate: startDate,
         endDate: endDate,
         direction: direction,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Goal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Goal copyWith({
    Object? id = _Undefined,
    Object? topicId = _Undefined,
    Object? subtopicId = _Undefined,
    Object? fieldId = _Undefined,
    String? title,
    Object? description = _Undefined,
    double? targetValue,
    DateTime? startDate,
    DateTime? endDate,
    String? direction,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Goal(
      id: id is int? ? id : this.id,
      topicId: topicId is int? ? topicId : this.topicId,
      subtopicId: subtopicId is int? ? subtopicId : this.subtopicId,
      fieldId: fieldId is int? ? fieldId : this.fieldId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      targetValue: targetValue ?? this.targetValue,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      direction: direction ?? this.direction,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
