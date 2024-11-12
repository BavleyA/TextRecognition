import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognitionScreen extends StatefulWidget {
  const TextRecognitionScreen({super.key});

  @override
  State<TextRecognitionScreen> createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  File? _image;

  Future imagePicker(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      setState(() {
        _image = File(image.path);
      });
    }
    catch(error){
      if (kDebugMode) {
        print(error);

      }}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Recognition',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.grey,
              child: Center(
                child: _image == null ? Icon(
                  Icons.add_a_photo,
                  size: 50,
                ) : Image.file(_image!),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 50,
              color: Colors.deepPurple,
              child: MaterialButton(
                  onPressed: (){
                    imagePicker(ImageSource.camera);
                  },
                child: Text(
                  'Take a Photo',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 50,
              color: Colors.deepPurple,
              child: MaterialButton(
                onPressed: (){
                  imagePicker(ImageSource.gallery);
                },
                child: Text(
                  'Upload a Photo',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text('data will be shown here',
            style: TextStyle(
                fontSize: 25,
            ),
            ),
          ],
        ),
      ),
    );
  }
}
