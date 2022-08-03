import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(ImageSave());

class ImageSave extends StatefulWidget {
  @override
  _ImageSaveState createState() => _ImageSaveState();
}

class _ImageSaveState extends State<ImageSave> {
  File? _image;

  final picker = ImagePicker();

/*  _getImage() async
  {
    //ImageSource: camera
    XFile? imageFile = await picker.pickImage(source: ImageSource.camera);  //If there is no image selected, return.
    if (imageFile == null) return;
    //File created.
    File tmpFile = File(imageFile.path);
    //it gives path to a directory - path_provider package.
    final appDir = await getApplicationDocumentsDirectory();

    //filename - returns last part after the separator - path package.
    final fileName = basename(imageFile.path);
    //copy the file to the specified directory and return File instance.
    tmpFile = await tmpFile.copy('${appDir.path}/$fileName');
    //prints file location
    print('File path is :${tmpFile.path}');

    setState(() {
      _image = tmpFile;
    });
  }*/

  getImageCamera() async {
    final pickedimage =
        await ImagePicker.platform.getImage(source: ImageSource.camera);
    if (pickedimage != null) {
      setState(() {
        _image = File(pickedimage.path);
      });

      //Navigator.of(context).pop();
    }
  }
  //Photo From the gallery

  getImageGallery() async {
    final pickedimage =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      setState(() {
        _image = File(pickedimage.path);
      });

      //Navigator.of(context).pop();
    }
  }

  showBottomSheet(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Choose photo from",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await getImageCamera();
              },
              icon: const Icon(Icons.photo_camera),
            ),
            IconButton(
              onPressed: () async {
                await getImageGallery();
              },
              icon: const Icon(Icons.image),
            )
          ],
        );
      },
    );
  }
  //End Camera Function

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maik SPPA ',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Capture Image'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: _image != null
                  ? SizedBox(
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          _image!,
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No Image found'),
                    ),
            ),
            /**/ ElevatedButton(
              child: const Text('Capture and Store Image'),
              onPressed: getImageCamera,
            )
          ],
        ),
      ),
    );
  }
}
