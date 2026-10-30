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
import 'daily_logs/daily_log.dart' as _i2;
import 'field_values/field_value.dart' as _i3;
import 'fields/field.dart' as _i4;
import 'goals/goal.dart' as _i5;
import 'greetings/greeting.dart' as _i6;
import 'subtopics/subtopic.dart' as _i7;
import 'topics/topic.dart' as _i8;
import 'package:my_progress_client/src/protocol/daily_logs/daily_log.dart'
    as _i9;
import 'package:my_progress_client/src/protocol/field_values/field_value.dart'
    as _i10;
import 'package:my_progress_client/src/protocol/fields/field.dart' as _i11;
import 'package:my_progress_client/src/protocol/subtopics/subtopic.dart'
    as _i12;
import 'package:my_progress_client/src/protocol/topics/topic.dart' as _i13;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i14;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i15;
export 'daily_logs/daily_log.dart';
export 'field_values/field_value.dart';
export 'fields/field.dart';
export 'goals/goal.dart';
export 'greetings/greeting.dart';
export 'subtopics/subtopic.dart';
export 'topics/topic.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.DailyLog) {
      return _i2.DailyLog.fromJson(data) as T;
    }
    if (t == _i3.FieldValue) {
      return _i3.FieldValue.fromJson(data) as T;
    }
    if (t == _i4.Field) {
      return _i4.Field.fromJson(data) as T;
    }
    if (t == _i5.Goal) {
      return _i5.Goal.fromJson(data) as T;
    }
    if (t == _i6.Greeting) {
      return _i6.Greeting.fromJson(data) as T;
    }
    if (t == _i7.Subtopic) {
      return _i7.Subtopic.fromJson(data) as T;
    }
    if (t == _i8.Topic) {
      return _i8.Topic.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.DailyLog?>()) {
      return (data != null ? _i2.DailyLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.FieldValue?>()) {
      return (data != null ? _i3.FieldValue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Field?>()) {
      return (data != null ? _i4.Field.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Goal?>()) {
      return (data != null ? _i5.Goal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Greeting?>()) {
      return (data != null ? _i6.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Subtopic?>()) {
      return (data != null ? _i7.Subtopic.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Topic?>()) {
      return (data != null ? _i8.Topic.fromJson(data) : null) as T;
    }
    if (t == List<_i9.DailyLog>) {
      return (data as List).map((e) => deserialize<_i9.DailyLog>(e)).toList()
          as T;
    }
    if (t == List<_i10.FieldValue>) {
      return (data as List).map((e) => deserialize<_i10.FieldValue>(e)).toList()
          as T;
    }
    if (t == List<_i11.Field>) {
      return (data as List).map((e) => deserialize<_i11.Field>(e)).toList()
          as T;
    }
    if (t == List<_i12.Subtopic>) {
      return (data as List).map((e) => deserialize<_i12.Subtopic>(e)).toList()
          as T;
    }
    if (t == List<_i13.Topic>) {
      return (data as List).map((e) => deserialize<_i13.Topic>(e)).toList()
          as T;
    }
    try {
      return _i14.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i15.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.DailyLog => 'DailyLog',
      _i3.FieldValue => 'FieldValue',
      _i4.Field => 'Field',
      _i5.Goal => 'Goal',
      _i6.Greeting => 'Greeting',
      _i7.Subtopic => 'Subtopic',
      _i8.Topic => 'Topic',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('my_progress.', '');
    }

    switch (data) {
      case _i2.DailyLog():
        return 'DailyLog';
      case _i3.FieldValue():
        return 'FieldValue';
      case _i4.Field():
        return 'Field';
      case _i5.Goal():
        return 'Goal';
      case _i6.Greeting():
        return 'Greeting';
      case _i7.Subtopic():
        return 'Subtopic';
      case _i8.Topic():
        return 'Topic';
    }
    className = _i14.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i15.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'DailyLog') {
      return deserialize<_i2.DailyLog>(data['data']);
    }
    if (dataClassName == 'FieldValue') {
      return deserialize<_i3.FieldValue>(data['data']);
    }
    if (dataClassName == 'Field') {
      return deserialize<_i4.Field>(data['data']);
    }
    if (dataClassName == 'Goal') {
      return deserialize<_i5.Goal>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i6.Greeting>(data['data']);
    }
    if (dataClassName == 'Subtopic') {
      return deserialize<_i7.Subtopic>(data['data']);
    }
    if (dataClassName == 'Topic') {
      return deserialize<_i8.Topic>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i14.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i15.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i14.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i15.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
