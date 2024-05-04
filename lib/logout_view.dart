import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_flutter/auth_provider.dart';

class LogoutView extends StatelessWidget {
  const LogoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: context.read<AuthProvider>().logoutUser(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Ошибка при выходе из системы: ${snapshot.error}');
            } else {
              return Text('Выход из системы...');
            }
          },
        ),
      ),
    );
  }
}
