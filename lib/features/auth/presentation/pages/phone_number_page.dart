import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../widgets/phone_number_field.dart';
import '../widgets/registration_step_scaffold.dart';

/// Step 1 of 4. Shared by sign-up and log-in; [flow] decides where OTP goes next.
class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key, required this.flow});

  static const int step = 1;

  final AuthFlow flow;

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _continue() {
    final fullNumber = '${PhoneNumberField.countryCode}${_phoneController.text}';
    context.push(AppRoutes.otpFor(widget.flow, fullNumber));
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationStepScaffold(
      step: PhoneNumberPage.step,
      title: context.l10n.phoneTitle,
      onContinue: _continue,
      children: [PhoneNumberField(controller: _phoneController)],
    );
  }
}
