import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../domain/validators/otp_validator.dart';

/// Six OTP boxes backed by one hidden field, so typing advances box by box,
/// backspace moves back, pasting fills all six and SMS autofill works.
class OtpCodeField extends StatefulWidget {
  const OtpCodeField({
    super.key,
    required this.onCompleted,
    this.isEnabled = true,
    this.hasError = false,
    this.clearTrigger = 0,
  });

  /// Called once all six digits are entered.
  final ValueChanged<String> onCompleted;
  final bool isEnabled;

  /// Outlines the boxes in the error colour.
  final bool hasError;

  /// Any change empties the boxes (after a rejected code).
  final int clearTrigger;

  @override
  State<OtpCodeField> createState() => _OtpCodeFieldState();
}

class _OtpCodeFieldState extends State<OtpCodeField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void didUpdateWidget(OtpCodeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.clearTrigger != widget.clearTrigger) _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String code) {
    if (OtpValidator.isComplete(code)) widget.onCompleted(code);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.l10n.otpFieldLabel,
      child: Stack(
        children: [
          // Redraws the boxes when the code or focus changes, without setState.
          ListenableBuilder(
            listenable: Listenable.merge([_controller, _focusNode]),
            builder: (context, _) => _OtpBoxes(
              code: _controller.text,
              isFocused: _focusNode.hasFocus && widget.isEnabled,
              hasError: widget.hasError,
            ),
          ),
          Positioned.fill(child: _hiddenInput()),
        ],
      ),
    );
  }

  Widget _hiddenInput() {
    return Opacity(
      opacity: 0,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: widget.isEnabled,
        autofocus: true,
        keyboardType: TextInputType.number,
        autofillHints: const [AutofillHints.oneTimeCode],
        showCursor: false,
        enableInteractiveSelection: false,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(OtpValidator.length),
        ],
        onChanged: _onChanged,
        decoration: const InputDecoration(filled: false, counterText: ''),
      ),
    );
  }
}

class _OtpBoxes extends StatelessWidget {
  const _OtpBoxes({required this.code, required this.isFocused, required this.hasError});

  final String code;
  final bool isFocused;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var index = 0; index < OtpValidator.length; index++)
          _OtpBox(
            digit: index < code.length ? code[index] : '',
            isActive: isFocused && index == code.length,
            hasError: hasError,
          ),
      ],
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({required this.digit, required this.isActive, required this.hasError});

  final String digit;
  final bool isActive;
  final bool hasError;

  static const double _borderWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = hasError ? theme.colorScheme.error : theme.colorScheme.primary;
    return Container(
      width: AppSizes.otpBoxWidth,
      constraints: const BoxConstraints(minHeight: AppSizes.otpBoxHeight),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.xs),
        border: isActive || hasError ? Border.all(color: borderColor, width: _borderWidth) : null,
      ),
      child: Text(digit, style: theme.textTheme.titleMedium),
    );
  }
}
