import 'package:bookpad/constants/custom_colors.dart';
import 'package:bookpad/models/story_model.dart';
import 'package:bookpad/services/firestore_services/story_service.dart';
import 'package:bookpad/views/story_detail/story_overview.dart';
import 'package:bookpad/views/story_detail/widgets/story_card.dart';
import 'package:flutter/material.dart';

class BookmarkScreen extends StatelessWidget {
  BookmarkScreen({super.key});

  final StoryService storyService = StoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmark"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder<List<StoryModel>> (
                stream: storyService.getBookmarkStories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No stories yet."));
                  }
                  final stories = snapshot.data!;
                  return GridView.builder(
                      itemCount: stories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = stories[index];
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => StoryOverview(storyData: data)));
                          },
                          child: StoryCard(title: data.title, summary: data.summary, date: data.createdAt, color: AppColors.mossGreen),
                        );
                      }
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
