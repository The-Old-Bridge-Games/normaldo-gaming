import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/auth/auth_cubit.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _onChangeLocalePressed() {
    final currLocale = context.locale;
    final nextLocale = List.from(context.supportedLocales)..remove(currLocale);
    context.setLocale(nextLocale.first);
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      print(context.locale.languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings'.tr(),
          style: textTheme.displayLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BouncingButton(
                onPressed: _onChangeLocalePressed,
                child: Text(
                  'Language'.tr(
                    args: [context.locale.languageCode],
                  ),
                  style: textTheme.displayMedium,
                ),
              ),
              const Spacer(),
              _buildLogoutButton(context, textTheme),
            ],
          ),
        ),
      ),
    );
  }

  BouncingButton _buildLogoutButton(
    BuildContext context,
    TextTheme textTheme,
  ) {
    return BouncingButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Are you sure?'.tr()),
                  content: Text("You're going to logout your account".tr()),
                  actions: [
                    ActionChip(
                      onPressed: () async {
                        context.pop();
                        context.read<AuthCubit>().logout();
                      },
                      label: const Text('Yep',
                          style: TextStyle(color: Colors.red)),
                    ),
                    ActionChip(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      label: const Text('Nope'),
                    ),
                  ],
                ));
      },
      child: Text(
        'Sign out'.tr(),
        style: textTheme.displayMedium?.copyWith(color: Colors.red[900]),
      ),
    );
  }
}
