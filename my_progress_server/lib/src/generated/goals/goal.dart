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

abstract class Goal implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = GoalTable();

  static const db = GoalRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static GoalInclude include() {
    return GoalInclude._();
  }

  static GoalIncludeList includeList({
    _i1.WhereExpressionBuilder<GoalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GoalTable>? orderByList,
    GoalInclude? include,
  }) {
    return GoalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Goal.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Goal.t),
      include: include,
    );
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

class GoalUpdateTable extends _i1.UpdateTable<GoalTable> {
  GoalUpdateTable(super.table);

  _i1.ColumnValue<int, int> topicId(int? value) => _i1.ColumnValue(
    table.topicId,
    value,
  );

  _i1.ColumnValue<int, int> subtopicId(int? value) => _i1.ColumnValue(
    table.subtopicId,
    value,
  );

  _i1.ColumnValue<int, int> fieldId(int? value) => _i1.ColumnValue(
    table.fieldId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<double, double> targetValue(double value) => _i1.ColumnValue(
    table.targetValue,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startDate(DateTime value) =>
      _i1.ColumnValue(
        table.startDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endDate(DateTime value) =>
      _i1.ColumnValue(
        table.endDate,
        value,
      );

  _i1.ColumnValue<String, String> direction(String value) => _i1.ColumnValue(
    table.direction,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class GoalTable extends _i1.Table<int?> {
  GoalTable({super.tableRelation}) : super(tableName: 'goal') {
    updateTable = GoalUpdateTable(this);
    topicId = _i1.ColumnInt(
      'topicId',
      this,
    );
    subtopicId = _i1.ColumnInt(
      'subtopicId',
      this,
    );
    fieldId = _i1.ColumnInt(
      'fieldId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    targetValue = _i1.ColumnDouble(
      'targetValue',
      this,
    );
    startDate = _i1.ColumnDateTime(
      'startDate',
      this,
    );
    endDate = _i1.ColumnDateTime(
      'endDate',
      this,
    );
    direction = _i1.ColumnString(
      'direction',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final GoalUpdateTable updateTable;

  late final _i1.ColumnInt topicId;

  late final _i1.ColumnInt subtopicId;

  late final _i1.ColumnInt fieldId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnDouble targetValue;

  late final _i1.ColumnDateTime startDate;

  late final _i1.ColumnDateTime endDate;

  late final _i1.ColumnString direction;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    topicId,
    subtopicId,
    fieldId,
    title,
    description,
    targetValue,
    startDate,
    endDate,
    direction,
    createdAt,
    updatedAt,
  ];
}

class GoalInclude extends _i1.IncludeObject {
  GoalInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Goal.t;
}

class GoalIncludeList extends _i1.IncludeList {
  GoalIncludeList._({
    _i1.WhereExpressionBuilder<GoalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Goal.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Goal.t;
}

class GoalRepository {
  const GoalRepository._();

  /// Returns a list of [Goal]s matching the given query parameters.
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
  Future<List<Goal>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GoalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GoalTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Goal>(
      where: where?.call(Goal.t),
      orderBy: orderBy?.call(Goal.t),
      orderByList: orderByList?.call(Goal.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Goal] matching the given query parameters.
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
  Future<Goal?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GoalTable>? where,
    int? offset,
    _i1.OrderByBuilder<GoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GoalTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Goal>(
      where: where?.call(Goal.t),
      orderBy: orderBy?.call(Goal.t),
      orderByList: orderByList?.call(Goal.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Goal] by its [id] or null if no such row exists.
  Future<Goal?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Goal>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Goal]s in the list and returns the inserted rows.
  ///
  /// The returned [Goal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Goal>> insert(
    _i1.DatabaseSession session,
    List<Goal> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Goal>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Goal] and returns the inserted row.
  ///
  /// The returned [Goal] will have its `id` field set.
  Future<Goal> insertRow(
    _i1.DatabaseSession session,
    Goal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Goal>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Goal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Goal>> update(
    _i1.DatabaseSession session,
    List<Goal> rows, {
    _i1.ColumnSelections<GoalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Goal>(
      rows,
      columns: columns?.call(Goal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Goal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Goal> updateRow(
    _i1.DatabaseSession session,
    Goal row, {
    _i1.ColumnSelections<GoalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Goal>(
      row,
      columns: columns?.call(Goal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Goal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Goal?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<GoalUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Goal>(
      id,
      columnValues: columnValues(Goal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Goal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Goal>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<GoalUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<GoalTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GoalTable>? orderBy,
    _i1.OrderByListBuilder<GoalTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Goal>(
      columnValues: columnValues(Goal.t.updateTable),
      where: where(Goal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Goal.t),
      orderByList: orderByList?.call(Goal.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Goal]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Goal>> delete(
    _i1.DatabaseSession session,
    List<Goal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Goal>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Goal].
  Future<Goal> deleteRow(
    _i1.DatabaseSession session,
    Goal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Goal>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Goal>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<GoalTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Goal>(
      where: where(Goal.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GoalTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Goal>(
      where: where?.call(Goal.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Goal] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<GoalTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Goal>(
      where: where(Goal.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
