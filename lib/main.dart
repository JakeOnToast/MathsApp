import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathsapp/providers/admob_state_provider.dart';
import './storage_helper.dart';
import './providers/topic_provider.dart';
import './providers/user_data_provider.dart';
import './constants/routes.dart';
import './screens/topic_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize adds
  final adInitFuture = MobileAds.instance.initialize();
  await HiveHelper.initializeHive();

  final user = await HiveHelper.loadUser();
  final topics = await HiveHelper.loadTopics();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
        ChangeNotifierProvider(create: (_) => TopicProvider()..topics = topics),
        Provider.value(value: user),
        ChangeNotifierProvider(create: (_) => AdState(adInitFuture)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // lock orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // fontFamily: "Choco"
          ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: TopicScreen.routeName,
      routes: routes,
    );
  }
}

Future<UserCredential?> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  if (googleUser == null) return null;

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
