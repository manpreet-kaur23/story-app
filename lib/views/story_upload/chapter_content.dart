import 'package:bookpad/constants/format_date_time.dart';
import 'package:bookpad/views/story_upload/story_upload_screen.dart';
import 'package:flutter/material.dart';

class ChapterContent extends StatefulWidget {
  const ChapterContent({super.key});

  @override
  State<ChapterContent> createState() => _ChapterContentState();
}

class _ChapterContentState extends State<ChapterContent> {
  final storyTextController = TextEditingController();
  final titleController = TextEditingController();
  final FormatDateTime format = FormatDateTime();
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    storyTextController.addListener(() {
      setState(() {
        _charCount = storyTextController.text.length;
      });
    });
  }

  @override
  void dispose() {
    storyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write Story"),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.close_sharp)),
        actions: [
          IconButton(onPressed: (){
            //save as draft
          },
              tooltip: "Save as draft",
              icon: Icon(Icons.save)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              maxLines: null,
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Text(format.formatDateTime(DateTime.now()),
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
                Text("  |  $_charCount characters",
                  style: TextStyle(
                      color: Colors.grey
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 6, bottom: 20),
              child: TextField(
                maxLines: null,
                controller: storyTextController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    hintText: "What's on your mind",
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          ElevatedButton(
              onPressed: (){
                String enteredText = storyTextController.text.trim();
                if (_charCount > 200) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StoryUploadScreen(title: titleController.text.trim(), text: enteredText)));
                } else {
                  // show scaffold message.
                }
              },
              child: Text("Next",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6
                ),
              )
          ),
          SizedBox(height: 24)
        ],
      ),
    );
  }
}
