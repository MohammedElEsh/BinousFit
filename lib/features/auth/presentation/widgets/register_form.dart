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

/// Register fields and submit.
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
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
                controller: _name,
                label: tr(AuthKeys.name),
              ),
              SizedBox(height: 16.h),
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
              SizedBox(height: 16.h),
              AppTextField(
                controller: _confirm,
                label: tr(AuthKeys.confirmPassword),
                obscure: true,
              ),
              SizedBox(height: 24.h),
              AppButton(
                label: tr(AuthKeys.register),
                onPressed: loading
                    ? null
                    : () => context.read<AuthCubit>().register(
                          name: _name.text.trim(),
                          email: _email.text.trim(),
                          password: _password.text,
                          confirmPassword: _confirm.text,
                        ),
              ),
            ],
          ),
        );
      },
    );
  }
}
