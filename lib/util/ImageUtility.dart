import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image/image.dart' as img;

class Utility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
      width: 100,
      height: 100,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Future<String> base64StringFromFile(File tempImage) async {

   var bytes = tempImage.readAsBytesSync(); 
      return base64String(bytes);
    
  }
}

/*
 Uint8List _bytesImage;   
 File _image;
 String  base64Image;

Future<File> getImage() async {
     var image2 = await ImagePicker.pickImage(
      source: ImageSource.gallery,

      );
    List<int> imageBytes = image2.readAsBytesSync();
    print(imageBytes);
    base64Image = base64Encode(imageBytes);
    print('string is');
    print(base64Image);
    print("You selected gallery image : " + image2.path);

    _bytesImage = Base64Decoder().convert(base64Image);

    return im
    setState(() {

      _image=image2;

      });
}
*/
