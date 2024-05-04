import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_flutter/authProvider.dart';
import 'package:web_flutter/auth_provider.dart';
import 'package:web_flutter/register_provider.dart';
import 'package:web_flutter/views/layout_template/layout_template.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ],
      child: AuthorizationProvider(
        isAuthorized: false,
        hasLicense: false,
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parental Control',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Jura'),
      ),
      home: LayoutTemplate(),
    );
  }
}
