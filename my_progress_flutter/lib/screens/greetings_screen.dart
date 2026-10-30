
import 'package:flutter/material.dart';
import 'package:my_progress_client/my_progress_client.dart';

import '../main.dart' show client;
import 'subtopics_screen.dart';
import 'daily_log_form.dart';
import 'reports_screen.dart';

class GreetingsScreen extends StatefulWidget {
  final Future<void> Function()? onSignOut;

  const GreetingsScreen({super.key, this.onSignOut});

  @override
  State<GreetingsScreen> createState() => _GreetingsScreenState();
}

class _GreetingsScreenState extends State<GreetingsScreen> {
  List<Topic> _topics = [];
  List<_TodayActivity> _todayActivities = [];

  bool _loading = true;
  bool _loadingToday = true;
  bool _saving = false;

  final Set<int> _deletingIds = {};

  @override
  void initState() {
    super.initState();
    _loadTopics();
  }

  bool _isSameDay(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  Future<void> _loadTopics() async {
    try {
      final topics = await client.topic.getTopics();

      if (!mounted) return;

      setState(() {
        _topics = topics;
        _loading = false;
      });

      await _loadTodayActivities();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _loadingToday = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not load topics: $e')),
      );
    }
  }

  Future<void> _loadTodayActivities() async {
    if (!mounted) return;

    setState(() => _loadingToday = true);

    try {
      final now = DateTime.now();
      final activitiesBySubtopic = <int, _TodayActivity>{};

      for (final topic in _topics) {
        final topicId = topic.id;
        if (topicId == null) continue;

        final subtopics =
            await client.subtopic.getSubtopics(topicId);

        for (final subtopic in subtopics) {
          final subtopicId = subtopic.id;
          if (subtopicId == null) continue;

          final logs =
              await client.dailyLog.getDailyLogs(subtopicId);

          for (final log in logs) {
            final localDate = log.date.toLocal();

            if (!_isSameDay(localDate, now)) continue;

            final existing = activitiesBySubtopic[subtopicId];

            if (existing == null ||
                localDate.isAfter(existing.loggedAt)) {
              activitiesBySubtopic[subtopicId] = _TodayActivity(
                topicId: topicId,
                topicName: topic.name,
                subtopicId: subtopicId,
                subtopicName: subtopic.name,
                loggedAt: localDate,
              );
            }
          }
        }
      }

      final activities = activitiesBySubtopic.values.toList()
        ..sort(
          (a, b) => b.loggedAt.compareTo(a.loggedAt),
        );

      if (!mounted) return;

      setState(() {
        _todayActivities = activities;
        _loadingToday = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() => _loadingToday = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not load today\'s progress: $e'),
        ),
      );
    }
  }

  Future<void> _addTopic() async {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    try {
      final result = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Create a topic'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Topic name',
                  hintText: 'e.g. Health, Career, Learning',
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
            content: Text('Enter a topic name first.'),
          ),
        );
        return;
      }

      if (_topics.any(
        (topic) => topic.name.toLowerCase() == name.toLowerCase(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('That topic already exists.'),
          ),
        );
        return;
      }

      setState(() => _saving = true);

      try {
        final topic = await client.topic.createTopic(
          name,
          description.isEmpty ? null : description,
        );

        if (!mounted) return;

        setState(() {
          _topics = [..._topics, topic];
          _saving = false;
        });

        await _loadTodayActivities();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Topic saved successfully!'),
          ),
        );
      } catch (e) {
        if (!mounted) return;

        setState(() => _saving = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not save topic: $e')),
        );
      }
    } finally {
      nameController.dispose();
      descriptionController.dispose();
    }
  }

  Future<void> _deleteTopic(Topic topic) async {
    final topicId = topic.id;

    if (topicId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This topic has no saved ID.'),
        ),
      );
      return;
    }

    if (_deletingIds.contains(topicId)) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete topic?'),
        content: Text(
          'Are you sure you want to delete "${topic.name}"?\n\n'
          'Its subtopics, custom fields, and daily logs will also be '
          'deleted. This action cannot be undone.',
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

    setState(() => _deletingIds.add(topicId));

    try {
      final deleted = await client.topic.deleteTopic(topicId);

      if (!mounted) return;

      if (deleted) {
        setState(() {
          _topics.removeWhere((item) => item.id == topicId);
          _deletingIds.remove(topicId);
        });

        await _loadTodayActivities();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${topic.name}" was deleted.'),
          ),
        );
      } else {
        setState(() => _deletingIds.remove(topicId));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Topic was not found. Reloading topics.'),
          ),
        );

        await _loadTopics();
      }
    } catch (e) {
      if (!mounted) return;

      setState(() => _deletingIds.remove(topicId));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not delete topic: $e')),
      );
    }
  }

    Future<void> _editTopic(Topic topic) async {
    final topicId = topic.id;

    if (topicId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This topic has no saved ID.'),
        ),
      );
      return;
    }

    final nameController = TextEditingController(text: topic.name);
    final descriptionController = TextEditingController(
      text: topic.description ?? '',
    );

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        bool saving = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Topic'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Topic name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: saving
                      ? null
                      : () => Navigator.pop(dialogContext, false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: saving
                      ? null
                      : () async {
                          final name = nameController.text.trim();
                          final description =
                              descriptionController.text.trim();

                          if (name.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Enter a topic name first.',
                                ),
                              ),
                            );
                            return;
                          }

                          setDialogState(() => saving = true);

                          try {
                            final updated =
                                await client.topic.updateTopic(
                              topicId,
                              name,
                              description.isEmpty ? null : description,
                            );

                            if (!mounted) return;

                            if (updated != null) {
                              setState(() {
                                final index = _topics.indexWhere(
                                  (item) => item.id == topicId,
                                );

                                if (index != -1) {
                                  _topics[index] = updated;
                                }
                              });

                              Navigator.pop(dialogContext, true);

                              await _loadTodayActivities();

                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Topic updated successfully!',
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            setDialogState(() => saving = false);

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Could not update topic: $e',
                                ),
                              ),
                            );
                          }
                        },
                  child: saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    nameController.dispose();
    descriptionController.dispose();

    if (result == true && mounted) {
      setState(() {});
    }
  }

  void _openTopic(Topic topic) {
    final topicId = topic.id;

    if (topicId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This topic has no saved ID.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => SubtopicsScreen(
          topicId: topicId,
          topicName: topic.name,
        ),
      ),
    );
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  Widget _buildTodayProgress() {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE7E7EF)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.today,
                  color: Color(0xFF6558D3),
                  size: 26,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Today\'s Progress',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Refresh today\'s progress',
                  onPressed:
                      _loadingToday ? null : _loadTodayActivities,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${_todayActivities.length} '
              '${_todayActivities.length == 1 ? 'subtopic' : 'subtopics'} '
              'logged today',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 14),
            if (_loadingToday)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (_todayActivities.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7FB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.flag_outlined,
                      size: 32,
                      color: Color(0xFF6558D3),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your day is a fresh start.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Save a daily log and your completed '
                      'subtopics will appear here.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              for (final activity in _todayActivities)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7FB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFEEECFF),
                        child: Icon(
                          Icons.check_circle_outline,
                          color: Color(0xFF6558D3),
                        ),
                      ),
                      title: Text(
                        activity.subtopicName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        '${activity.topicName} · '
                        '${_formatTime(activity.loggedAt)}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        final topic = _topics.where(
                          (item) => item.id == activity.topicId,
                        );

                        if (topic.isNotEmpty) {
                          _openTopic(topic.first);
                        }
                      },
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicCard(Topic topic) {
    final topicId = topic.id;
    final isDeleting =
        topicId != null && _deletingIds.contains(topicId);

    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE7E7EF)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: InkWell(
              onTap: isDeleting ? null : () => _openTopic(topic),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.track_changes,
                      color: Color(0xFF6558D3),
                      size: 28,
                    ),
                    const Spacer(),
                    Text(
                      topic.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.description?.isNotEmpty == true
                          ? topic.description!
                          : 'Created ${topic.createdAt.toLocal().toString().split(' ').first}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
          top: 4,
          right: 4,
          child: isDeleting
            ? const Padding(
                padding: EdgeInsets.all(12),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Edit topic',
                    onPressed: () => _editTopic(topic),
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Color(0xFF6558D3),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Delete topic',
                    onPressed: () => _deleteTopic(topic),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
      ),
        ],
      ),

    );
  }

  Widget _buildAddTopicCard() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: const Color(0xFFEEECFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFDCD7FF)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _saving ? null : _addTopic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_circle_outline,
              size: 34,
              color: Color(0xFF6558D3),
            ),
            const SizedBox(height: 10),
            Text(
              _saving ? 'Saving...' : 'Add a topic',
              style: const TextStyle(
                color: Color(0xFF5144B6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final date =
        '${months[today.month - 1]} ${today.day}, ${today.year}';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      appBar: AppBar(
        title: const Text(
          'My Progress',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF7F7FB),
        actions: [
          if (widget.onSignOut != null)
            TextButton.icon(
              onPressed: widget.onSignOut,
              icon: const Icon(Icons.logout),
              label: const Text('Sign out'),
            ),
          const SizedBox(width: 12),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 950),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                'A little progress adds up.',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Your personal space to reflect, plan, and keep moving.',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your topics',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_loading)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns =
                        constraints.maxWidth > 650 ? 3 : 1;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      itemCount: _topics.length + 1,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        mainAxisExtent: 170,
                      ),
                      itemBuilder: (context, index) {
                        if (index == _topics.length) {
                          return _buildAddTopicCard();
                        }

                        return _buildTopicCard(_topics[index]);
                      },
                    );
                  },
                ),
              const SizedBox(height: 28),

              // New daily progress section.
              _buildTodayProgress(),

              const SizedBox(height: 32),

              DailyLogForm(
                onLogSaved: () {
                  _loadTodayActivities();
                },
              ),

              const SizedBox(height: 32),
              SizedBox(
                height: 1000,
                child: const ReportsScreen(),
              ),
              const SizedBox(height: 32),
              const Text(
                'Your next step',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Start by creating a topic. Next, you can add subtopics '
                'and custom fields to track what matters to you.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodayActivity {
  final int topicId;
  final String topicName;
  final int subtopicId;
  final String subtopicName;
  final DateTime loggedAt;

  const _TodayActivity({
    required this.topicId,
    required this.topicName,
    required this.subtopicId,
    required this.subtopicName,
    required this.loggedAt,
  });
}
