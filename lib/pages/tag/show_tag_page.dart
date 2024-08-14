import 'package:flutter/material.dart';
import '../models/tag_model.dart';
import 'package:intl/intl.dart';

class ShowTagPage extends StatelessWidget {
  final Data tag;

  ShowTagPage({required this.tag});

  String formatDate(String? date) {
    if (date == null) return 'Tidak Tersedia';
    final DateTime dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat('d MMMM yyyy');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail tag'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.category, color: Colors.blue, size: 30),
                    SizedBox(width: 10),
                    Text(
                      tag.namaTag ?? 'Tidak Ada',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.link, color: Colors.grey),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Slug: ${tag.slug}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.grey),
                    SizedBox(width: 10),
                    Text(
                      'Created At: ${formatDate(tag.createdAt)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.update, color: Colors.grey),
                    SizedBox(width: 10),
                    Text(
                      'Updated At: ${formatDate(tag.updatedAt)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}