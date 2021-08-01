import 'package:flutter/material.dart';
import 'package:mathsapp/providers/user_data_provider.dart';
import 'package:mathsapp/screens/topic_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Flexible(
                flex: 2,
                child: Text(
                  "Level ${userDataProvider.level}",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 2,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: ElevatedButton(
                    onPressed: () => userDataProvider.level += 1,
                    child: const Text("Next Level"),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(TopicScreen.routeName),
                child: const Text("Stuff screen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
