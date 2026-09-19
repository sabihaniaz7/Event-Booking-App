import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../events/domain/entities/event_entity.dart';
import '../controllers/admin_controller.dart';

/// Pass `existing` to edit; omit it to create a new event. One screen
/// covers both — the only difference is which controller method fires.
class AdminEventFormScreen extends ConsumerStatefulWidget {
  const AdminEventFormScreen({super.key, this.existing});
  final EventEntity? existing;

  @override
  ConsumerState<AdminEventFormScreen> createState() =>
      _AdminEventFormScreenState();
}

class _AdminEventFormScreenState extends ConsumerState<AdminEventFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _description;
  late final TextEditingController _location;
  late final TextEditingController _price;
  late final TextEditingController _seats;
  late EventCategory _category;
  late DateTime _date;
  late bool _isFeatured;
  String? _pickedImagePath;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _title = TextEditingController(text: e?.title ?? '');
    _description = TextEditingController(text: e?.description ?? '');
    _location = TextEditingController(text: e?.location ?? '');
    _price = TextEditingController(text: e?.ticketPrice.toString() ?? '');
    _seats = TextEditingController(text: e?.totalSeats.toString() ?? '');
    _category = e?.category ?? EventCategory.music;
    _date = e?.date ?? DateTime.now().add(const Duration(days: 7));
    _isFeatured = e?.isFeatured ?? false;
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _location.dispose();
    _price.dispose();
    _seats.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked != null) setState(() => _pickedImagePath = picked.path);
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 730)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_date),
    );
    if (time == null) return;
    setState(
      () => _date = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_isEditing && _pickedImagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add an event image')),
      );
      return;
    }

    final notifier = ref.read(adminEventFormProvider.notifier);
    final success = _isEditing
        ? await notifier.update(
            id: widget.existing!.id,
            title: _title.text.trim(),
            description: _description.text.trim(),
            category: _category,
            location: _location.text.trim(),
            date: _date,
            ticketPrice: double.parse(_price.text),
            totalSeats: int.parse(_seats.text),
            isFeatured: _isFeatured,
            imagePath: _pickedImagePath,
          )
        : await notifier.create(
            title: _title.text.trim(),
            description: _description.text.trim(),
            category: _category,
            location: _location.text.trim(),
            date: _date,
            ticketPrice: double.parse(_price.text),
            totalSeats: int.parse(_seats.text),
            isFeatured: _isFeatured,
            imagePath: _pickedImagePath!,
          );

    if (success && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final formState = ref.watch(adminEventFormProvider);

    ref.listen(adminEventFormProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: c.error,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit Event' : 'Add Event')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.l24),
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: c.chipBg,
                  borderRadius: BorderRadius.circular(AppSizes.radiusM16),
                  image: _pickedImagePath != null
                      ? DecorationImage(
                          image: FileImage(File(_pickedImagePath!)),
                          fit: BoxFit.cover,
                        )
                      : (_isEditing
                            ? DecorationImage(
                                image: NetworkImage(widget.existing!.imageUrl),
                                fit: BoxFit.cover,
                              )
                            : null),
                ),
                child: (_pickedImagePath == null && !_isEditing)
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_rounded,
                              color: c.textSecondary,
                              size: AppSizes.iconL32,
                            ),
                            const SizedBox(height: AppSizes.xs4),
                            Text(
                              'Add event image',
                              style: AppTextStyles.bodyS13(c.textSecondary),
                            ),
                          ],
                        ),
                      )
                    : Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(AppSizes.s8),
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: Icon(
                              Icons.edit_rounded,
                              color: Colors.white,
                              size: AppSizes.iconS16,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: AppSizes.l24),
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(labelText: 'Event title'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: AppSizes.m16),
            TextFormField(
              controller: _description,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: AppSizes.m16),
            DropdownButtonFormField<EventCategory>(
              initialValue: _category,
              decoration: const InputDecoration(labelText: 'Category'),
              items: EventCategory.values
                  .map(
                    (cat) =>
                        DropdownMenuItem(value: cat, child: Text(cat.label)),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
            const SizedBox(height: AppSizes.m16),
            TextFormField(
              controller: _location,
              decoration: const InputDecoration(labelText: 'Location'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: AppSizes.m16),
            InkWell(
              onTap: _pickDate,
              child: InputDecorator(
                decoration: const InputDecoration(labelText: 'Date & time'),
                child: Text(DateFormat('MMM d, yyyy · h:mm a').format(_date)),
              ),
            ),
            const SizedBox(height: AppSizes.m16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _price,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Ticket price (\$)',
                      labelStyle: TextStyle(fontSize: AppSizes.fontS13),
                    ),
                    validator: (v) => (v == null || double.tryParse(v) == null)
                        ? 'Invalid'
                        : null,
                  ),
                ),
                const SizedBox(width: AppSizes.m12),
                Expanded(
                  child: TextFormField(
                    controller: _seats,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Total seats'),
                    validator: (v) => (v == null || int.tryParse(v) == null)
                        ? 'Invalid'
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.m16),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _isFeatured,
              onChanged: (v) => setState(() => _isFeatured = v),
              title: Text(
                'Show in Featured',
                style: AppTextStyles.bodyM16(c.textPrimary),
              ),
            ),
            const SizedBox(height: AppSizes.l24),
            FilledButton(
              onPressed: formState.isLoading ? null : _submit,
              child: formState.isLoading
                  ? SizedBox(
                      height: AppSizes.iconM20,
                      width: AppSizes.iconM20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: c.onPrimary,
                      ),
                    )
                  : Text(_isEditing ? 'Save Changes' : 'Create Event'),
            ),
          ],
        ),
      ),
    );
  }
}
