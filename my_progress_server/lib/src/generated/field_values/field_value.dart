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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class FieldValue
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = FieldValueTable();

  static const db = FieldValueRepository._();

  @override
  int? id;

  int dailyLogId;

  int fieldId;

  String value;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FieldValue',
      if (id != null) 'id': id,
      'dailyLogId': dailyLogId,
      'fieldId': fieldId,
      'value': value,
    };
  }

  static FieldValueInclude include() {
    return FieldValueInclude._();
  }

  static FieldValueIncludeList includeList({
    _i1.WhereExpressionBuilder<FieldValueTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FieldValueTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FieldValueTable>? orderByList,
    FieldValueInclude? include,
  }) {
    return FieldValueIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FieldValue.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FieldValue.t),
      include: include,
    );
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

class FieldValueUpdateTable extends _i1.UpdateTable<FieldValueTable> {
  FieldValueUpdateTable(super.table);

  _i1.ColumnValue<int, int> dailyLogId(int value) => _i1.ColumnValue(
    table.dailyLogId,
    value,
  );

  _i1.ColumnValue<int, int> fieldId(int value) => _i1.ColumnValue(
    table.fieldId,
    value,
  );

  _i1.ColumnValue<String, String> value(String value) => _i1.ColumnValue(
    table.value,
    value,
  );
}

class FieldValueTable extends _i1.Table<int?> {
  FieldValueTable({super.tableRelation}) : super(tableName: 'field_value') {
    updateTable = FieldValueUpdateTable(this);
    dailyLogId = _i1.ColumnInt(
      'dailyLogId',
      this,
    );
    fieldId = _i1.ColumnInt(
      'fieldId',
      this,
    );
    value = _i1.ColumnString(
      'value',
      this,
    );
  }

  late final FieldValueUpdateTable updateTable;

  late final _i1.ColumnInt dailyLogId;

  late final _i1.ColumnInt fieldId;

  late final _i1.ColumnString value;

  @override
  List<_i1.Column> get columns => [
    id,
    dailyLogId,
    fieldId,
    value,
  ];
}

class FieldValueInclude extends _i1.IncludeObject {
  FieldValueInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FieldValue.t;
}

class FieldValueIncludeList extends _i1.IncludeList {
  FieldValueIncludeList._({
    _i1.WhereExpressionBuilder<FieldValueTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FieldValue.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FieldValue.t;
}

class FieldValueRepository {
  const FieldValueRepository._();

  /// Returns a list of [FieldValue]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<FieldValue>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FieldValueTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FieldValueTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FieldValueTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FieldValue>(
      where: where?.call(FieldValue.t),
      orderBy: orderBy?.call(FieldValue.t),
      orderByList: orderByList?.call(FieldValue.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FieldValue] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<FieldValue?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FieldValueTable>? where,
    int? offset,
    _i1.OrderByBuilder<FieldValueTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FieldValueTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FieldValue>(
      where: where?.call(FieldValue.t),
      orderBy: orderBy?.call(FieldValue.t),
      orderByList: orderByList?.call(FieldValue.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FieldValue] by its [id] or null if no such row exists.
  Future<FieldValue?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FieldValue>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FieldValue]s in the list and returns the inserted rows.
  ///
  /// The returned [FieldValue]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FieldValue>> insert(
    _i1.DatabaseSession session,
    List<FieldValue> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FieldValue>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FieldValue] and returns the inserted row.
  ///
  /// The returned [FieldValue] will have its `id` field set.
  Future<FieldValue> insertRow(
    _i1.DatabaseSession session,
    FieldValue row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FieldValue>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FieldValue]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FieldValue>> update(
    _i1.DatabaseSession session,
    List<FieldValue> rows, {
    _i1.ColumnSelections<FieldValueTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FieldValue>(
      rows,
      columns: columns?.call(FieldValue.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FieldValue]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FieldValue> updateRow(
    _i1.DatabaseSession session,
    FieldValue row, {
    _i1.ColumnSelections<FieldValueTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FieldValue>(
      row,
      columns: columns?.call(FieldValue.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FieldValue] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FieldValue?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<FieldValueUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FieldValue>(
      id,
      columnValues: columnValues(FieldValue.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FieldValue]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FieldValue>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FieldValueUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FieldValueTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FieldValueTable>? orderBy,
    _i1.OrderByListBuilder<FieldValueTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FieldValue>(
      columnValues: columnValues(FieldValue.t.updateTable),
      where: where(FieldValue.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FieldValue.t),
      orderByList: orderByList?.call(FieldValue.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FieldValue]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FieldValue>> delete(
    _i1.DatabaseSession session,
    List<FieldValue> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FieldValue>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FieldValue].
  Future<FieldValue> deleteRow(
    _i1.DatabaseSession session,
    FieldValue row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FieldValue>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FieldValue>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FieldValueTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FieldValue>(
      where: where(FieldValue.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FieldValueTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FieldValue>(
      where: where?.call(FieldValue.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FieldValue] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FieldValueTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FieldValue>(
      where: where(FieldValue.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
