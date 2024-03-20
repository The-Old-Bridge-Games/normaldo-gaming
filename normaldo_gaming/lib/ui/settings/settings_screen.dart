import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/skins/skins_repository.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';
import 'package:normaldo_gaming/ui/widgets/liner_button.dart';
import 'package:normaldo_gaming/ui/widgets/ng_button.dart';

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

  void _onIntroPressed() {}
  void _onResetPressed() {
    context.read<UserCubit>().reset();
    context.pop();
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
        leading: const Row(
          children: [
            NGBackButton(),
          ],
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings'.tr(),
          style: textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NGButton(
                      onPressed: _onChangeLocalePressed,
                      text: 'Language'.tr(
                        args: [context.locale.languageCode],
                      ),
                    ),
                    NGButton(
                      text: 'intro'.tr(),
                      onPressed: _onIntroPressed,
                    ),
                    NGButton(
                      onPressed: _onResetPressed,
                      text: 'reset'.tr(),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Center(
                  child: Text('- О НАС -', style: textTheme.displayLarge),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                        child: AboutUsCard(
                      model: AboutUsModel(
                        name: 'Gleb',
                        position: 'Designer',
                        description: 'Do not eat bread',
                        imagePath: 'assets/images/us/gashan_pix.png',
                      ),
                    )),
                    const SizedBox(width: 32),
                    Expanded(
                      child: AboutUsCard(
                        model: AboutUsModel(
                          name: 'GojiTBT',
                          position: 'Sound Designer',
                          description: 'Im a ZAZA boi',
                          imagePath: 'assets/images/us/gashan_pix.png',
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: AboutUsCard(
                        model: AboutUsModel(
                          name: 'pROC',
                          position: 'Developer',
                          description:
                              'No matter how fast are you, only matters keep goin',
                          imagePath: 'assets/images/us/gashan_pix.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
                        // context.read<AuthCubit>().logout();
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

class AboutUsCard extends StatelessWidget {
  final AboutUsModel model;

  const AboutUsCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AspectRatio(
      aspectRatio: 4 / 5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: NGTheme.colorOf(SkinRarity.legendary),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              width: 5, color: NGTheme.colorOf(SkinRarity.legendary)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                model.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(model.name, style: textTheme.displayMedium),
                  const SizedBox(height: 4),
                  Text(model.position,
                      style: textTheme.displayMedium
                          ?.copyWith(color: NGTheme.purple1)),
                  const SizedBox(height: 8),
                  Text(
                    model.description,
                    style: textTheme.bodySmall,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class AboutUsModel {
  final String name;
  final String position;
  final String description;
  final String imagePath;

  AboutUsModel({
    required this.name,
    required this.position,
    required this.description,
    required this.imagePath,
  });
}
