import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../auth_error_messages.dart';
import '../bloc/profile/profile_bloc.dart';
import '../widgets/registration_step_scaffold.dart';

/// Step 3 of 4: first name (required) and last name (optional).
class NamePage extends StatelessWidget {
  const NamePage({super.key});

  static const int step = 3;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) => previous.nameConfirmations != current.nameConfirmations,
      listener: (context, _) => context.push(AppRoutes.birthDate),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.visibleFirstNameError != current.visibleFirstNameError ||
            previous.visibleLastNameError != current.visibleLastNameError,
        builder: (context, state) => RegistrationStepScaffold(
          step: step,
          title: context.l10n.nameTitle,
          onContinue: () => context.read<ProfileBloc>().add(const ProfileNameSubmitted()),
          children: [_NameFields(state: state)],
        ),
      ),
    );
  }
}

class _NameFields extends StatelessWidget {
  const _NameFields({required this.state});

  final ProfileState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bloc = context.read<ProfileBloc>();
    final firstNameError = state.visibleFirstNameError;
    final lastNameError = state.visibleLastNameError;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          initialValue: state.firstName,
          hintText: l10n.firstNameHint,
          errorText: firstNameError == null ? null : l10n.nameErrorMessage(firstNameError),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.givenName],
          autofocus: true,
          onChanged: (value) => bloc.add(ProfileFirstNameChanged(value)),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppTextField(
          initialValue: state.lastName,
          hintText: l10n.lastNameHint,
          errorText: lastNameError == null ? null : l10n.nameErrorMessage(lastNameError),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.familyName],
          onChanged: (value) => bloc.add(ProfileLastNameChanged(value)),
        ),
      ],
    );
  }
}
