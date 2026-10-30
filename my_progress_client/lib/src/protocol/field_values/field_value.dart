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

abstract class FieldValue implements _i1.SerializableModel {
  FieldValue._({
    this.id,
    required this.dailyLogId,
    required this.fieldId,
    required this.value,
  });

  factory FieldValue({
    int? id,
    required int dailyLogId,
    required int fieldId,
    required String value,
  }) = _FieldValueImpl;

  factory FieldValue.fromJson(Map<String, dynamic> jsonSerialization) {
    return FieldValue(
      id: jsonSerialization['id'] as int?,
      dailyLogId: jsonSerialization['dailyLogId'] as int,
      fieldId: jsonSerialization['fieldId'] as int,
      value: jsonSerialization['value'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int dailyLogId;

  int fieldId;

  String value;

  /// Returns a shallow copy of this [FieldValue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FieldValue copyWith({
    int? id,
    int? dailyLogId,
    int? fieldId,
    String? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FieldValue',
      if (id != null) 'id': id,
      'dailyLogId': dailyLogId,
      'fieldId': fieldId,
      'value': value,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FieldValueImpl extends FieldValue {
  _FieldValueImpl({
    int? id,
    required int dailyLogId,
    required int fieldId,
    required String value,
  }) : super._(
         id: id,
         dailyLogId: dailyLogId,
         fieldId: fieldId,
         value: value,
       );

  /// Returns a shallow copy of this [FieldValue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FieldValue copyWith({
    Object? id = _Undefined,
    int? dailyLogId,
    int? fieldId,
    String? value,
  }) {
    return FieldValue(
      id: id is int? ? id : this.id,
      dailyLogId: dailyLogId ?? this.dailyLogId,
      fieldId: fieldId ?? this.fieldId,
      value: value ?? this.value,
    );
  }
}
