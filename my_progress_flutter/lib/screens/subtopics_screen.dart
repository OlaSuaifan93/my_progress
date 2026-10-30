import 'package:flutter/material.dart';
import 'package:my_progress_client/my_progress_client.dart';

import '../main.dart' show client;
import 'fields_screen.dart';

class SubtopicsScreen extends StatefulWidget {
  final int topicId;
  final String topicName;

  const SubtopicsScreen({
    super.key,
    required this.topicId,
    required this.topicName,
  });

  @override
  State<SubtopicsScreen> createState() => _SubtopicsScreenState();
}

class _SubtopicsScreenState extends State<SubtopicsScreen> {
  List<Subtopic> _subtopics = [];
  bool _loading = true;
  bool _saving = false;
  final Set<int> _deletingIds = {};

  @override
  void initState() {
    super.initState();
    _loadSubtopics();
  }

  Future<void> _loadSubtopics() async {
    try {
      final result =
          await client.subtopic.getSubtopics(widget.topicId);

      if (!mounted) return;

      setState(() {
        _subtopics = result;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() => _loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not load subtopics: $e')),
      );
    }
  }

  Future<void> _addSubtopic() async {
    if (_saving) return;

    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    try {
      final result = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Create a subtopic'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Subtopic name',
                  hintText: 'e.g. Python, Exercise, Job Applications',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Create'),
            ),
          ],
        ),
      );

      if (result != true || !mounted) return;

      final name = nameController.text.trim();
      final description = descriptionController.text.trim();

      if (name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter a subtopic name first.'),
          ),
        );
        return;
      }

      if (_subtopics.any(
        (s) => s.name.toLowerCase() == name.toLowerCase(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('That subtopic already exists.'),
          ),
        );
        return;
      }

      setState(() => _saving = true);

      try {
        final subtopic = await client.subtopic.createSubtopic(
          widget.topicId,
          name,
          description.isEmpty ? null : description,
        );

        if (!mounted) return;

        setState(() {
          _subtopics = [..._subtopics, subtopic];
          _saving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Subtopic saved successfully!'),
          ),
        );
      } catch (e) {
        if (!mounted) return;

        setState(() => _saving = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not save subtopic: $e')),
        );
      }
    } finally {
      nameController.dispose();
      descriptionController.dispose();
    }
  }

  Future<void> _editSubtopic(Subtopic subtopic) async {
    final id = subtopic.id;

    if (id == null || _saving) return;

    final nameController = TextEditingController(
      text: subtopic.name,
    );

    final descriptionController = TextEditingController(
      text: subtopic.description ?? '',
    );

    try {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Edit subtopic'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Subtopic name',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pop(dialogContext, true),
              child: const Text('Save changes'),
            ),
          ],
        ),
      );

      if (confirmed != true || !mounted) return;

      final name = nameController.text.trim();
      final description = descriptionController.text.trim();

      if (name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter a subtopic name.'),
          ),
        );
        return;
      }

      if (_subtopics.any(
        (s) =>
            s.id != id &&
            s.name.toLowerCase() == name.toLowerCase(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('That subtopic already exists.'),
          ),
        );
        return;
      }

      setState(() => _saving = true);

      try {
        final updated = await client.subtopic.updateSubtopic(
          id,
          name,
          description.isEmpty ? null : description,
        );

        if (!mounted) return;

        if (updated == null) {
          setState(() => _saving = false);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Subtopic was not found.'),
            ),
          );

          await _loadSubtopics();
          return;
        }

        setState(() {
          _subtopics = _subtopics
              .map((s) => s.id == id ? updated : s)
              .toList();
          _saving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Subtopic updated successfully!'),
          ),
        );
      } catch (e) {
        if (!mounted) return;

        setState(() => _saving = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not update subtopic: $e'),
          ),
        );
      }
    } finally {
      nameController.dispose();
      descriptionController.dispose();
    }
  }

  Future<void> _deleteSubtopic(Subtopic subtopic) async {
    final id = subtopic.id;

    if (id == null || _deletingIds.contains(id)) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete subtopic?'),
        content: Text(
          'Delete "${subtopic.name}" and all its custom fields '
          'and daily logs? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () =>
                Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _deletingIds.add(id));

    try {
      final deleted =
          await client.subtopic.deleteSubtopic(id);

      if (!mounted) return;

      if (deleted) {
        setState(() {
          _subtopics.removeWhere(
            (item) => item.id == id,
          );
          _deletingIds.remove(id);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Subtopic deleted successfully.'),
          ),
        );
      } else {
        setState(() => _deletingIds.remove(id));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Subtopic was not found.'),
          ),
        );

        await _loadSubtopics();
      }
    } catch (e) {
      if (!mounted) return;

      setState(() => _deletingIds.remove(id));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not delete subtopic: $e'),
        ),
      );
    }
  }

  void _openSubtopic(Subtopic subtopic) {
    final id = subtopic.id;

    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This subtopic has no saved ID.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => FieldsScreen(
          subtopicId: id,
          subtopicName: subtopic.name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      appBar: AppBar(
        title: Text(widget.topicName),
        backgroundColor: const Color(0xFFF7F7FB),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                widget.topicName,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create subtopics to organize this area of your life.',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your subtopics',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed:
                        _saving ? null : _addSubtopic,
                    icon: const Icon(Icons.add),
                    label: Text(
                      _saving
                          ? 'Saving...'
                          : 'Add subtopic',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_loading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_subtopics.isEmpty)
                Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.layers_outlined,
                          size: 40,
                          color: Color(0xFF6558D3),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'No subtopics yet',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Add your first subtopic to get started.',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ..._subtopics.map((subtopic) {
                  final id = subtopic.id;

                  final deleting = id != null &&
                      _deletingIds.contains(id);

                  return Card(
                    color: Colors.white,
                    elevation: 0,
                    margin:
                        const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor:
                            Color(0xFFEEECFF),
                        child: Icon(
                          Icons.layers_outlined,
                          color: Color(0xFF6558D3),
                        ),
                      ),
                      title: Text(
                        subtopic.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        subtopic.description?.isNotEmpty ==
                                true
                            ? subtopic.description!
                            : 'Created ${subtopic.createdAt.toLocal().toString().split(' ').first}',
                      ),
                      onTap: deleting
                          ? null
                          : () => _openSubtopic(
                                subtopic,
                              ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Edit subtopic',
                            onPressed:
                                deleting || _saving
                                    ? null
                                    : () =>
                                        _editSubtopic(
                                          subtopic,
                                        ),
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Color(0xFF6558D3),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Delete subtopic',
                            onPressed: deleting
                                ? null
                                : () =>
                                    _deleteSubtopic(
                                      subtopic,
                                    ),
                            icon: deleting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child:
                                        CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                  ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}