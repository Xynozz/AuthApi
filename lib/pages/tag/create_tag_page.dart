import 'package:flutter/material.dart';
import '../../services/tag_service.dart';

class FormTagPage extends StatefulWidget {
  @override
  _FormTagPageState createState() => _FormTagPageState();
}

class _FormTagPageState extends State<FormTagPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaTagController = TextEditingController();
  final TagService _tagService = TagService();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      bool success = await _tagService.storeTag(
        _namaTagController.text,
      );
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tag berhasil ditambahkan')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan tag')),
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
        title: Text('Tambah Tag'),
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
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}