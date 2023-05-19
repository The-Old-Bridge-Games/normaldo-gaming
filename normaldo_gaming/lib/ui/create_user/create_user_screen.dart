import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _nameController = TextEditingController();

  void _onSelect() {
    if (_nameController.text.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Username length must be greater than 3'),
        showCloseIcon: true,
      ));
    } else {
      BlocProvider.of<UserCubit>(context).changeName(_nameController.text);
      context.goRoute(NGRoutes.main);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Enter your name',
                style: textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: _nameController,
                autocorrect: false,
                cursorColor: NGTheme.green1,
                style: textTheme.bodySmall?.copyWith(color: NGTheme.green1),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 2,
                  ),
                  filled: true,
                  hintText: 'iamproc...',
                  hintStyle: textTheme.bodySmall?.copyWith(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 2.0,
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 2.0,
                      color: NGTheme.green1,
                    ),
                  ),
                  focusColor: NGTheme.green1,
                  hoverColor: NGTheme.green1,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 48),
            BouncingButton(
                onPressed: _onSelect,
                child: Text(
                  'Select',
                  style: Theme.of(context).textTheme.displayLarge,
                )),
          ],
        ),
      ),
    );
  }
}
