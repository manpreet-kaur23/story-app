import 'package:bookpad/constants/custom_colors.dart';
import 'package:bookpad/models/chapter_model.dart';
import 'package:bookpad/models/story_model.dart';
import 'package:bookpad/services/firestore_services/chapter_service.dart';
import 'package:bookpad/services/firestore_services/story_service.dart';
import 'package:bookpad/views/story_upload/widgets/subgenres.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StoryUploadScreen extends StatefulWidget {
  final String? text;
  final String? title;
  const StoryUploadScreen({super.key, this.text, this.title});

  @override
  State<StoryUploadScreen> createState() => _StoryUploadScreenState();
}

class _StoryUploadScreenState extends State<StoryUploadScreen> {
  final StoryService storyService = StoryService();
  final ChapterService chapterService = ChapterService();
  final titleController = TextEditingController();
  final summaryController = TextEditingController();
  final tagsController = TextEditingController();
  bool isCompleted = false;
  var genreItems = ['Romance', 'Fantasy', 'Sci-Fi', 'Mystery', 'Thriller', 'Horror', 'Historical Fiction', 'Drama', 'Adventure', 'Action', 'Dystopian', 'Comedy'];
  String genre = 'Romance';
  final Subgenres subgenres = Subgenres();
  final List<String> subgenresItems = ['Paranormal', 'Dark Fantasy', 'Psychological Thriller', 'Rom-Com', 'Gothic Fiction', 'LGBTQ+', 'Fanfiction'];
  List<String> selectedSubgenres = [];

  void _toggleSwitch(bool value) {
    setState(() {
      isCompleted = value;
    });
  }

  Future<void> _uploadStory() async {
    User? user = FirebaseAuth.instance.currentUser;
    final List<String> tags = tagsController.text.trim().split(',');
    StoryModel storyModel = StoryModel(
        authorId: user!.uid,
        title: titleController.text.trim(),
        summary: summaryController.text.trim(),
        mainGenre: genre,
        subGenres: selectedSubgenres,
        tags: tags,
        isCompleted: isCompleted,
        createdAt: DateTime.now()
    );
    String? id = await storyService.addStoryToFirestore(storyModel);
    if (widget.text != null) {
      _uploadChapter(id!);
    }
  }

  Future<void> _uploadChapter(String id) {
    int chapterNo = 1;
    ChapterModel chapterModel = ChapterModel(chapterNumber: chapterNo, title: widget.title, content: widget.text, createdAt: DateTime.now());
    return chapterService.uploadChapterToFirestore(chapterModel, id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Center(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white10
                    ),
                    child: Center(
                      child: Text("Upload Image"),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: null,
                controller: titleController,
                decoration: InputDecoration(
                    label: Text("Title"),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: null,
                controller: summaryController,
                textCapitalization: TextCapitalization.sentences,
                textAlign: TextAlign.justify,
                decoration: InputDecoration(
                    label: Text("Summary"),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: null,
                controller: tagsController,
                textAlign: TextAlign.justify,
                decoration: InputDecoration(
                    label: Text("Tags"),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 20),
              DropdownMenu(
                label: Text("Main Genre"),
                menuHeight: 350,
                width: double.infinity,
                dropdownMenuEntries: genreItems.map((String items) {
                  return DropdownMenuEntry(value: items, label: items);
                }).toList(),
                onSelected: (String? newValue) {
                  setState(() {
                    genre = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Subgenres", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            final list = await subgenres.showSubgenrePopup(context, subgenresItems, selectedSubgenres);
                            setState(() {
                              selectedSubgenres = list;
                            });
                          },
                          child: Container(
                            width: 140,
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 24),
                                if (selectedSubgenres.isEmpty)
                                  Text("Add Subgenres", style: TextStyle(fontWeight: FontWeight.bold))
                                else
                                  Text("Edit Subgenres", style: TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    if (selectedSubgenres.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: selectedSubgenres.map((genres) => Chip(
                          label: Text(genres),
                        )).toList(),
                      ),
                  ],
                ),
              ),

              if (widget.text != null)
                Row(
                  children: [
                    Text(
                      "Story Completed",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 20),
                    Switch(
                      value: isCompleted,
                      onChanged: _toggleSwitch,
                      activeTrackColor: AppColors.lime,
                      activeColor: AppColors.mossGreen,
                    )
                  ],
                ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 50),
                child: ElevatedButton(
                    onPressed: () async {
                      await _uploadStory();
                      Navigator.pushNamedAndRemoveUntil(context, '/bottomBar', (route) => false);
                    },
                    child: Text("Upload Story",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
