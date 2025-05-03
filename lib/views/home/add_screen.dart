import 'package:flutter/material.dart';
import 'package:bookpad/views/story_upload/story_upload_screen.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text("Write summary"),
            leading: Icon(Icons.edit_note),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => StoryUploadScreen(isStoryMode: false)));
            },
          ),
          ListTile(
            title: Text("Write new story"),
            leading: Icon(Icons.menu_book),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => StoryUploadScreen(isStoryMode: true)));
            },
          ),
          ListTile(
            title: Text("Add chapter"),
            leading: Icon(Icons.post_add),
          )
        ],
      ),
    );
  }
}
