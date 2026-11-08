import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';

/// Six OTP boxes backed by one hidden text field, so paste and SMS autofill work.
class OtpCodeField extends StatefulWidget {
  const OtpCodeField({super.key, required this.onCompleted});

  static const int length = 6;

  /// Called once all six digits are entered.
  final ValueChanged<String> onCompleted;

  @override
  State<OtpCodeField> createState() => _OtpCodeFieldState();
}

class _OtpCodeFieldState extends State<OtpCodeField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String code) {
    setState(() {});
    if (code.length == OtpCodeField.length) widget.onCompleted(code);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.l10n.otpFieldLabel,
      child: Stack(
        children: [
          _OtpBoxes(code: _controller.text, isFocused: _focusNode.hasFocus),
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
        autofocus: true,
        keyboardType: TextInputType.number,
        autofillHints: const [AutofillHints.oneTimeCode],
        showCursor: false,
        enableInteractiveSelection: false,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(OtpCodeField.length),
        ],
        onChanged: _onChanged,
        decoration: const InputDecoration(filled: false, counterText: ''),
      ),
    );
  }
}

class _OtpBoxes extends StatelessWidget {
  const _OtpBoxes({required this.code, required this.isFocused});

  final String code;
  final bool isFocused;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var index = 0; index < OtpCodeField.length; index++)
          _OtpBox(digit: index < code.length ? code[index] : '', isActive: isFocused && index == code.length),
      ],
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({required this.digit, required this.isActive});

  final String digit;
  final bool isActive;

  static const double _activeBorderWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: AppSizes.otpBoxWidth,
      constraints: const BoxConstraints(minHeight: AppSizes.otpBoxHeight),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.xs),
        border: isActive ? Border.all(color: theme.colorScheme.primary, width: _activeBorderWidth) : null,
      ),
      child: Text(digit, style: theme.textTheme.titleMedium),
    );
  }
}
