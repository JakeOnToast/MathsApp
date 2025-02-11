import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mathsapp/models/topic.dart';
import './maths_app_error.dart';
import '../providers/topic_provider.dart';
import 'package:provider/provider.dart';

enum CloudAction {
  download,
  upload,
}

extension CloudActionExtension on CloudAction {
  String get name {
    switch (this) {
      case CloudAction.download:
        return "Download";
      case CloudAction.upload:
        return "Upload";
    }
  }

  String get adDialogMessage{
    switch (this) {
      case CloudAction.download:
        return "Watch an ad to download your progress.";
      case CloudAction.upload:
        return "Watch an ad to upload your progress.";
    }
  }

  Future Function(BuildContext) get cloudFunction{
    switch (this) {
      case CloudAction.download:
        return (context) async {
          // signed in users document
          final user = FirebaseAuth.instance.currentUser;
          if(user == null){
            throw MathsAppError("User must be signed in to download data");
          }

          final ref = FirebaseFirestore.instance.doc("users/${user.uid}");
          final userDoc = await ref.get();
          final userMap = userDoc.data();
          print("UserMap: $userMap");
          if(userMap == null){
            return;
          }
          final topicProvider = Provider.of<TopicProvider>(context, listen: false);
          final topicMaps = Map<String, Map<String, dynamic>>.from(userMap["topics"]);

          topicProvider.mergeTopics(topicMaps.values.map((map) => Topic.fromMap(map)).toList());

        };
      case CloudAction.upload:
        return (context) async {
          final user = FirebaseAuth.instance.currentUser;
          if(user == null){
            throw MathsAppError("User must be signed in to upload data");
          }
          final topicProvider = Provider.of<TopicProvider>(context, listen: false);
          final ref = FirebaseFirestore.instance.doc("users/${user.uid}");
          ref.set({"topics": topicProvider.packageTopicsForUpload()});
        };
    }
  }

}