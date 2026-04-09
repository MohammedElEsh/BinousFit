import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/localization/locale_keys.dart';
import '../../../../config/router/route_names.dart';
import '../../../../shared/components/app_button.dart';
import '../../../../shared/components/app_text_field.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

/// Login fields and submit (uses [AuthCubit]).
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (_) => context.go(RouteNames.home),
          orElse: () {},
        );
      },
      builder: (context, state) {
        final loading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        return SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                controller: _email,
                label: tr(AuthKeys.email),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: _password,
                label: tr(AuthKeys.password),
                obscure: true,
              ),
              SizedBox(height: 24.h),
              AppButton(
                label: tr(AuthKeys.login),
                onPressed: loading
                    ? null
                    : () => context.read<AuthCubit>().login(
                          email: _email.text.trim(),
                          password: _password.text,
                        ),
              ),
              TextButton(
                onPressed: () => context.push(RouteNames.register),
                child: Text(tr(AuthKeys.register)),
              ),
            ],
          ),
        );
      },
    );
  }
}
