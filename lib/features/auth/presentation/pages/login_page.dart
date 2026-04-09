import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/localization/locale_keys.dart';
import '../../../../injection_container.dart';
import '../../../../shared/components/app_appbar.dart';
import '../bloc/auth_cubit.dart';
import '../widgets/login_form.dart';

/// Login screen.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: Scaffold(
        appBar: AppAppBar(
          title: tr(AuthKeys.login),
          showBack: false,
        ),
        body: const LoginForm(),
      ),
    );
  }
}
