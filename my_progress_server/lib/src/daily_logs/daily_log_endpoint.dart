import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class DailyLogEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  String _currentUserId(Session session) {
    return session.authenticated!.userIdentifier;
  }

  // Confirm that the subtopic belongs to the signed-in user.
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

  Future<DailyLog> createDailyLog(
    Session session,
    int subtopicId,
    DateTime date,
  ) async {
    if (!await _ownsSubtopic(session, subtopicId)) {
      throw Exception('Subtopic not found or access denied.');
    }

    final log = DailyLog(
      subtopicId: subtopicId,
      date: date,
      createdAt: DateTime.now(),
    );

    return await DailyLog.db.insertRow(session, log);
  }

  Future<List<DailyLog>> getDailyLogs(
    Session session,
    int subtopicId,
  ) async {
    if (!await _ownsSubtopic(session, subtopicId)) {
      return [];
    }

    return await DailyLog.db.find(
      session,
      where: (t) => t.subtopicId.equals(subtopicId),
      orderBy: (t) => t.date,
      orderDescending: true,
    );
  }
}
