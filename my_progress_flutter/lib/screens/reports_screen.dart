import 'package:flutter/material.dart';
import 'package:my_progress_client/my_progress_client.dart';
import '../main.dart' show client;
import 'dart:math' as math;

enum ReportPeriod {
  days7,
  days30,
  days90,
  allTime,
  custom,
}

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List<Topic> _topics = [];
  List<Subtopic> _subtopics = [];
  List<Field> _fields = [];
  List<DailyLog> _logs = [];

  final Map<int, List<FieldValue>> _valuesByLog = {};

  int? _topicId;
  int? _subtopicId;

  ReportPeriod _period = ReportPeriod.days30;

  DateTime? _customStart;
  DateTime? _customEnd;

  int? _graphFieldId;
  int? _secondGraphFieldId;

  bool _showBarChart = false;

  bool _loadingTopics = true;
  bool _loadingReport = false;

  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTopics();
  }

  Future<void> _loadTopics() async {
    setState(() {
      _loadingTopics = true;
      _error = null;
    });

    try {
      final topics = await client.topic.getTopics();

      if (!mounted) return;

      setState(() {
        _topics = topics;
        _loadingTopics = false;
      });

      if (topics.isNotEmpty) {
        await _selectTopic(topics.first.id!);
      } else {
        setState(() {
          _subtopics = [];
          _fields = [];
          _logs = [];
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loadingTopics = false;
        _error = 'Could not load topics: $e';
      });
    }
  }

  Future<void> _selectTopic(int topicId) async {
    setState(() {
      _topicId = topicId;
      _subtopics = [];
      _subtopicId = null;
      _fields = [];
      _logs = [];
      _valuesByLog.clear();
    });

    try {
      final subtopics = await client.subtopic.getSubtopics(topicId);

      if (!mounted) return;

      setState(() {
        _subtopics = subtopics;
      });

      if (subtopics.isNotEmpty) {
        await _selectSubtopic(subtopics.first.id!);
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = 'Could not load subtopics: $e';
      });
    }
  }

  Future<void> _selectSubtopic(int subtopicId) async {
    setState(() {
      _subtopicId = subtopicId;
      _fields = [];
      _logs = [];
      _valuesByLog.clear();
      _loadingReport = true;
      _error = null;
    });

    await _loadReport();
  }

  Future<void> _loadReport() async {
    if (_subtopicId == null) return;

    try {
      final results = await Future.wait([
        client.field.getFields(_subtopicId!),
        client.dailyLog.getDailyLogs(_subtopicId!),
      ]);

      final fields = results[0] as List<Field>;
      final logs = results[1] as List<DailyLog>;

      final valuesByLog = <int, List<FieldValue>>{};

      for (final log in logs) {
        final logId = log.id;

        if (logId == null) continue;

        final values = await client.fieldValue.getFieldValues(logId);

        valuesByLog[logId] = values;
      }

      if (!mounted) return;

      final numericFields = fields.where((field) {
        final type = field.type.toLowerCase();
        return type == 'number' || type == 'rating';
      }).toList();

      setState(() {
        _fields = fields;
        _logs = logs;
        _valuesByLog
          ..clear()
          ..addAll(valuesByLog);

        _loadingReport = false;

        if (!numericFields.any((f) => f.id == _graphFieldId)) {
          _graphFieldId = numericFields.isNotEmpty
              ? numericFields.first.id
              : null;
        }

        if (!numericFields.any((f) => f.id == _secondGraphFieldId) ||
            _secondGraphFieldId == _graphFieldId) {
          _secondGraphFieldId = numericFields.length > 1
              ? numericFields[1].id
              : null;
        }
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loadingReport = false;
        _error = 'Could not load report: $e';
      });
    }
  }

  DateTime _startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  List<DailyLog> get _filteredLogs {
    if (_logs.isEmpty) return [];

    final now = DateTime.now();

    DateTime? start;
    DateTime? end;

    switch (_period) {
      case ReportPeriod.days7:
        start = _startOfDay(now.subtract(const Duration(days: 6)));
        end = _startOfDay(now.add(const Duration(days: 1)));
        break;

      case ReportPeriod.days30:
        start = _startOfDay(now.subtract(const Duration(days: 29)));
        end = _startOfDay(now.add(const Duration(days: 1)));
        break;

      case ReportPeriod.days90:
        start = _startOfDay(now.subtract(const Duration(days: 89)));
        end = _startOfDay(now.add(const Duration(days: 1)));
        break;

      case ReportPeriod.allTime:
        start = null;
        end = null;
        break;

      case ReportPeriod.custom:
        if (_customStart != null) {
          start = _startOfDay(_customStart!);
        }

        if (_customEnd != null) {
          end = _startOfDay(_customEnd!.add(const Duration(days: 1)));
        }
        break;
    }

    final filtered = _logs.where((log) {
      if (start != null && log.date.isBefore(start)) {
        return false;
      }

      if (end != null && !log.date.isBefore(end)) {
        return false;
      }

      return true;
    }).toList();

    filtered.sort((a, b) => b.date.compareTo(a.date));

    return filtered;
  }

  String get _periodLabel {
    switch (_period) {
      case ReportPeriod.days7:
        return 'Last 7 days';

      case ReportPeriod.days30:
        return 'Last 30 days';

      case ReportPeriod.days90:
        return 'Last 90 days';

      case ReportPeriod.allTime:
        return 'All time';

      case ReportPeriod.custom:
        if (_customStart != null && _customEnd != null) {
          return '${_formatDate(_customStart!)} → ${_formatDate(_customEnd!)}';
        }

        return 'Custom range';
    }
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '${date.year}-$month-$day';
  }

  String _formatDateTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;

    final minute = date.minute.toString().padLeft(2, '0');

    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '${_formatDate(date)} • $hour:$minute $period';
  }

  Future<void> _chooseCustomRange() async {
    final now = DateTime.now();

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 5),
      initialDateRange: _customStart != null && _customEnd != null
          ? DateTimeRange(
              start: _customStart!,
              end: _customEnd!,
            )
          : DateTimeRange(
              start: now.subtract(const Duration(days: 29)),
              end: now,
            ),
    );

    if (picked == null) return;

    setState(() {
      _customStart = picked.start;
      _customEnd = picked.end;
      _period = ReportPeriod.custom;
    });
  }

  List<Field> get _numericFields {
    return _fields.where((field) {
      final type = field.type.toLowerCase();

      return type == 'number' || type == 'rating';
    }).toList();
  }

  double? _getNumericValue(
    DailyLog log,
    int fieldId,
  ) {
    final logId = log.id;

    if (logId == null) return null;

    final values = _valuesByLog[logId] ?? [];

    for (final value in values) {
      if (value.fieldId == fieldId) {
        return double.tryParse(value.value.trim());
      }
    }

    return null;
  }

  String _fieldValueLabel(
    FieldValue value,
  ) {
    for (final field in _fields) {
      if (field.id == value.fieldId) {
        return field.name;
      }
    }

    return 'Field';
  }

  List<_GraphPoint> _makeGraphPoints(
    List<DailyLog> logs,
  ) {
    final orderedLogs = logs.reversed.toList();

    return orderedLogs.map((log) {
      return _GraphPoint(
        date: log.date,
        first: _graphFieldId == null
            ? null
            : _getNumericValue(
                log,
                _graphFieldId!,
              ),
        second: _secondGraphFieldId == null
            ? null
            : _getNumericValue(
                log,
                _secondGraphFieldId!,
              ),
      );
    }).toList();
  }

  Widget _buildGraph(
    List<DailyLog> logs,
    ThemeData theme,
  ) {
    final numericFields = _numericFields;

    if (numericFields.isEmpty) {
      return Card(
        margin: const EdgeInsets.only(top: 16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progress Graph',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'Add a Number or Rating field to this subtopic to create a graph.',
              ),
            ],
          ),
        ),
      );
    }

    final firstId =
        numericFields.any(
          (field) => field.id == _graphFieldId,
        )
        ? _graphFieldId
        : numericFields.first.id;

    final secondOptions = numericFields
        .where((field) => field.id != firstId)
        .toList();

    final secondId =
        secondOptions.any(
          (field) => field.id == _secondGraphFieldId,
        )
        ? _secondGraphFieldId
        : null;

    final points = _makeGraphPoints(logs);

    final hasValues = points.any(
      (point) => point.first != null || point.second != null,
    );

    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress Graph',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              'Plot your saved numeric values against time.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<int>(
              value: firstId,
              decoration: const InputDecoration(
                labelText: 'First field',
                border: OutlineInputBorder(),
              ),
              items: numericFields.map((field) {
                return DropdownMenuItem<int>(
                  value: field.id,
                  child: Text(field.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _graphFieldId = value;

                  if (_secondGraphFieldId == value) {
                    _secondGraphFieldId = null;
                  }
                });
              },
            ),

            if (secondOptions.isNotEmpty) ...[
              const SizedBox(height: 12),

              DropdownButtonFormField<int?>(
                value: secondId,
                decoration: const InputDecoration(
                  labelText: 'Compare with another field',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem<int?>(
                    value: null,
                    child: Text('None'),
                  ),
                  ...secondOptions.map((field) {
                    return DropdownMenuItem<int?>(
                      value: field.id,
                      child: Text(field.name),
                    );
                  }),
                ],
                onChanged: (value) {
                  setState(() {
                    _secondGraphFieldId = value;
                  });
                },
              ),
            ],

            const SizedBox(height: 12),

            SegmentedButton<bool>(
              segments: const [
                ButtonSegment<bool>(
                  value: false,
                  label: Text('Line'),
                  icon: Icon(Icons.show_chart),
                ),
                ButtonSegment<bool>(
                  value: true,
                  label: Text('Bar'),
                  icon: Icon(Icons.bar_chart),
                ),
              ],
              selected: {_showBarChart},
              onSelectionChanged: (selection) {
                setState(() {
                  _showBarChart = selection.first;
                });
              },
            ),

            const SizedBox(height: 16),

            if (!hasValues)
              const SizedBox(
                height: 180,
                child: Center(
                  child: Text(
                    'No numeric values have been saved for this period.',
                  ),
                ),
              )
            else
              SizedBox(
                height: 280,
                width: double.infinity,
                child: CustomPaint(
                  painter: _ProgressGraphPainter(
                    points: points,
                    showBars: _showBarChart,
                    firstName: numericFields
                        .firstWhere(
                          (field) => field.id == firstId,
                        )
                        .name,
                    secondName: secondId == null
                        ? null
                        : numericFields
                              .firstWhere(
                                (field) => field.id == secondId,
                              )
                              .name,
                    textColor: theme.colorScheme.onSurface,
                    gridColor: theme.colorScheme.outlineVariant,
                    firstColor: theme.colorScheme.primary,
                    secondColor: theme.colorScheme.secondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistory(
    List<DailyLog> logs,
    ThemeData theme,
  ) {
    if (logs.isEmpty) {
      return Card(
        margin: const EdgeInsets.only(top: 16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              'No saved entries for $_periodLabel.',
            ),
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'History',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              '${logs.length} saved entr${logs.length == 1 ? 'y' : 'ies'}',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 16),

            ...List.generate(
              logs.length,
              (index) {
                final log = logs[index];
                final logId = log.id;

                final values = logId == null
                    ? <FieldValue>[]
                    : _valuesByLog[logId] ?? [];

                return _buildHistoryEntry(
                  log,
                  values,
                  index,
                  logs.length,
                  theme,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryEntry(
    DailyLog log,
    List<FieldValue> values,
    int index,
    int total,
    ThemeData theme,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primary,
                  ),
                ),
                if (index < total - 1)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: theme.colorScheme.outlineVariant,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              color: theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            _formatDateTime(log.date),
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),

                    if (values.isEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        'No field values saved.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ] else ...[
                      const SizedBox(height: 10),

                      ...values.map(
                        (value) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    _fieldValueLabel(value),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Text(
                                    value.value,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector(
    ThemeData theme,
  ) {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time Period',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('7 days'),
                  selected: _period == ReportPeriod.days7,
                  onSelected: (_) {
                    setState(() {
                      _period = ReportPeriod.days7;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('30 days'),
                  selected: _period == ReportPeriod.days30,
                  onSelected: (_) {
                    setState(() {
                      _period = ReportPeriod.days30;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('90 days'),
                  selected: _period == ReportPeriod.days90,
                  onSelected: (_) {
                    setState(() {
                      _period = ReportPeriod.days90;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('All time'),
                  selected: _period == ReportPeriod.allTime,
                  onSelected: (_) {
                    setState(() {
                      _period = ReportPeriod.allTime;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Custom'),
                  selected: _period == ReportPeriod.custom,
                  onSelected: (_) {
                    _chooseCustomRange();
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Icon(
                  Icons.date_range,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _periodLabel,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                if (_period == ReportPeriod.custom)
                  TextButton(
                    onPressed: _chooseCustomRange,
                    child: const Text('Change'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final logs = _filteredLogs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & History'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadingReport ? null : _loadReport,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _loadingTopics
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _error != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _loadTopics,
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
            )
          : _topics.isEmpty
          ? const Center(
              child: Text(
                'Create a topic first.',
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadReport,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  DropdownButtonFormField<int>(
                    value: _topicId,
                    decoration: const InputDecoration(
                      labelText: 'Topic',
                      border: OutlineInputBorder(),
                    ),
                    items: _topics.map((topic) {
                      return DropdownMenuItem<int>(
                        value: topic.id,
                        child: Text(topic.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _selectTopic(value);
                      }
                    },
                  ),

                  const SizedBox(height: 12),

                  if (_subtopics.isEmpty)
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'This topic does not have any subtopics yet.',
                        ),
                      ),
                    )
                  else
                    DropdownButtonFormField<int>(
                      value: _subtopicId,
                      decoration: const InputDecoration(
                        labelText: 'Subtopic',
                        border: OutlineInputBorder(),
                      ),
                      items: _subtopics.map((subtopic) {
                        return DropdownMenuItem<int>(
                          value: subtopic.id,
                          child: Text(subtopic.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          _selectSubtopic(value);
                        }
                      },
                    ),

                  if (_subtopicId != null) ...[
                    _buildPeriodSelector(theme),

                    if (_loadingReport)
                      const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else ...[
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: theme.colorScheme.primaryContainer,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.analytics_outlined,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${logs.length} entries in $_periodLabel',
                                style: TextStyle(
                                  color: theme.colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      _buildGraph(
                        logs,
                        theme,
                      ),

                      _buildHistory(
                        logs,
                        theme,
                      ),

                      const SizedBox(height: 30),
                    ],
                  ],
                ],
              ),
            ),
    );
  }
}

class _GraphPoint {
  final DateTime date;
  final double? first;
  final double? second;

  const _GraphPoint({
    required this.date,
    required this.first,
    required this.second,
  });
}

class _ProgressGraphPainter extends CustomPainter {
  final List<_GraphPoint> points;
  final bool showBars;
  final String firstName;
  final String? secondName;
  final Color textColor;
  final Color gridColor;
  final Color firstColor;
  final Color secondColor;

  _ProgressGraphPainter({
    required this.points,
    required this.showBars,
    required this.firstName,
    required this.secondName,
    required this.textColor,
    required this.gridColor,
    required this.firstColor,
    required this.secondColor,
  });

  void _drawText(
    Canvas canvas,
    String text,
    Offset position,
    TextStyle style,
  ) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    );

    painter.layout();

    painter.paint(
      canvas,
      position,
    );
  }

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    if (points.isEmpty) return;

    const left = 48.0;
    const right = 16.0;
    const top = 38.0;
    const bottom = 42.0;

    final chart = Rect.fromLTRB(
      left,
      top,
      size.width - right,
      size.height - bottom,
    );

    final allValues = <double>[];

    for (final point in points) {
      if (point.first != null) {
        allValues.add(point.first!);
      }

      if (secondName != null && point.second != null) {
        allValues.add(point.second!);
      }
    }

    if (allValues.isEmpty) return;

    var minValue = allValues.reduce(math.min);
    var maxValue = allValues.reduce(math.max);

    if (minValue == maxValue) {
      minValue -= 1;
      maxValue += 1;
    } else {
      final padding = (maxValue - minValue) * 0.1;

      minValue -= padding;
      maxValue += padding;
    }

    double xFor(int index) {
      if (points.length == 1) {
        return chart.center.dx;
      }

      return chart.left + chart.width * index / (points.length - 1);
    }

    double yFor(double value) {
      final ratio = (value - minValue) / (maxValue - minValue);

      return chart.bottom - ratio * chart.height;
    }

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    for (var i = 0; i <= 4; i++) {
      final y = chart.top + chart.height * i / 4;

      canvas.drawLine(
        Offset(chart.left, y),
        Offset(chart.right, y),
        gridPaint,
      );

      final value = maxValue - (maxValue - minValue) * i / 4;

      _drawText(
        canvas,
        value.toStringAsFixed(
          value.abs() >= 10 ? 0 : 1,
        ),
        Offset(
          2,
          y - 8,
        ),
        TextStyle(
          fontSize: 10,
          color: textColor,
        ),
      );
    }

    _drawText(
      canvas,
      firstName,
      const Offset(
        48,
        6,
      ),
      TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: firstColor,
      ),
    );

    if (secondName != null) {
      _drawText(
        canvas,
        secondName!,
        const Offset(
          160,
          6,
        ),
        TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: secondColor,
        ),
      );
    }

    final labelIndexes = <int>{
      0,
      points.length ~/ 3,
      (points.length * 2) ~/ 3,
      points.length - 1,
    }.toList()..sort();

    for (final index in labelIndexes) {
      final x = xFor(index);

      _drawText(
        canvas,
        _shortDate(points[index].date),
        Offset(
          x - 24,
          chart.bottom + 10,
        ),
        TextStyle(
          fontSize: 9,
          color: textColor,
        ),
      );
    }

    void drawSeries(
      bool secondSeries,
      Color color,
    ) {
      final valid = <int>[];

      for (var i = 0; i < points.length; i++) {
        final value = secondSeries ? points[i].second : points[i].first;

        if (value != null) {
          valid.add(i);
        }
      }

      if (showBars) {
        final groupWidth = chart.width / points.length;

        final barWidth = math.max(
          2.0,
          math.min(
            18.0,
            groupWidth * 0.28,
          ),
        );

        for (final i in valid) {
          final value = secondSeries ? points[i].second! : points[i].first!;

          final x = xFor(i);

          final offset = secondSeries ? barWidth / 2 : -barWidth / 2;

          final y = yFor(value);

          canvas.drawRect(
            Rect.fromLTRB(
              x + offset - barWidth / 2,
              y,
              x + offset + barWidth / 2,
              chart.bottom,
            ),
            Paint()..color = color,
          );
        }
      } else {
        final linePaint = Paint()
          ..color = color
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

        final dotPaint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

        final path = Path();

        var started = false;

        for (final i in valid) {
          final value = secondSeries ? points[i].second! : points[i].first!;

          final point = Offset(
            xFor(i),
            yFor(value),
          );

          if (!started) {
            path.moveTo(
              point.dx,
              point.dy,
            );

            started = true;
          } else {
            path.lineTo(
              point.dx,
              point.dy,
            );
          }

          canvas.drawCircle(
            point,
            3.5,
            dotPaint,
          );
        }

        if (valid.length > 1) {
          canvas.drawPath(
            path,
            linePaint,
          );
        }
      }
    }

    drawSeries(
      false,
      firstColor,
    );

    if (secondName != null) {
      drawSeries(
        true,
        secondColor,
      );
    }
  }

  String _shortDate(DateTime date) {
    return '${date.month}/${date.day}';
  }

  @override
  bool shouldRepaint(
    covariant _ProgressGraphPainter oldDelegate,
  ) {
    return oldDelegate.points != points ||
        oldDelegate.showBars != showBars ||
        oldDelegate.firstName != firstName ||
        oldDelegate.secondName != secondName;
  }
}
