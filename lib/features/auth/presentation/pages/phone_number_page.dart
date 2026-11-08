import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/bloc/submission_status.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../auth_error_messages.dart';
import '../bloc/otp/otp_bloc.dart';
import '../bloc/phone/phone_bloc.dart';
import '../widgets/form_error_text.dart';
import '../widgets/phone_not_registered_message.dart';
import '../widgets/phone_number_field.dart';
import '../widgets/registration_step_scaffold.dart';

/// Step 1 of 4, shared by sign-up and log-in. CONTINUE stays disabled until
/// the number is valid; log-in also checks the number has an account.
class PhoneNumberPage extends StatelessWidget {
  const PhoneNumberPage({super.key});

  static const int step = 1;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneBloc, PhoneState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _onStatusChanged,
      child: BlocBuilder<PhoneBloc, PhoneState>(
        builder: (context, state) => RegistrationStepScaffold(
          step: step,
          title: context.l10n.phoneTitle,
          isContinueEnabled: state.canSubmit,
          isLoading: state.status.isSubmitting,
          onContinue: () => context.read<PhoneBloc>().add(const PhoneSubmitted()),
          children: [_PhoneForm(state: state)],
        ),
      ),
    );
  }

  /// A code was sent: start the OTP step for this number.
  void _onStatusChanged(BuildContext context, PhoneState state) {
    if (state.status != SubmissionStatus.success) return;
    context.read<OtpBloc>().add(OtpStarted(state.phoneNumber ?? ''));
    context.push(AppRoutes.otp);
  }
}

class _PhoneForm extends StatelessWidget {
  const _PhoneForm({required this.state});

  final PhoneState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bloc = context.read<PhoneBloc>();
    final visibleError = state.visibleError;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PhoneNumberField(
          initialValue: state.input,
          errorText: visibleError == null ? null : l10n.phoneErrorMessage(visibleError),
          onChanged: (input) => bloc.add(PhoneChanged(input)),
          onFocusLost: () => bloc.add(const PhoneFocusLost()),
        ),
        if (state.submitError case final error?) ...[
          const SizedBox(height: AppSpacing.md),
          switch (error) {
            PhoneSubmitError.notRegistered => PhoneNotRegisteredMessage(
              onRegisterTap: () => bloc.add(const PhoneRegisterInsteadTapped()),
            ),
            PhoneSubmitError.unknown => FormErrorText(l10n.errorGeneric),
          },
        ],
      ],
    );
  }
}
