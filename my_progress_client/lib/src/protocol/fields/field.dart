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

abstract class Field implements _i1.SerializableModel {
  Field._({
    this.id,
    required this.subtopicId,
    required this.name,
    required this.type,
    required this.position,
    required this.createdAt,
  });

  factory Field({
    int? id,
    required int subtopicId,
    required String name,
    required String type,
    required int position,
    required DateTime createdAt,
  }) = _FieldImpl;

  factory Field.fromJson(Map<String, dynamic> jsonSerialization) {
    return Field(
      id: jsonSerialization['id'] as int?,
      subtopicId: jsonSerialization['subtopicId'] as int,
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      position: jsonSerialization['position'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int subtopicId;

  String name;

  String type;

  int position;

  DateTime createdAt;

  /// Returns a shallow copy of this [Field]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Field copyWith({
    int? id,
    int? subtopicId,
    String? name,
    String? type,
    int? position,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Field',
      if (id != null) 'id': id,
      'subtopicId': subtopicId,
      'name': name,
      'type': type,
      'position': position,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FieldImpl extends Field {
  _FieldImpl({
    int? id,
    required int subtopicId,
    required String name,
    required String type,
    required int position,
    required DateTime createdAt,
  }) : super._(
         id: id,
         subtopicId: subtopicId,
         name: name,
         type: type,
         position: position,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Field]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Field copyWith({
    Object? id = _Undefined,
    int? subtopicId,
    String? name,
    String? type,
    int? position,
    DateTime? createdAt,
  }) {
    return Field(
      id: id is int? ? id : this.id,
      subtopicId: subtopicId ?? this.subtopicId,
      name: name ?? this.name,
      type: type ?? this.type,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
