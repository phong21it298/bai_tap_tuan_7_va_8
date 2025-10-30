import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'photo.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyProject08 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProject08State();
}

class _MyProject08State extends State<MyProject08> {

  final DBHelper _dbHelper = DBHelper();
  final ImagePicker _picker = ImagePicker();
  List<Photo> _photos = [];

  @override
  void initState() {
    super.initState();
    _refreshPhotos();
  }

  void _refreshPhotos() async {
    final photos = await _dbHelper.getPhotos();
    setState(() {
      _photos = photos;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 70);
    if (pickedFile != null) {
      final photo = Photo(path: pickedFile.path);
      await _dbHelper.insertPhoto(photo);
      _refreshPhotos();
    }
  }

  void _deletePhoto(int id) async {
    await _dbHelper.deletePhoto(id);
    _refreshPhotos();
  }

  void _showPickOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Photo Gallery')),
      body: _photos.isEmpty
          ? const Center(child: Text('No photos yet'))
          : GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          final photo = _photos[index];
          return GestureDetector(
            onLongPress: () => _deletePhoto(photo.id!),
            child: Image.file(
              File(photo.path),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPickOptions,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
