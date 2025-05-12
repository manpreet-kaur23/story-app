import 'package:bookpad/constants/custom_colors.dart';
import 'package:bookpad/constants/format_date_time.dart';
import 'package:bookpad/models/bookmark_model.dart';
import 'package:bookpad/models/comment_model.dart';
import 'package:bookpad/models/story_model.dart';
import 'package:bookpad/services/firestore_services/chapter_service.dart';
import 'package:bookpad/services/firestore_services/comment_service.dart';
import 'package:bookpad/services/firestore_services/story_service.dart';
import 'package:bookpad/views/story_detail/widgets/popup_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StoryOverview extends StatefulWidget {
  final StoryModel storyData;
  const StoryOverview({super.key, required this.storyData});

  @override
  State<StoryOverview> createState() => _StoryOverviewState();
}

class _StoryOverviewState extends State<StoryOverview> {
  final commentController = TextEditingController();
  final StoryService storyService = StoryService();
  final ChapterService chapterService = ChapterService();
  final CommentService commentService = CommentService();
  final FormatDateTime format = FormatDateTime();
  User? user = FirebaseAuth.instance.currentUser;
  bool isBookmarked = false;
  int chapterCount = 0;

  @override
  void initState() {
    super.initState();
    storyService.isBookmarked(widget.storyData.storyId).then((value) {
      setState(() {
        isBookmarked = value;
      });
    });
    chapterService.getChapterCount(widget.storyData.storyId).then((value) {
      setState(() {
        chapterCount = value;
      });
    });
  }

  void toggleBookmark() {
    BookmarkModel bookmarkModel = BookmarkModel(userId: user!.uid, storyId: widget.storyData.storyId);
    storyService.bookmarkStory(bookmarkModel, isBookmarked, widget.storyData.storyId).whenComplete((){
      setState(() {
        isBookmarked = !isBookmarked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                // color: widget.color,
                color: AppColors.mossGreen,
                child: Column(
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30),
                            Row(
                              children: [
                                IconButton(onPressed: (){
                                  Navigator.pop(context);
                                }, icon: Icon(Icons.arrow_back_ios_rounded)),
                                Spacer(),
                                IconButton(onPressed: (){}, icon: Icon(Icons.star_border)),
                                IconButton(
                                  onPressed: toggleBookmark,
                                  icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
                                ),
                                CustomPopupMenu(storyData: widget.storyData)
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(widget.storyData.title,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.cream,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            FutureBuilder<String?>(
                              future: storyService.fetchStoryAuthorName(widget.storyData.authorId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text('Author', style: TextStyle(fontSize: 16));
                                }
                                return Text(
                                  snapshot.data!,
                                  style: TextStyle(fontSize: 16),
                                );
                              },
                            ),
                            Row(
                              children: [
                                Icon(Icons.star_border),
                                Text("${widget.storyData.likes.toString()} likes"),
                                Spacer(),
                                Icon(Icons.remove_red_eye_outlined),
                                Text("${widget.storyData.views.toString()} views"),
                                Spacer(),
                                Icon(Icons.book_outlined),
                                Text("$chapterCount chapters"),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(widget.storyData.summary,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(onPressed: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => ReadStory(fullStory: widget.storyData, color: widget.color)));
                            },
                                style: ElevatedButton.styleFrom(
                                    // backgroundColor: widget.color
                                ),
                                child: Text("Read full story",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      letterSpacing: 0.6
                                  ),
                                )),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Icon(Icons.comment_outlined),
                                SizedBox(width: 8),
                                Text("Viewer's thoughts",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            StreamBuilder<List<CommentModel>>(
                                stream: commentService.getStoryComments(widget.storyData.storyId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: Text("Loading..."),);
                                  }
                                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Center(child: Text("No comments yet."),);
                                  }
                                  final comments = snapshot.data!;
                                  return ListView.builder(
                                    itemCount: comments.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var data = comments[index];
                                      return ListTile(
                                        leading: Icon(Icons.person),
                                        title: Text(data.comment),
                                        subtitle: Text(format.formatDateTime(data.timestamp)),
                                      );
                                    });
                                },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    maxLines: 5,
                    minLines: 1,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      hintText: "Add a comment",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: (){
                      String? storyId = widget.storyData.storyId;
                      CommentModel model = CommentModel(userId: user!.uid, comment: commentController.text.trim(), timestamp: DateTime.now());
                      commentService.addStoryComment(storyId, model);
                      commentController.clear();
                    },
                    icon: Icon(Icons.send_outlined)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
