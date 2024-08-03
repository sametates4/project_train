import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_train/core/model/user_model.dart';
import 'package:project_train/core/state/app_state.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                hintText: 'KKY Numarasını Giriniz',
              ),
            ),
            ElevatedButton(
              child: const Text('Giriş'),
              onPressed: () {
                context.read<AppState>().service.login(userData: {
                  'kky': int.parse(controller.text)
                }).then((value) {
                  final user = UserModel.fromJson(value!);
                  context.read<AppState>().setUser(userData: user);
                  context.router.maybePop();
                },);
              },
            )
          ],
        ),
      ),
    );
  }
}
