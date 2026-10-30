import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class TopicEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  String _currentUserId(Session session) {
    return session.authenticated!.userIdentifier;
  }

  // Return only topics owned by the signed-in user.
  Future<List<Topic>> getTopics(Session session) async {
    final userId = _currentUserId(session);
    final topics = await Topic.db.find(session);

    return topics
        .where((topic) => topic.ownerUserIdentifier == userId)
        .toList();
  }

  // Assign every new topic to the signed-in user.
  Future<Topic> createTopic(
    Session session,
    String name,
    String? description,
  ) async {
    final topic = Topic(
      name: name,
      description: description,
      createdAt: DateTime.now(),
      ownerUserIdentifier: _currentUserId(session),
    );

    return await Topic.db.insertRow(session, topic);
  }

  // Update only a topic belonging to the signed-in user.
  Future<Topic?> updateTopic(
    Session session,
    int topicId,
    String name,
    String? description,
  ) async {
    final userId = _currentUserId(session);
    final topic = await Topic.db.findById(session, topicId);

    if (topic == null || topic.ownerUserIdentifier != userId) {
      return null;
    }

    topic.name = name;
    topic.description = description;

    return await Topic.db.updateRow(session, topic);
  }

  // Delete only a topic belonging to the signed-in user.
  Future<bool> deleteTopic(
    Session session,
    int topicId,
  ) async {
    final userId = _currentUserId(session);
    final topic = await Topic.db.findById(session, topicId);

    if (topic == null || topic.ownerUserIdentifier != userId) {
      return false;
    }

    final subtopics = await Subtopic.db.find(
      session,
      where: (t) => t.topicId.equals(topicId),
    );

    // Delete dependent records for each subtopic.
    for (final subtopic in subtopics) {
      final subtopicId = subtopic.id;
      if (subtopicId == null) continue;

      final fields = await Field.db.find(
        session,
        where: (t) => t.subtopicId.equals(subtopicId),
      );

      final logs = await DailyLog.db.find(
        session,
        where: (t) => t.subtopicId.equals(subtopicId),
      );

      // Delete values linked to daily logs.
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

      // Delete any remaining values linked to fields.
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

      for (final field in fields) {
        await Field.db.deleteRow(session, field);
      }

      for (final log in logs) {
        await DailyLog.db.deleteRow(session, log);
      }

      await Subtopic.db.deleteRow(session, subtopic);
    }

    await Topic.db.deleteRow(session, topic);

    return true;
  }
}
