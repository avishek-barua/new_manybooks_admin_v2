import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_context/one_context.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';

import 'afterlogin_screen.dart';
import 'constants.dart';
import 'controllers/MenuController.dart';
import 'firebase_options.dart';
import 'models/after_login.dart';
import 'models/firebase_auth_method.dart';
import 'screens/main/main_screen.dart';
import 'utils/api_callings.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Prefs.init();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
      ],
      child: MainScreen(),),
      // initialRoute: '/',
      // builder: OneContext().builder,
      // navigatorKey: OneContext().key,
      // routes: {
      //   "/":(context) => WelcomeScreen(),
      //   '/after_login':(context) => AfterLoginScreen(),
      //   '/main_screen'
      // },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  Future checkToken(String? tokenJson) async {
    if (tokenJson != null) {
      Prefs.setString("tokenData", tokenJson);
      OneContext().pushNamed(
          // '/dashboard'
          '/upload');
    } else {
      print("null");
    }
  }

  Future<void> onGoogleLogin() async {
    AfterLogin al = await FirebaseAuthMethod().signInWithGoogle();
    String? tokenJson = await ApiCalling.login(al);
    await checkToken(tokenJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            //  await FirebaseAuthMethod(FirebaseAuth.instance).signInWithGoogle(context);
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}
