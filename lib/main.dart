import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './providers/topic_provider.dart';
import './providers/user_data_provider.dart';
import './constants/routes.dart';
import './screens/topic_screen.dart';
import 'package:provider/provider.dart';

import 'constants/shared_prefs.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupPrefs();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
        ChangeNotifierProvider(create: (_) => TopicProvider()),
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
