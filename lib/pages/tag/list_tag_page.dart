import 'package:flutter/material.dart';
import '../models/tag_model.dart';
import '../../services/tag_service.dart';
import 'create_tag_page.dart';
import 'edit_tag_page.dart'; // Import halaman edit tag
import 'show_tag_page.dart'; // Import halaman show tag

class TagPage extends StatefulWidget {
  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  final TagService _tagService = TagService();
  Tag? _tag;

  @override
  void initState() {
    super.initState();
    _fetchTag();
  }

  void _fetchTag() async {
    Tag? tag = await _tagService.fetchTag();
    setState(() {
      _tag = tag;
    });
  }

  Future<void> _navigateToFormPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormTagPage()),
    );

    if (result == true) {
      _fetchTag();
    }
  }

  void _deleteTag(int id) async {
    bool deleted = await _tagService.deleteTag(id);
    if (deleted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tag berhasil dihapus')),
      );
      _fetchTag();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus tag')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tag'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _navigateToFormPage(context),
          ),
        ],
      ),
      body: _tag == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _tag!.data?.length ?? 0,
              itemBuilder: (context, index) {
                Data tag = _tag!.data![index];
                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tag.namaTag ?? 'Tidak Ada',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(tag.slug.toString()),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ShowTagPage(tag: tag),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditTagPage(tag: tag),
                                ),
                              ).then((result) {
                                if (result == true) {
                                  _fetchTag();
                                }
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteTag(tag.id!),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
