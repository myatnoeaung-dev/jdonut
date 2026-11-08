import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../widgets/registration_step_scaffold.dart';

/// Step 3 of 4: first and last name.
class NamePage extends StatefulWidget {
  const NamePage({super.key});

  static const int step = 3;

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return RegistrationStepScaffold(
      step: NamePage.step,
      title: l10n.nameTitle,
      onContinue: () => context.push(AppRoutes.birthDate),
      children: [
        AppTextField(
          controller: _firstName,
          hintText: l10n.firstNameHint,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.givenName],
          autofocus: true,
        ),
        const SizedBox(height: AppSpacing.lg),
        AppTextField(
          controller: _lastName,
          hintText: l10n.lastNameHint,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.familyName],
        ),
      ],
    );
  }
}
