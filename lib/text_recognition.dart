import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognitionScreen extends StatefulWidget {
  const TextRecognitionScreen({super.key});

  @override
  State<TextRecognitionScreen> createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  File? _image;
  String text = '';

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

  Future textRecognition(File img) async{
    final inputImage = InputImage.fromFilePath(img.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    setState(() {
      text = recognizedText.text;
    });
    print(text);
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
      body: SingleChildScrollView(
        child: Padding(
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
                      imagePicker(ImageSource.camera).then((value){
                        if (_image != null) {
                          textRecognition(_image!);
                        }
                      });
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
                    imagePicker(ImageSource.gallery).then((value){
                      if(_image != null) {
                        textRecognition(_image!);
                      }
                    });
                  },
                  child: Text(
                    'Upload Photo From Gallery',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SelectableText(
                text == '' && _image != null ? 'Image has no Text' : text,
              style: TextStyle(
                  fontSize: 25,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
