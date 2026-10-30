import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class FieldValueEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  String _currentUserId(Session session) {
    return session.authenticated!.userIdentifier;
  }

  // Check ownership of a subtopic through its parent topic.
  Future<bool> _ownsSubtopic(
    Session session,
    int subtopicId,
  ) async {
    final subtopic = await Subtopic.db.findById(
      session,
      subtopicId,
    );

    if (subtopic == null) {
      return false;
    }

    final topic = await Topic.db.findById(
      session,
      subtopic.topicId,
    );

    return topic != null &&
        topic.ownerUserIdentifier == _currentUserId(session);
  }

  Future<FieldValue> saveFieldValue(
    Session session,
    int dailyLogId,
    int fieldId,
    String value,
  ) async {
    final log = await DailyLog.db.findById(
      session,
      dailyLogId,
    );

    if (log == null) {
      throw Exception('Daily log not found or access denied.');
    }

    if (!await _ownsSubtopic(session, log.subtopicId)) {
      throw Exception('Daily log not found or access denied.');
    }

    final field = await Field.db.findById(
      session,
      fieldId,
    );

    if (field == null ||
        field.subtopicId != log.subtopicId ||
        !await _ownsSubtopic(session, field.subtopicId)) {
      throw Exception('Field not found or access denied.');
    }

    final fieldValue = FieldValue(
      dailyLogId: dailyLogId,
      fieldId: fieldId,
      value: value,
    );

    return await FieldValue.db.insertRow(
      session,
      fieldValue,
    );
  }

  Future<List<FieldValue>> getFieldValues(
    Session session,
    int dailyLogId,
  ) async {
    final log = await DailyLog.db.findById(
      session,
      dailyLogId,
    );

    if (log == null ||
        !await _ownsSubtopic(session, log.subtopicId)) {
      return [];
    }

    return await FieldValue.db.find(
      session,
      where: (t) => t.dailyLogId.equals(dailyLogId),
    );
  }
}
