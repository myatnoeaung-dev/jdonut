import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/bloc/submission_status.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/widgets/shake_on_trigger.dart';
import '../auth_error_messages.dart';
import '../bloc/otp/otp_bloc.dart';
import '../widgets/form_error_text.dart';
import '../widgets/otp_code_field.dart';
import '../widgets/registration_step_scaffold.dart';
import '../widgets/resend_countdown.dart';

/// Step 2 of 4. The code is checked as soon as six digits are in — there is no
/// CONTINUE button. Members go Home; new numbers continue to their name.
class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key});

  static const int step = 2;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OtpBloc, OtpState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: _onStatusChanged,
        ),
        // A wrong code buzzes as the boxes shake.
        BlocListener<OtpBloc, OtpState>(
          listenWhen: (previous, current) => current.rejectedCodes > previous.rejectedCodes,
          listener: (_, _) => HapticFeedback.heavyImpact(),
        ),
      ],
      child: BlocBuilder<OtpBloc, OtpState>(
        builder: (context, state) => RegistrationStepScaffold(
          step: step,
          title: context.l10n.otpTitle,
          showContinue: false,
          children: [_OtpForm(state: state)],
        ),
      ),
    );
  }

  void _onStatusChanged(BuildContext context, OtpState state) {
    if (state.status != SubmissionStatus.success) return;
    switch (state.outcome) {
      case OtpOutcomeKind.signedIn:
        context.go(AppRoutes.home);
      case OtpOutcomeKind.needsRegistration:
        context.push(AppRoutes.name);
      case null:
        break;
    }
  }
}

class _OtpForm extends StatelessWidget {
  const _OtpForm({required this.state});

  final OtpState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bloc = context.read<OtpBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.otpSentTo(state.phoneNumber), style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.xxl),
        ShakeOnTrigger(
          trigger: state.rejectedCodes,
          child: OtpCodeField(
            isEnabled: state.isInputEnabled,
            hasError: state.error != null,
            clearTrigger: state.rejectedCodes,
            onCompleted: (code) => bloc.add(OtpCodeCompleted(code)),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        // Grows smoothly as the status or error line appears.
        AnimatedSize(
          duration: context.motion(AppDurations.short),
          curve: AppCurves.emphasized,
          alignment: Alignment.topLeft,
          child: _OtpStatusLine(state: state),
        ),
        const SizedBox(height: AppSpacing.xl),
        ResendCountdown(
          remaining: state.resendIn,
          canResend: state.canResend,
          isResending: state.isResending,
          onResend: () => bloc.add(const OtpResendRequested()),
        ),
      ],
    );
  }
}

/// "Checking code…" while verifying, otherwise the error (if any).
class _OtpStatusLine extends StatelessWidget {
  const _OtpStatusLine({required this.state});

  final OtpState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (state.status.isSubmitting) return Text(l10n.otpVerifying, style: Theme.of(context).textTheme.bodyMedium);
    final error = state.error;
    if (error == null) return const SizedBox.shrink();
    return FormErrorText(l10n.otpErrorMessage(error, attemptsLeft: state.attemptsLeft));
  }
}
