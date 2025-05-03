import 'package:bookpad/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class StoryUploadScreen extends StatefulWidget {
  final bool isStoryMode;
  const StoryUploadScreen({super.key, required this.isStoryMode});

  @override
  State<StoryUploadScreen> createState() => _StoryUploadScreenState();
}

class _StoryUploadScreenState extends State<StoryUploadScreen> {
  final titleController = TextEditingController();
  final summaryController = TextEditingController();
  final tagsController = TextEditingController();
  bool isCompleted = false;
  var genreItems = ['Romance', 'Fantasy', 'Sci-Fi', 'Mystery', 'Thriller', 'Horror', 'Historical Fiction', 'Drama', 'Adventure', 'Action', 'Dystopian', 'Comedy'];
  String genre = 'Romance';
  final List<String> subgenresItems = ['Paranormal', 'Dark Fantasy', 'Psychological Thriller', 'Rom-Com', 'Gothic Fiction', 'LGBTQ+', 'Fanfiction'];
  late List<bool> subgenres;

  @override
  void initState() {
    super.initState();
    subgenres = List<bool>.filled(subgenresItems.length, false);
  }

  void _toggleSwitch(bool value) {
    setState(() {
      isCompleted = value;
    });
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
                    hintText: "Title",
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
                    hintText: "Summary",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: null,
                controller: tagsController,
                textAlign: TextAlign.justify,
                decoration: InputDecoration(
                    hintText: "Tags",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(" Main Genre :",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Spacer(),
                  DropdownMenu(
                    hintText: genre,
                    menuHeight: 350,
                    width: 250,
                    dropdownMenuEntries:
                    genreItems.map((String items) {
                      return DropdownMenuEntry(value: items, label: items);
                    }).toList(),
                    onSelected: (String? newValue) {
                      setState(() {
                        genre = newValue!;
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 20),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ToggleButtons(
                  isSelected: subgenres,
                  onPressed: (int index) {
                    setState(() {
                      subgenres[index] = !subgenres[index];
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  selectedBorderColor: AppColors.mossGreen,
                  selectedColor: Colors.white,
                  fillColor: AppColors.lime,
                  color: AppColors.mossGreen,
                  constraints: BoxConstraints(
                    minHeight: 40,
                    minWidth: 150,
                  ),
                  children: subgenresItems.map((items) => Text(items, style: TextStyle(fontWeight: FontWeight.bold),)).toList(),
                ),
              ),
              const SizedBox(height: 10),
              if (subgenres.contains(true))
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: List.generate(subgenresItems.length, (index) {
                    if (subgenres[index]) {
                      return Chip(
                        label: Text(subgenresItems[index]),
                        backgroundColor: Colors.deepPurple.shade100,
                        labelStyle: TextStyle(color: Colors.deepPurple.shade900),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
                ),

              if (widget.isStoryMode)
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
                    onPressed: (){
                      // widget.isStoryMode ? StoryContent() : AddSummary() ;
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
