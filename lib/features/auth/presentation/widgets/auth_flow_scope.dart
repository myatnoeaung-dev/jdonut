import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_routes.dart';
import '../bloc/otp/otp_bloc.dart';
import '../bloc/phone/phone_bloc.dart';
import '../bloc/profile/profile_bloc.dart';

/// Provides the step blocs to every page of one sign-in / sign-up flow
/// (phone → OTP → name → date of birth). They live as long as the flow, so
/// going Back keeps what was entered, and they close when the flow ends.
class AuthFlowScope extends StatelessWidget {
  const AuthFlowScope({super.key, required this.initialFlow, required this.child});

  /// Only read when the flow starts; switching to sign-up later goes through [PhoneBloc].
  final AuthFlow initialFlow;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<PhoneBloc>()..add(PhoneFlowSelected(initialFlow))),
        BlocProvider(create: (_) => getIt<OtpBloc>()),
        BlocProvider(create: (_) => getIt<ProfileBloc>()),
      ],
      child: child,
    );
  }
}
