
import 'package:flutter/material.dart';
import 'package:my_progress_client/my_progress_client.dart';

import '../main.dart' show client;

class FieldsScreen extends StatefulWidget {
  final int subtopicId;
  final String subtopicName;

  const FieldsScreen({
    super.key,
    required this.subtopicId,
    required this.subtopicName,
  });

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  List<Field> _fields = [];
  bool _loading = true;
  bool _saving = false;
  final Set<int> _deletingIds = {};

  static const Map<String, String> _fieldTypes = {
    'text': 'Text',
    'number': 'Number',
    'boolean': 'Yes / No',
    'rating': 'Rating',
  };

  @override
  void initState() {
    super.initState();
    _loadFields();
  }

  Future<void> _loadFields() async {
    try {
      final fields = await client.field.getFields(widget.subtopicId);

      if (!mounted) return;

      setState(() {
        _fields = fields;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() => _loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not load fields: $e')),
      );
    }
  }

  Future<void> _addField() async {
    if (_saving) return;

    final nameController = TextEditingController();
    String selectedType = 'text';

    try {
      final result = await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                title: const Text('Create a field'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Field name',
                        hintText: 'e.g. Hours studied',
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Field type',
                      ),
                      items: _fieldTypes.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setDialogState(() => selectedType = value);
                      },
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
              );
            },
          );
        },
      );

      if (result != true || !mounted) return;

      final name = nameController.text.trim();

      if (name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter a field name first.')),
        );
        return;
      }

      if (_fields.any(
        (field) => field.name.toLowerCase() == name.toLowerCase(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('That field already exists.')),
        );
        return;
      }

      setState(() => _saving = true);

      try {
        final field = await client.field.createField(
          widget.subtopicId,
          name,
          selectedType,
          _fields.length,
        );

        if (!mounted) return;

        setState(() {
          _fields = [..._fields, field];
          _saving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Field saved successfully!')),
        );
      } catch (e) {
        if (!mounted) return;

        setState(() => _saving = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not save field: $e')),
        );
      }
    } finally {
      nameController.dispose();
    }
  }

  Future<void> _editField(Field field) async {
    final fieldId = field.id;

    if (fieldId == null || _saving) return;

    final nameController = TextEditingController(text: field.name);
    String selectedType = _fieldTypes.containsKey(field.type)
        ? field.type
        : 'text';

    try {
      final result = await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                title: const Text('Edit field'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Field name',
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Field type',
                      ),
                      items: _fieldTypes.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setDialogState(() => selectedType = value);
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Changing the type may affect how older entries '
                      'are interpreted in reports and graphs.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
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
              );
            },
          );
        },
      );

      if (result != true || !mounted) return;

      final name = nameController.text.trim();

      if (name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter a field name.')),
        );
        return;
      }

      if (_fields.any(
        (item) =>
            item.id != fieldId &&
            item.name.toLowerCase() == name.toLowerCase(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('That field already exists.')),
        );
        return;
      }

      setState(() => _saving = true);

      try {
        final updated = await client.field.updateField(
          fieldId,
          name,
          selectedType,
        );

        if (!mounted) return;

        if (updated == null) {
          setState(() => _saving = false);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Field was not found.')),
          );

          await _loadFields();
          return;
        }

        setState(() {
          _fields = _fields.map((item) {
            return item.id == fieldId ? updated : item;
          }).toList();
          _saving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Field updated successfully!')),
        );
      } catch (e) {
        if (!mounted) return;

        setState(() => _saving = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not update field: $e')),
        );
      }
    } finally {
      nameController.dispose();
    }
  }

  Future<void> _deleteField(Field field) async {
    final fieldId = field.id;

    if (fieldId == null || _deletingIds.contains(fieldId)) {
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete field?'),
        content: Text(
          'Are you sure you want to delete "${field.name}"? '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _deletingIds.add(fieldId));

    try {
      final deleted = await client.field.deleteField(fieldId);

      if (!mounted) return;

      if (deleted) {
        setState(() {
          _fields.removeWhere((item) => item.id == fieldId);
          _deletingIds.remove(fieldId);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Field deleted successfully.')),
        );
      } else {
        setState(() => _deletingIds.remove(fieldId));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Field was not found. It may already be deleted.',
            ),
          ),
        );

        await _loadFields();
      }
    } catch (e) {
      if (!mounted) return;

      setState(() => _deletingIds.remove(fieldId));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not delete field: $e')),
      );
    }
  }

  String _fieldTypeLabel(String type) {
    return _fieldTypes[type] ?? 'Text';
  }

  IconData _fieldIcon(String type) {
    switch (type) {
      case 'number':
        return Icons.numbers;
      case 'boolean':
        return Icons.toggle_on_outlined;
      case 'rating':
        return Icons.star_outline;
      case 'text':
      default:
        return Icons.text_fields;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      appBar: AppBar(
        title: Text(widget.subtopicName),
        backgroundColor: const Color(0xFFF7F7FB),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                widget.subtopicName,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Create the information you want to track for this subtopic.',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Custom fields',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _saving ? null : _addField,
                    icon: const Icon(Icons.add),
                    label: Text(_saving ? 'Saving...' : 'Add field'),
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
              else if (_fields.isEmpty)
                Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.tune,
                          size: 40,
                          color: Color(0xFF6558D3),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'No fields yet',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Add fields to define what you want to track.',
                          style: TextStyle(color: Colors.grey[600]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else
                ..._fields.map((field) {
                  final fieldId = field.id;
                  final deleting =
                      fieldId != null && _deletingIds.contains(fieldId);

                  return Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFEEECFF),
                        child: Icon(
                          _fieldIcon(field.type),
                          color: const Color(0xFF6558D3),
                        ),
                      ),
                      title: Text(
                        field.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(_fieldTypeLabel(field.type)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Edit field',
                            onPressed: deleting || _saving
                                ? null
                                : () => _editField(field),
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Color(0xFF6558D3),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Delete field',
                            onPressed: deleting
                                ? null
                                : () => _deleteField(field),
                            icon: deleting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                  ),
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