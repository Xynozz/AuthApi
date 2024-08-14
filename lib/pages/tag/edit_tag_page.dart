import 'package:flutter/material.dart';
import '../models/tag_model.dart';
import '../../services/tag_service.dart';

class EditTagPage extends StatefulWidget {
  final Data tag;

  EditTagPage({required this.tag});

  @override
  _EditTagPageState createState() => _EditTagPageState();
}

class _EditTagPageState extends State<EditTagPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaTagController = TextEditingController();
  final TagService _tagService = TagService();

  @override
  void initState() {
    super.initState();
    _namaTagController.text = widget.tag.namaTag ?? '';
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      bool success = await _tagService.updateTag(
        widget.tag.id!,
        _namaTagController.text,
      );
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tag berhasil diperbarui')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memperbarui tag')),
        );
      }
    }
  }

  @override
  void dispose() {
    _namaTagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit tag'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _namaTagController,
                decoration: InputDecoration(
                  labelText: 'Nama Tag',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama tag';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}