import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/session/auth_session.dart';
import '../widgets/birth_date_fields.dart';
import '../widgets/registration_step_scaffold.dart';

/// Step 4 of 4: the ring turns into a check. Finishing signs the user in.
class BirthDatePage extends StatefulWidget {
  const BirthDatePage({super.key});

  static const int step = 4;

  @override
  State<BirthDatePage> createState() => _BirthDatePageState();
}

class _BirthDatePageState extends State<BirthDatePage> {
  DateTime? _birthDate;

  void _finish() {
    getIt<AuthSession>().signIn();
    context.go(AppRoutes.welcome);
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationStepScaffold(
      step: BirthDatePage.step,
      title: context.l10n.birthDateTitle,
      onContinue: _finish,
      children: [
        BirthDateFields(value: _birthDate, onChanged: (date) => setState(() => _birthDate = date)),
      ],
    );
  }
}
