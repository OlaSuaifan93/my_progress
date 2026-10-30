import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class FieldEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  String _currentUserId(Session session) {
    return session.authenticated!.userIdentifier;
  }

  // A field is accessible only through a subtopic owned by this user.
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

  Future<List<Field>> getFields(
    Session session,
    int subtopicId,
  ) async {
    if (!await _ownsSubtopic(session, subtopicId)) {
      return [];
    }

    return await Field.db.find(
      session,
      where: (t) => t.subtopicId.equals(subtopicId),
      orderBy: (t) => t.position,
    );
  }

  Future<Field> createField(
    Session session,
    int subtopicId,
    String name,
    String type,
    int position,
  ) async {
    if (!await _ownsSubtopic(session, subtopicId)) {
      throw Exception('Subtopic not found or access denied.');
    }

    final field = Field(
      subtopicId: subtopicId,
      name: name,
      type: type,
      position: position,
      createdAt: DateTime.now(),
    );

    return await Field.db.insertRow(session, field);
  }

  // Update a field only if its parent belongs to this user.
  Future<Field?> updateField(
    Session session,
    int fieldId,
    String name,
    String type,
  ) async {
    final field = await Field.db.findById(
      session,
      fieldId,
    );

    if (field == null ||
        !await _ownsSubtopic(session, field.subtopicId)) {
      return null;
    }

    field.name = name;
    field.type = type;

    return await Field.db.updateRow(session, field);
  }

  // Delete a field only if its parent belongs to this user.
  Future<bool> deleteField(
    Session session,
    int fieldId,
  ) async {
    final field = await Field.db.findById(
      session,
      fieldId,
    );

    if (field == null ||
        !await _ownsSubtopic(session, field.subtopicId)) {
      return false;
    }

    // Remove saved values linked to this field first.
    final values = await FieldValue.db.find(
      session,
      where: (t) => t.fieldId.equals(fieldId),
    );

    for (final value in values) {
      await FieldValue.db.deleteRow(session, value);
    }

    await Field.db.deleteRow(session, field);
    return true;
  }
}
