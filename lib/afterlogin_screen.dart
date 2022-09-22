import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/MenuController.dart';
import 'screens/main/main_screen.dart';

class AfterLoginScreen extends StatelessWidget {
  const AfterLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
      ],
      child: MainScreen(),
    );
  }
}
