import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/app_text_field.dart';
import 'form_error_text.dart';

/// Month / day / year fields. Tapping any of them opens the date picker.
class BirthDateFields extends StatefulWidget {
  const BirthDateFields({super.key, required this.value, required this.onChanged, this.errorText});

  final DateTime? value;
  final ValueChanged<DateTime> onChanged;

  /// Inline message under the fields (e.g. too young); null hides it.
  final String? errorText;

  static const int _oldestYear = 1900;
  static const int _defaultAgeYears = 20;

  @override
  State<BirthDateFields> createState() => _BirthDateFieldsState();
}

class _BirthDateFieldsState extends State<BirthDateFields> {
  final _month = TextEditingController();
  final _day = TextEditingController();
  final _year = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncText();
  }

  @override
  void didUpdateWidget(BirthDateFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _syncText();
  }

  @override
  void dispose() {
    _month.dispose();
    _day.dispose();
    _year.dispose();
    super.dispose();
  }

  void _syncText() {
    final date = widget.value;
    final locale = Localizations.localeOf(context).toLanguageTag();
    _month.text = date == null ? '' : DateFormat.MMMM(locale).format(date);
    _day.text = date == null ? '' : DateFormat.d(locale).format(date);
    _year.text = date == null ? '' : DateFormat.y(locale).format(date);
  }

  Future<void> _pickDate() async {
    final today = DateUtils.dateOnly(DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.value ?? DateTime(today.year - BirthDateFields._defaultAgeYears),
      firstDate: DateTime(BirthDateFields._oldestYear),
      lastDate: today,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null) widget.onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        _field(_month, l10n.monthHint),
        const SizedBox(height: AppSpacing.lg),
        _field(_day, l10n.dayHint),
        const SizedBox(height: AppSpacing.lg),
        _field(_year, l10n.yearHint),
        if (widget.errorText case final message?) ...[
          const SizedBox(height: AppSpacing.sm),
          Align(alignment: AlignmentDirectional.centerStart, child: FormErrorText(message)),
        ],
      ],
    );
  }

  Widget _field(TextEditingController controller, String hint) =>
      AppTextField(controller: controller, hintText: hint, readOnly: true, onTap: _pickDate);
}
