import 'package:flutter/material.dart';
import 'package:my_progress_client/my_progress_client.dart';

import '../main.dart' show client;

class DailyLogForm extends StatefulWidget {
  final VoidCallback? onLogSaved;

  const DailyLogForm({
    super.key,
    this.onLogSaved,
  });

  @override
  State<DailyLogForm> createState() => _DailyLogFormState();
}

class _DailyLogFormState extends State<DailyLogForm> {
  List<Topic> _topics = [];
  List<Subtopic> _subtopics = [];
  List<Field> _fields = [];

  DateTime _selectedDateTime = DateTime.now();

  int? _topicId;
  int? _subtopicId;

  final Map<int, TextEditingController> _textControllers = {};
  final Map<int, String> _choiceValues = {};

  bool _loadingTopics = true;
  bool _loadingSubtopics = false;
  bool _loadingFields = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadTopics();
  }

  @override
  void dispose() {
    for (final controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  Future<void> _chooseDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Choose log date',
    );

    if (selectedDate == null || !mounted) return;

    setState(() {
      _selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        _selectedDateTime.hour,
        _selectedDateTime.minute,
      );
    });
  }

  Future<void> _chooseTime() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      helpText: 'Choose log time',
    );

    if (selectedTime == null || !mounted) return;

    setState(() {
      _selectedDateTime = DateTime(
        _selectedDateTime.year,
        _selectedDateTime.month,
        _selectedDateTime.day,
        selectedTime.hour,
        selectedTime.minute,
      );
    });
  }

  void _clearFieldInputs() {
    for (final controller in _textControllers.values) {
      controller.dispose();
    }

    _textControllers.clear();
    _choiceValues.clear();
    _fields = [];
  }

  Future<void> _loadTopics() async {
    try {
      final topics = await client.topic.getTopics();

      if (!mounted) return;

      setState(() {
        _topics = topics;
        _loadingTopics = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loadingTopics = false;
      });

      _showMessage('Could not load topics: $e');
    }
  }

  Future<void> _onTopicChanged(int? topicId) async {
    setState(() {
      _topicId = topicId;
      _subtopicId = null;
      _subtopics = [];
      _clearFieldInputs();
      _loadingSubtopics = topicId != null;
    });

    if (topicId == null) return;

    try {
      final subtopics = await client.subtopic.getSubtopics(topicId);

      if (!mounted) return;

      setState(() {
        _subtopics = subtopics;
        _loadingSubtopics = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loadingSubtopics = false;
      });

      _showMessage('Could not load subtopics: $e');
    }
  }

  Future<void> _onSubtopicChanged(int? subtopicId) async {
    setState(() {
      _subtopicId = subtopicId;
      _clearFieldInputs();
      _loadingFields = subtopicId != null;
    });

    if (subtopicId == null) return;

    try {
      final fields = await client.field.getFields(subtopicId);

      if (!mounted) return;

      setState(() {
        _fields = fields;

        for (final field in fields) {
          final id = field.id;
          if (id == null) continue;

          if (field.type == 'text' || field.type == 'number') {
            _textControllers[id] = TextEditingController();
          } else {
            _choiceValues[id] = '';
          }
        }

        _loadingFields = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loadingFields = false;
      });

      _showMessage('Could not load custom fields: $e');
    }
  }

  Future<void> _saveLog() async {
    if (_saving) return;

    if (_subtopicId == null) {
      _showMessage('Choose a topic and subtopic first.');
      return;
    }

    if (_fields.isEmpty) {
      _showMessage(
        'This subtopic has no custom fields. Add at least one field first.',
      );
      return;
    }

    final answers = <MapEntry<int, String>>[];

    for (final field in _fields) {
      final fieldId = field.id;
      if (fieldId == null) continue;

      String value;

      if (field.type == 'text' || field.type == 'number') {
        value = _textControllers[fieldId]?.text.trim() ?? '';
      } else {
        value = _choiceValues[fieldId] ?? '';
      }

      if (field.type == 'number' &&
          value.isNotEmpty &&
          num.tryParse(value) == null) {
        _showMessage('"${field.name}" must contain a valid number.');
        return;
      }

      if (value.isNotEmpty) {
        answers.add(MapEntry(fieldId, value));
      }
    }

    if (answers.isEmpty) {
      _showMessage('Enter at least one answer before saving.');
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      // Save the selected date and time.
      final log = await client.dailyLog.createDailyLog(
        _subtopicId!,
        _selectedDateTime,
      );

      final logId = log.id;

      if (logId == null) {
        throw Exception('The server did not return a log ID.');
      }

      // Save each field's value against the new log.
      for (final answer in answers) {
        await client.fieldValue.saveFieldValue(
          logId,
          answer.key,
          answer.value,
        );
      }

      if (!mounted) return;

      setState(() {
        for (final controller in _textControllers.values) {
          controller.clear();
        }

        for (final id in _choiceValues.keys.toList()) {
          _choiceValues[id] = '';
        }

        _saving = false;
      });

      _showMessage(
        'Log saved for ${_formatDate(_selectedDateTime)} '
        'at ${_formatTime(_selectedDateTime)}.',
      );

      // Notify the main page so Today's Progress can refresh.
      widget.onLogSaved?.call();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _saving = false;
      });

      _showMessage('Could not save the daily log: $e');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildFieldInput(Field field) {
    final id = field.id;

    if (id == null) {
      return const SizedBox.shrink();
    }

    if (field.type == 'text') {
      return TextFormField(
        controller: _textControllers[id],
        decoration: InputDecoration(
          labelText: field.name,
          border: const OutlineInputBorder(),
        ),
        maxLines: 2,
      );
    }

    if (field.type == 'number') {
      return TextFormField(
        controller: _textControllers[id],
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
          signed: true,
        ),
        decoration: InputDecoration(
          labelText: field.name,
          border: const OutlineInputBorder(),
        ),
      );
    }

    if (field.type == 'boolean') {
      return DropdownButtonFormField<String>(
        value: _choiceValues[id] ?? '',
        isExpanded: true,
        decoration: InputDecoration(
          labelText: field.name,
          border: const OutlineInputBorder(),
        ),
        items: const [
          DropdownMenuItem(
            value: '',
            child: Text('Not set'),
          ),
          DropdownMenuItem(
            value: 'Yes',
            child: Text('Yes'),
          ),
          DropdownMenuItem(
            value: 'No',
            child: Text('No'),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _choiceValues[id] = value ?? '';
          });
        },
      );
    }

    if (field.type == 'rating') {
      return DropdownButtonFormField<String>(
        value: _choiceValues[id] ?? '',
        isExpanded: true,
        decoration: InputDecoration(
          labelText: field.name,
          border: const OutlineInputBorder(),
        ),
        items: const [
          DropdownMenuItem(
            value: '',
            child: Text('Not rated'),
          ),
          DropdownMenuItem(
            value: '1',
            child: Text('1 - Very low'),
          ),
          DropdownMenuItem(
            value: '2',
            child: Text('2 - Low'),
          ),
          DropdownMenuItem(
            value: '3',
            child: Text('3 - Average'),
          ),
          DropdownMenuItem(
            value: '4',
            child: Text('4 - Good'),
          ),
          DropdownMenuItem(
            value: '5',
            child: Text('5 - Excellent'),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _choiceValues[id] = value ?? '';
          });
        },
      );
    }

    // Fallback for any other field type.
    final controller = _textControllers.putIfAbsent(
      id,
      () => TextEditingController(),
    );

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: field.name,
        border: const OutlineInputBorder(),
      ),
      maxLines: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE7E7EF)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.edit_calendar,
                  color: Color(0xFF6558D3),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Daily Log',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Choose when this progress entry happened.',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),

            // Select the date and time of the entry.
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _saving ? null : _chooseDate,
                    icon: const Icon(Icons.calendar_month),
                    label: Text(_formatDate(_selectedDateTime)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _saving ? null : _chooseTime,
                    icon: const Icon(Icons.access_time),
                    label: Text(_formatTime(_selectedDateTime)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (_loadingTopics)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (_topics.isEmpty)
              const Text(
                'Create a topic before recording a daily log.',
              )
            else
              DropdownButtonFormField<int>(
                value: _topicId,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Choose topic',
                  border: OutlineInputBorder(),
                ),
                items: _topics
                    .where((topic) => topic.id != null)
                    .map(
                      (topic) => DropdownMenuItem<int>(
                        value: topic.id!,
                        child: Text(topic.name),
                      ),
                    )
                    .toList(),
                onChanged: _saving ? null : _onTopicChanged,
              ),

            const SizedBox(height: 16),

            if (_loadingSubtopics)
              const LinearProgressIndicator()
            else if (_topicId != null && _subtopics.isEmpty)
              const Text(
                'No subtopics yet. Open this topic to add one.',
              )
            else if (_subtopics.isNotEmpty)
              DropdownButtonFormField<int>(
                value: _subtopicId,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Choose subtopic',
                  border: OutlineInputBorder(),
                ),
                items: _subtopics
                    .where((subtopic) => subtopic.id != null)
                    .map(
                      (subtopic) => DropdownMenuItem<int>(
                        value: subtopic.id!,
                        child: Text(subtopic.name),
                      ),
                    )
                    .toList(),
                onChanged: _saving ? null : _onSubtopicChanged,
              ),

            if (_loadingFields) ...[
              const SizedBox(height: 20),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ] else if (_subtopicId != null && _fields.isEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'This subtopic has no custom fields yet. '
                'Open it and add fields first.',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ] else if (_fields.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Your entries',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 12),

              for (final field in _fields) ...[
                _buildFieldInput(field),
                const SizedBox(height: 14),
              ],

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saving ? null : _saveLog,
                  icon: _saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.save_outlined),
                  label: Text(
                    _saving ? 'Saving...' : 'Save daily log',
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}