import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/bloc/submission_status.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../auth_error_messages.dart';
import '../bloc/phone/phone_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import '../widgets/birth_date_fields.dart';
import '../widgets/form_error_text.dart';
import '../widgets/registration_step_scaffold.dart';

/// Step 4 of 4: the ring turns into a check. CONTINUE creates the account
/// and opens Welcome.
class BirthDatePage extends StatelessWidget {
  const BirthDatePage({super.key});

  static const int step = 4;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) =>
          previous.status != current.status && current.status == SubmissionStatus.success,
      listener: (context, _) => context.go(AppRoutes.welcome),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) => RegistrationStepScaffold(
          step: step,
          title: context.l10n.birthDateTitle,
          isContinueEnabled: state.canSubmit,
          isLoading: state.status.isSubmitting,
          onContinue: () => _submit(context),
          children: [_BirthDateForm(state: state)],
        ),
      ),
    );
  }

  /// The account uses the number verified on step 1.
  void _submit(BuildContext context) {
    final phoneNumber = context.read<PhoneBloc>().state.phoneNumber ?? '';
    context.read<ProfileBloc>().add(ProfileSubmitted(phoneNumber));
  }
}

class _BirthDateForm extends StatelessWidget {
  const _BirthDateForm({required this.state});

  final ProfileState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final error = state.visibleBirthDateError;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BirthDateFields(
          value: state.birthDate,
          errorText: error == null ? null : l10n.birthDateErrorMessage(error),
          onChanged: (date) => context.read<ProfileBloc>().add(ProfileBirthDateChanged(date)),
        ),
        if (state.status == SubmissionStatus.failure) ...[
          const SizedBox(height: AppSpacing.md),
          FormErrorText(l10n.errorGeneric),
        ],
      ],
    );
  }
}
