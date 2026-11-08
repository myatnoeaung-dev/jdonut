import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// White, borderless text field from the registration screens.
/// Styling comes from the theme's `inputDecorationTheme`.
///
/// Pass [initialValue] to let the field own its controller, so pages that keep
/// the value in a bloc don't need any widget state of their own.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.errorText,
    this.prefix,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.autofocus = false,
    this.enabled = true,
    this.onTap,
    this.onChanged,
    this.onFocusLost,
  }) : assert(controller == null || initialValue == null, 'Pass either a controller or an initialValue');

  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;

  /// Inline message under the field; null hides it.
  final String? errorText;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final bool autofocus;
  final bool enabled;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  /// Called when the field loses focus (e.g. to show validation only after editing).
  final VoidCallback? onFocusLost;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  TextEditingController? _ownController;

  TextEditingController get _controller =>
      widget.controller ?? (_ownController ??= TextEditingController(text: widget.initialValue));

  @override
  void dispose() {
    _ownController?.dispose();
    super.dispose();
  }

  void _onFocusChanged(bool hasFocus) {
    if (!hasFocus) widget.onFocusLost?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: _onFocusChanged,
      skipTraversal: true,
      child: TextField(
        controller: _controller,
        style: Theme.of(context).textTheme.bodyLarge,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatters,
        autofillHints: widget.autofillHints,
        textCapitalization: widget.textCapitalization,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        enabled: widget.enabled,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        decoration: InputDecoration(hintText: widget.hintText, errorText: widget.errorText, prefixIcon: widget.prefix),
      ),
    );
  }
}
