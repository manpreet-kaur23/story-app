import 'package:bookpad/constants/format_date_time.dart';
import 'package:flutter/material.dart';

class StoryCard extends StatelessWidget {
  final String title;
  final String summary;
  final DateTime date;
  final Color color;

  StoryCard({super.key, required this.title, required this.summary, required this.date, required this.color});

  final FormatDateTime format = FormatDateTime();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(summary,
            maxLines: 3,
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 8),
          Text('Created at: ${format.formatDateTime(date)}',
            style: TextStyle(
                fontSize: 12,
                color: Colors.black
            ),
          ),
        ],
      ),
    );
  }
}
