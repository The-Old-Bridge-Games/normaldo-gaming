import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/auth/auth_cubit.dart';
import 'package:normaldo_gaming/application/sign_up/sign_up_cubit.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';
import 'package:normaldo_gaming/ui/widgets/ng_button.dart';
import 'package:normaldo_gaming/ui/widgets/ng_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  void _blocListener(BuildContext context, SignUpState state) {
    if (state.failure != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red[900],
          content: Text(
            state.failure!.description?.tr() ?? 'Something goes wrong..'.tr(),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    final textFieldWidth = screenSize.width / 2.5;
    final cubit = context.read<SignUpCubit>();
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: BlocConsumer<SignUpCubit, SignUpState>(
              listener: _blocListener,
              builder: (context, state) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: screenSize.height,
                    child: Stack(
                      children: [
                        ..._stickers(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  Text(
                                    'Registration'.tr(),
                                    style: textTheme.displayLarge,
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: textFieldWidth,
                                    child: NGFormTextField(
                                      validator: (value) => !state.nickname
                                              .validate()
                                          ? 'nickname must be 3 chars at least'
                                              .tr()
                                          : null,
                                      onChanged: (value) =>
                                          cubit.changeNickname(value),
                                      placeholder: 'Nickname..'.tr(),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: textFieldWidth,
                                    child: NGFormTextField(
                                      validator: (value) =>
                                          !state.email.validate()
                                              ? 'incorrect email'.tr()
                                              : null,
                                      onChanged: (value) =>
                                          cubit.changeEmail(value),
                                      placeholder: 'Email..',
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: textFieldWidth,
                                    child: NGFormTextField(
                                      validator: (value) => !state.password
                                              .validate()
                                          ? 'password must be 6 chars at least'
                                              .tr()
                                          : null,
                                      onChanged: (value) =>
                                          cubit.changePassword(value),
                                      placeholder: 'Password'.tr(),
                                      obscureText: true,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: textFieldWidth,
                                    child: NGFormTextField(
                                      validator: (value) =>
                                          !state.passwordsMatch
                                              ? "passwords don't match".tr()
                                              : null,
                                      onChanged: (value) =>
                                          cubit.changeRepeatPassword(value),
                                      placeholder: 'Repeat password..'.tr(),
                                      obscureText: true,
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        NGButton(
                                          text: 'Sign Up'.tr(),
                                          onPressed: () async {
                                            final success = await context
                                                .read<SignUpCubit>()
                                                .signUp();
                                            if (success) {
                                              context.read<AuthCubit>().auth();
                                            }
                                          },
                                        ),
                                        const SizedBox(width: 32),
                                        NGTextButton(
                                          text: 'Sign In'.tr(),
                                          onPressed: () => context
                                              .push(NGRoutes.signIn.path),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  List<Widget> _stickers() {
    return [
      Positioned(
        top: 24,
        left: 24,
        child: Image.asset(
          'assets/images/stickers/hmm.png',
          width: 70,
        ),
      ),
      Positioned(
        bottom: 24,
        left: 64,
        child: Image.asset(
          'assets/images/stickers/ufo.png',
          width: 100,
        ),
      ),
      Positioned(
        top: 100,
        left: 100,
        child: Image.asset(
          'assets/images/stickers/time.png',
          width: 100,
        ),
      ),
      Positioned(
        top: 200,
        left: 8,
        child: Image.asset(
          'assets/images/stickers/screw.png',
          width: 70,
        ),
      ),
      // Right side
      Positioned(
        top: 24,
        right: 24,
        child: Image.asset(
          'assets/images/stickers/sleep.png',
          width: 70,
        ),
      ),
      Positioned(
        bottom: 24,
        right: 64,
        child: Image.asset(
          'assets/images/stickers/ok.png',
          width: 100,
        ),
      ),
      Positioned(
        top: 100,
        right: 8,
        child: Transform.rotate(
          angle: pi * 0.3,
          child: Image.asset(
            'assets/images/normaldo_label.png',
            width: 300,
          ),
        ),
      ),
    ];
  }
}
