import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/session/auth_session.dart';
import '../../../../core/theme/app_dimens.dart';
import '../widgets/otp_code_field.dart';
import '../widgets/registration_step_scaffold.dart';
import '../widgets/resend_countdown.dart';

/// Step 2 of 4. Entering all six digits moves on — there is no CONTINUE button.
class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key, required this.flow, required this.phoneNumber});

  static const int step = 2;

  final AuthFlow flow;
  final String phoneNumber;

  /// UI only: any 6 digits are accepted. Existing users go home, new users
  /// continue registration.
  void _onCodeEntered(BuildContext context, String code) {
    switch (flow) {
      case AuthFlow.login:
        getIt<AuthSession>().signIn();
        context.go(AppRoutes.home);
      case AuthFlow.register:
        context.push(AppRoutes.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return RegistrationStepScaffold(
      step: step,
      title: l10n.otpTitle,
      showContinue: false,
      children: [
        Text(l10n.otpSentTo(phoneNumber), style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.xxl),
        OtpCodeField(onCompleted: (code) => _onCodeEntered(context, code)),
        const SizedBox(height: AppSpacing.xxl),
        ResendCountdown(onResend: () {}),
      ],
    );
  }
}
