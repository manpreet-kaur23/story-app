import 'package:bookpad/models/story_model.dart';
import 'package:bookpad/services/firestore_services/story_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomPopupMenu extends StatelessWidget {
  final StoryModel storyData;
  CustomPopupMenu({super.key, required this.storyData});

  final User? user = FirebaseAuth.instance.currentUser;
  final StoryService storyService = StoryService();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int> (
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              const Icon(Icons.share_outlined),
              SizedBox(width: 10,),
              const Text("Share")
            ],
          ),
        ),
        if (user!.uid != storyData.authorId)
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                const Icon(Icons.report, color: Colors.red),
                SizedBox(width: 10),
                const Text("Report", style: TextStyle(color: Colors.red))
              ],
            ),
          ),
        if (user!.uid == storyData.authorId)
          PopupMenuItem<int>(
            value: 3,
            child: Row(
              children: [
                const Icon(Icons.edit),
                SizedBox(width: 10),
                Text("Edit Story"),
              ],
            ),
          ),
        if (user!.uid == storyData.authorId)
          PopupMenuItem<int>(
            value: 4,
            child: Row(
              children: [
                const Icon(Icons.delete_outline, color: Colors.red),
                SizedBox(width: 10),
                Text("Delete Story", style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
      ],
      offset: const Offset(0, 50),
      elevation: 2,
      menuPadding: EdgeInsets.symmetric(horizontal: 10),
      onSelected: (value) {
        if (value == 1) {

        } else if (value == 2) {

        } else if (value == 3) {

        } else if (value == 4) {
          storyService.deleteStory(storyData.storyId).whenComplete((){
            Navigator.pop(context);
          });
        }
      },
    );
  }
}
