import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class SubtopicEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  String _currentUserId(Session session) {
    return session.authenticated!.userIdentifier;
  }

  // Check whether the signed-in user owns the parent topic.
  Future<bool> _ownsTopic(
    Session session,
    int topicId,
  ) async {
    final topic = await Topic.db.findById(session, topicId);

    return topic != null &&
        topic.ownerUserIdentifier == _currentUserId(session);
  }

  // Retrieve subtopics only from a topic owned by this user.
  Future<List<Subtopic>> getSubtopics(
    Session session,
    int topicId,
  ) async {
    if (!await _ownsTopic(session, topicId)) {
      return [];
    }

    return await Subtopic.db.find(
      session,
      where: (t) => t.topicId.equals(topicId),
    );
  }

  // Create a subtopic only under the user's own topic.
  Future<Subtopic> createSubtopic(
    Session session,
    int topicId,
    String name,
    String? description,
  ) async {
    if (!await _ownsTopic(session, topicId)) {
      throw Exception('Topic not found or access denied.');
    }

    final subtopic = Subtopic(
      topicId: topicId,
      name: name,
      description: description,
      createdAt: DateTime.now(),
    );

    return await Subtopic.db.insertRow(session, subtopic);
  }

  // Update a subtopic only if its parent topic belongs to this user.
  Future<Subtopic?> updateSubtopic(
    Session session,
    int subtopicId,
    String name,
    String? description,
  ) async {
    final subtopic = await Subtopic.db.findById(
      session,
      subtopicId,
    );

    if (subtopic == null ||
        !await _ownsTopic(session, subtopic.topicId)) {
      return null;
    }

    subtopic.name = name;
    subtopic.description = description;

    return await Subtopic.db.updateRow(session, subtopic);
  }

  // Delete a subtopic only if its parent topic belongs to this user.
  Future<bool> deleteSubtopic(
    Session session,
    int subtopicId,
  ) async {
    final subtopic = await Subtopic.db.findById(
      session,
      subtopicId,
    );

    if (subtopic == null ||
        !await _ownsTopic(session, subtopic.topicId)) {
      return false;
    }

    // Find fields and daily logs belonging to this subtopic.
    final fields = await Field.db.find(
      session,
      where: (t) => t.subtopicId.equals(subtopicId),
    );

    final logs = await DailyLog.db.find(
      session,
      where: (t) => t.subtopicId.equals(subtopicId),
    );

    // Delete saved values associated with daily logs.
    for (final log in logs) {
      final logId = log.id;
      if (logId == null) continue;

      final values = await FieldValue.db.find(
        session,
        where: (t) => t.dailyLogId.equals(logId),
      );

      for (final value in values) {
        await FieldValue.db.deleteRow(session, value);
      }
    }

    // Delete any remaining values associated with fields.
    for (final field in fields) {
      final fieldId = field.id;
      if (fieldId == null) continue;

      final values = await FieldValue.db.find(
        session,
        where: (t) => t.fieldId.equals(fieldId),
      );

      for (final value in values) {
        await FieldValue.db.deleteRow(session, value);
      }
    }

    // Delete the fields.
    for (final field in fields) {
      await Field.db.deleteRow(session, field);
    }

    // Delete the daily logs.
    for (final log in logs) {
      await DailyLog.db.deleteRow(session, log);
    }

    // Delete the subtopic itself.
    await Subtopic.db.deleteRow(session, subtopic);

    return true;
  }
}
